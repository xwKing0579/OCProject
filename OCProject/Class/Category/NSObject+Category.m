//
//  NSObject+Category.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/12.
//

#import "NSObject+Category.h"

NSString *const kNSObjectClassObjectName = @"_Class";
NSString *const kNSObjectActionObjectName = @"object";

@implementation NSObject (Category)

+ (void)swizzleClassMethod:(SEL)originSelector withSwizzleMethod:(SEL)swizzleSelector{
    swizzleClassMethod(self.class, originSelector, swizzleSelector);
}

- (void)swizzleInstanceMethod:(SEL)originSelector withSwizzleMethod:(SEL)swizzleSelector{
    swizzleInstanceMethod(self.class, originSelector, swizzleSelector);
}

static void swizzleClassMethod(Class cls, SEL originSelector, SEL swizzleSelector){
    if (!class_isMetaClass(object_getClass(cls))) {
        return;
    }

    Method originalMethod = class_getClassMethod(cls, originSelector);
    Method swizzledMethod = class_getClassMethod(cls, swizzleSelector);
    
    Class metacls = objc_getMetaClass(NSStringFromClass(cls).UTF8String);
    if (class_addMethod(metacls,
                        originSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod))) {
        /* swizzing super class method, added if not exist */
        class_replaceMethod(metacls,
                            swizzleSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }else{
        /* swizzleMethod maybe belong to super */
        class_replaceMethod(metacls,
                            swizzleSelector,
                            class_replaceMethod(metacls,
                                                originSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod)),
                            method_getTypeEncoding(originalMethod));
    }
}

