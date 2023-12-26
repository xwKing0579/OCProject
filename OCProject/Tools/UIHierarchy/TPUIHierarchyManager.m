//
//  TPUIHierarchyManager.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/25.
//

#import "TPUIHierarchyManager.h"
NSString *const kTPUIHierarchyConfigKey = @"kTPUIHierarchyConfigKey";
NSString *const kTPUIHierarchyNotification = @"kTPUIHierarchyNotification";
@implementation TPUIHierarchyManager

+ (void)start{
    [[NSUserDefaults standardUserDefaults] setValue:@(YES) forKey:kTPUIHierarchyConfigKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [TPMediator performTarget:@"TPDebugTool_Class" action:@"didChangeUIHierarchy"];
}

+ (void)stop{
    [[NSUserDefaults standardUserDefaults] setValue:@(NO) forKey:kTPUIHierarchyConfigKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [TPMediator performTarget:@"TPDebugTool_Class" action:@"didChangeUIHierarchy"];
}

+ (BOOL)isOn{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:kTPUIHierarchyConfigKey] boolValue] ?: NO;
}

+ (TPUIHierarchyModel *)currentUIHierarchy:(id)obj{
    if (!obj) return nil;
    UIView *view = nil;
    if ([obj isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)obj;
        view = vc.view;
    }else if ([obj isKindOfClass:[UIView class]]){
        view = obj;
    }
    if (!view) return nil;
    return [self getSubviewsFromViews:@[view] withViewDeepLevel:0 next:NO].firstObject;
}

+ (NSArray <TPUIHierarchyModel *>*)getSubviewsFromViews:(NSArray <UIView *>*)views withViewDeepLevel:(int)deepLevel next:(BOOL)next{
    NSMutableArray *array = [NSMutableArray array];
    for (UIView *subview in views.reverseObjectEnumerator) {
        TPUIHierarchyModel *model = [TPUIHierarchyModel new];
        model.deepLevel = deepLevel+1;
        if (!next && [subview.nextResponder isKindOfClass:[UIViewController class]]){
            model.objectClass = NSStringFromClass([subview.nextResponder class]);
            model.haveSubviews = YES;
            model.isController = YES;
            model.objectPtr = (uintptr_t)subview.nextResponder;
            model.subviews = [self getSubviewsFromViews:@[subview] withViewDeepLevel:model.deepLevel next:YES];
        }else{
            model.objectClass = NSStringFromClass([subview class]);
            model.haveSubviews = subview.subviews.count;
            model.objectPtr = (uintptr_t)subview;
            model.subviews = [self getSubviewsFromViews:subview.subviews withViewDeepLevel:model.deepLevel next:NO];
        }
        [array addObject:model];
    }
    return array;
}

@end
