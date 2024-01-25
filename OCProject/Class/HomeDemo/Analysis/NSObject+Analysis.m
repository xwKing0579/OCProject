//
//  NSObject+Analysis.m
//  OCProject
//
//  Created by 王祥伟 on 2024/1/10.
//

#import "NSObject+Analysis.h"


static NSMutableArray *_pagePathString;
@implementation NSObject (Analysis)

- (NSString *)originMethodString{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setOriginMethodString:(NSString *)originMethodString{
    objc_setAssociatedObject(self, @selector(originMethodString), originMethodString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _pagePathString = [NSMutableArray array];
        [UIControl swizzleInstanceMethod:@selector(sendAction:to:forEvent:)
                       withSwizzleMethod:@selector(analysis_sendAction:to:forEvent:)];
        [UIGestureRecognizer swizzleInstanceMethod:@selector(initWithTarget:action:)
                                 withSwizzleMethod:@selector(analysis_initWithTarget:action:)];
        [UITableView swizzleInstanceMethod:@selector(setDelegate:)
                         withSwizzleMethod:@selector(analysis_setDelegate:)];
        [UICollectionView swizzleInstanceMethod:@selector(setDelegate:)
                              withSwizzleMethod:@selector(analysis_setDelegate:)];
        [UIViewController swizzleInstanceMethod:@selector(viewDidLoad)
                              withSwizzleMethod:@selector(analysis_viewDidLoad)];
        [UIViewController swizzleInstanceMethod:@selector(viewWillAppear:)
                              withSwizzleMethod:@selector(analysis_viewWillAppear:)];
        [UIViewController swizzleInstanceMethod:@selector(viewDidAppear:)
                              withSwizzleMethod:@selector(analysis_viewDidAppear:)];
        [UIViewController swizzleInstanceMethod:@selector(viewWillDisappear:)
                              withSwizzleMethod:@selector(analysis_viewWillDisappear:)];
        [UIViewController swizzleInstanceMethod:@selector(viewDidDisappear:)
                              withSwizzleMethod:@selector(analysis_viewDidDisappear:)];
    });
}

- (void)analysis_viewDidLoad{
    [self analysis_viewDidLoad];
}

- (void)analysis_viewWillAppear:(BOOL)animated{
    [self analysis_viewWillAppear:animated];
    if ([self isEqual:UIViewController.currentViewController]){
        ///设置最大数
        if (_pagePathString.count > 1000) [_pagePathString removeObjectAtIndex:0];
        [_pagePathString addObject:NSStringFromClass([self class])];
    }
}

- (void)analysis_viewDidAppear:(BOOL)animated{
    [self analysis_viewDidAppear:animated];
}

- (void)analysis_viewWillDisappear:(BOOL)animated{
    [self analysis_viewWillDisappear:animated];
}

- (void)analysis_viewDidDisappear:(BOOL)animated{
    [self analysis_viewDidDisappear:animated];
}

- (void)analysis_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    [self analysis_sendAction:action to:target forEvent:event];
    [self analyzeUploadburiedPointsWithTarget:target clickView:(UIView *)self];
}

- (UIGestureRecognizer *)analysis_initWithTarget:(nullable id)target action:(nullable SEL)action{
    UIGestureRecognizer *recognizer = [self analysis_initWithTarget:target action:action];
    if (!target && !action) return recognizer;
    if ([target isKindOfClass:[UIScrollView class]]) return recognizer;

    [self exchangeSelector:action withSelector:@selector(analysis_gesture:) inClass:[target class]];
    return recognizer;
}

- (void)analysis_gesture:(UIGestureRecognizer *)gesture{
    SEL selector = NSSelectorFromString(gesture.originMethodString);
    if ([self respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:selector withObject:gesture];
#pragma clang diagnostic pop
    }
    [self analyzeUploadburiedPointsWithTarget:self clickView:gesture.view];
}

- (void)analysis_setGestureDelegate:(id)delegate{
    [self analysis_setGestureDelegate:delegate];
    NSObject *object = (NSObject *)delegate;
    
    SEL sel = @selector(tableView:didSelectRowAtIndexPath:);
    if ([object respondsToSelector:sel]){
        [object swizzleInstanceMethod:sel withSwizzleMethod:@selector(analysis_gesture:)];
    }
}

- (void)analysis_setDelegate:(id)delegate{
    [self analysis_setDelegate:delegate];
    
    SEL sel = [self isKindOfClass:[UITableView class]] ? @selector(tableView:didSelectRowAtIndexPath:) : @selector(collectionView:didSelectItemAtIndexPath:);
    NSObject *object = (NSObject *)delegate;
    if ([object respondsToSelector:sel]){
        [object swizzleInstanceMethod:sel withSwizzleMethod:@selector(analysis_listView:didSelectRowAtIndexPath:)];
    }
}

- (void)analysis_listView:(UIScrollView *)listView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self analysis_listView:listView didSelectRowAtIndexPath:indexPath];

    SEL sel = [listView isKindOfClass:[UITableView class]] ? @selector(cellForRowAtIndexPath:) : @selector(cellForItemAtIndexPath:);
    if ([listView respondsToSelector:sel])
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self analyzeUploadburiedPointsWithTarget:self clickView:[listView performSelector:sel withObject:indexPath]];
#pragma clang diagnostic pop
}

#pragma mark - public method
- (void)exchangeSelector:(SEL)sel withSelector:(SEL)selector inClass:(Class)class{
    NSString *methodString = [NSString stringWithFormat:@"%@_%@",class,[self class]];
    self.originMethodString = methodString;
    SEL methodSel = NSSelectorFromString(methodString);
    Method method = class_getInstanceMethod([self class], selector);
    if (class_addMethod(class, methodSel, method_getImplementation(method), method_getTypeEncoding(method))){
        method_exchangeImplementations(class_getInstanceMethod(class, sel), class_getInstanceMethod(class, methodSel));
    }
}

///埋点数据
- (void)analyzeUploadburiedPointsWithTarget:(nullable id)target clickView:(UIView *)clickView{
    ///思路 找到最近的数据源（viewcontroller、viewmodel、superview都可能含有变量存放我们需要的数据）
    ///比如TPAnalysisClickTableViewCell类中有clickButton这个属性，我们根据superview找到cell，然后通过valueforkey找到model
    ///这里根据实际业务区分处理即可
    
    Class class = NSClassFromString(@"TPAnalysisClickTableViewCell");
    if ([target isMemberOfClass:class] || [clickView isMemberOfClass:class]){
        UITableViewCell *cell = (UITableViewCell *)([target isMemberOfClass:class] ? target : clickView);
        
        NSObject *model = [cell valueForKey:@"model"];
        if (!model) return;
        
        NSIndexPath *indexPath = [(UITableView *)cell.superview indexPathForCell:cell];
        NSString *viewClass = [NSStringFromClass(clickView.class).lowercaseString stringByReplacingOccurrencesOfString:@"ui" withString:@""];
        NSMutableString *result = [NSMutableString stringWithFormat:@"埋点信息\n点击的是%@\nindex = %ld",viewClass,(long)indexPath.row];
        [model.propertyList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [result appendString:[NSString stringWithFormat:@"\n%@ = %@",obj.allKeys.firstObject,obj.allValues.firstObject]];
        }];
        
        //其他通用埋点，比如当前页面、时间、app信息、cpu&内存使用情况、用户信息等等...不一一列举了
        [result appendFormat:@"\ndate = %@",NSDate.currentTime];
        [result appendFormat:@"\npage = %@",NSStringFromClass(UIViewController.currentViewController.class)];
        
        [TPToastManager showText:result];
    }
}
@end