static void swizzleInstanceMethod(Class cls, SEL originSelector, SEL swizzleSelector){
    if (!class_isMetaClass(object_getClass(cls))) {
        return;
    }
    
    /* if current class not exist selector, then get super*/
    Method originalMethod = class_getInstanceMethod(cls, originSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzleSelector);
    
    /* add selector if not exist, implement append with method */
    if (class_addMethod(cls,
                        originSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        /* replace class instance method, added if selector not exist */
        /* for class cluster , it always add new selector here */
        class_replaceMethod(cls,
                            swizzleSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    } else {
        /* swizzleMethod maybe belong to super */
        class_replaceMethod(cls,
                            swizzleSelector,
                            class_replaceMethod(cls,
                                                originSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod)),
                            method_getTypeEncoding(originalMethod));
    }
}

- (NSArray <NSDictionary *>*)propertyList{
    NSMutableArray *propertyArray = [NSMutableArray array];
    NSMutableArray *keys = [NSMutableArray array];
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList(self.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        if ([keys containsObject:key]) continue;
        id value = [self performAction:key];
        if (value) {
            [keys addObject:key];
            [propertyArray addObject:@{key:value}];
        }
    }
    free(properties);
    return propertyArray;
}

- (NSArray <NSDictionary *>*)customPropertyList:(NSArray <NSString *>*)properties{
    NSMutableArray *propertyArray = [NSMutableArray array];
    for (NSString *key in properties) {
        id value = [self performAction:key];
        ///特殊处理非对象类型数据
    
        if ([key isEqualToString:@"borderColor"]){
            value = [UIColor colorWithCGColor:(__bridge CGColorRef _Nonnull)([self valueForKey:key])];
        }
        if (!value) continue;
        if ([value isKindOfClass:[UIColor class]]) {
            UIColor *color = (UIColor *)value;
            [propertyArray addObject:@{key:[color hexStringWithAlpha:YES]}];
        }else{
            [propertyArray addObject:@{key:value}];
        }
    }
    return propertyArray;
}

- (id)performAction:(NSString *)action{
    return [self performAction:action object:@{}];
}

- (id)performAction:(NSString *)action object:(NSDictionary * __nullable)object{
    return [self performAction:action object:object object:nil];
}

- (id)performAction:(NSString *)action object:(id __nullable)object1 object:(id __nullable)object2{
    NSMutableDictionary *objects = [NSMutableDictionary dictionary];
    [objects setValue:object1 forKey:[kNSObjectActionObjectName stringByAppendingString:@"1"]];
    [objects setValue:object2 forKey:[kNSObjectActionObjectName stringByAppendingString:@"2"]];
    return [self performAction:action objects:objects];
}

- (id)performAction:(NSString *)action objects:(NSDictionary * __nullable)objects{
    SEL sel = NSSelectorFromString(action);
    if ([self respondsToSelector:sel]){
        return [NSObject safePerformTarget:self selector:sel objects:objects];
    }
    return nil;
}


+ (id)performAction:(NSString *)action{
    return [self performAction:action object:nil];
}

+ (id)performAction:(NSString *)action object:(NSDictionary * __nullable)object{
    return [self performAction:action object:object object:nil];
}

+ (id)performAction:(NSString *)action object:(id __nullable)object1 object:(id __nullable)object2{
    NSMutableDictionary *objects = [NSMutableDictionary dictionary];
    [objects setValue:object1 forKey:[kNSObjectActionObjectName stringByAppendingString:@"1"]];
    [objects setValue:object2 forKey:[kNSObjectActionObjectName stringByAppendingString:@"2"]];
    return [self performAction:action objects:objects];
}

+ (id)performAction:(NSString *)action objects:(NSDictionary * __nullable)objects{
    SEL sel = NSSelectorFromString(action);
    if ([self respondsToSelector:sel]){
        return [self safePerformTarget:self selector:sel objects:objects];
    }
    return nil;
}

#pragma mark - public methods
+ (id)performTarget:(NSString *)target action:(NSString *)action {
    return [self performTarget:target action:action objects:@{}];
}

+ (id)performTarget:(NSString *)target action:(NSString *)action object:(id __nullable)object {
    return [self performTarget:target action:action object:object object:@{}];
}

+ (id)performTarget:(NSString *)target action:(NSString *)action object:(id __nullable)object1 object:(id __nullable)object2{
    NSMutableDictionary *objects = [NSMutableDictionary dictionary];
    [objects setValue:object1 forKey:[kNSObjectActionObjectName stringByAppendingString:@"1"]];
    [objects setValue:object2 forKey:[kNSObjectActionObjectName stringByAppendingString:@"2"]];
    return [self performTarget:target action:action objects:objects];
}

+ (id)performTarget:(NSString *)target action:(NSString *)action objects:(NSDictionary * __nullable)objects{
    if (!(target && action)) return nil;
    
    id targetObject = nil;
    if ([target hasSuffix:kNSObjectClassObjectName]) {
        targetObject = NSClassFromString([target stringByReplacingOccurrencesOfString:kNSObjectClassObjectName withString:@""]);
    }else{
        targetObject = [[NSClassFromString(target) alloc] init];
    }
    
    SEL selector = NSSelectorFromString(action);

    if ([targetObject respondsToSelector:selector]) {
        return [self safePerformTarget:targetObject selector:selector objects:objects];
    }else{
        [self noTarget:target action:action targetObject:targetObject];
        return nil;
    }
}

+ (id)safePerformTarget:(id)target selector:(SEL)selector objects:(NSDictionary * __nullable)objects{
    NSMethodSignature *methodSig = [target methodSignatureForSelector:selector];
    if(methodSig == nil) {
        return nil;
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
    [invocation setSelector:selector];
    [invocation setTarget:target];
    NSArray *allkeys = objects.allKeys;
    for (NSString *key in allkeys) {
        if ([key hasPrefix:kNSObjectActionObjectName]) {
            NSUInteger idx = [[key stringByReplacingOccurrencesOfString:kNSObjectActionObjectName withString:@""] intValue] + 1;
            if (methodSig.numberOfArguments > idx) {
                id obj = objects[key];
                [invocation setArgument:&obj atIndex:idx];
            }
        }
    }
    [invocation invoke];
    
    const char *retType = [methodSig methodReturnType];
    if (strcmp(methodSig.methodReturnType, "@") == 0) {
        void *result = NULL;
        [invocation getReturnValue:&result];
        return (__bridge id)(result);
    }else if (strcmp(retType, @encode(NSInteger)) == 0) {
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }else if (strcmp(retType, @encode(BOOL)) == 0){
        BOOL result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }else if (strcmp(retType, @encode(CGFloat)) == 0){
        CGFloat result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }else if (strcmp(retType, @encode(NSUInteger)) == 0){
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }else if (strcmp(retType, @encode(void)) == 0){
        return nil;
    }
    NSLog(@"++++++++++++++++++++未知类型，如果需要后面可以添加上去++++++++++++++++++++");
    return nil;
}

#pragma mark - private methods
+ (void)noTarget:(NSString *)target action:(NSString *)action targetObject:(id)targetObject{
    if (targetObject) {
        if ([target hasSuffix:kNSObjectClassObjectName]) {
            target = [target stringByReplacingOccurrencesOfString:kNSObjectClassObjectName withString:@""];
            NSLog(@"%@", [NSString stringWithFormat:@"Method not found，请检查类<%@>中类方法<%@>是否存在",target,action]);
        }else{
            NSLog(@"%@", [NSString stringWithFormat:@"Method not found，请检查类<%@>中实例方法<%@>是否存在",target,action]);
        }
    }else{
        if ([target hasSuffix:kNSObjectClassObjectName]) {
            target = [target stringByReplacingOccurrencesOfString:kNSObjectClassObjectName withString:@""];
        }
        NSLog(@"%@", [NSString stringWithFormat:@"target not found，请检查类<%@>是否存在",target]);
    }
}
@end
