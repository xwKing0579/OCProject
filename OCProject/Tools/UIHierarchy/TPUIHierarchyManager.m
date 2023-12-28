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
    [NSObject performTarget:@"TPDebugTool_Class" action:@"didChangeUIHierarchy"];
}

+ (void)stop{
    [[NSUserDefaults standardUserDefaults] setValue:@(NO) forKey:kTPUIHierarchyConfigKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [NSObject performTarget:@"TPDebugTool_Class" action:@"didChangeUIHierarchy"];
}

+ (BOOL)isOn{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:kTPUIHierarchyConfigKey] boolValue];
}

+ (TPUIHierarchyModel *)viewUIHierarchy:(id)obj{
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
        UIResponder *responder = subview.nextResponder;
        if (!next && [responder isKindOfClass:[UIViewController class]]){
            model.objectClass = NSStringFromClass([responder class]);
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

+ (TPUIHierarchyModel *)viewControllers{
    return [self getViewControllers:@[UIViewController.rootViewController] withViewDeepLevel:0].firstObject;
}

+ (NSArray <TPUIHierarchyModel *>*)getViewControllers:(NSArray <__kindof UIViewController *>*)vcs withViewDeepLevel:(int)deepLevel{
    NSMutableArray *array = [NSMutableArray array];
    for (UIViewController *vc in vcs) {
        TPUIHierarchyModel *model = [TPUIHierarchyModel new];
        model.deepLevel = deepLevel+1;
        model.objectClass = NSStringFromClass([vc class]);
        model.haveSubviews = vc.childViewControllers.count;
        model.isController = YES;
        model.objectPtr = (uintptr_t)vc.nextResponder;
        model.subviews = [self getViewControllers:vc.childViewControllers withViewDeepLevel:model.deepLevel];
        [array addObject:model];
    }
    return array;
}

@end
