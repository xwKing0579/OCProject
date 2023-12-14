//
//  UIViewController+Category.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/4.
//

#import "UIViewController+Category.h"

@implementation UIViewController (Category)

+ (__kindof UIViewController *)currentViewController{
    return [self topViewController:[self rootViewController]];
}

+ (UIWindow *)window{
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window;
    }else{
        return [UIApplication sharedApplication].delegate.window;
    }
}

+ (__kindof UIViewController *)rootViewController{
    return [self window].rootViewController;
}

+ (__kindof UIViewController *)topViewController:(UIViewController *)vc{
    if (vc.presentedViewController && ![vc.presentedViewController isKindOfClass:[UIAlertController class]]) {
        return [self topViewController:vc.presentedViewController];
    }else if ([vc isKindOfClass:[UISplitViewController class]]){
        UISplitViewController *tmp = (UISplitViewController *)vc;
        return tmp.viewControllers.count?[self topViewController:tmp.viewControllers.lastObject]:vc;
    }else if ([vc isKindOfClass:[UINavigationController class]]){
        UINavigationController *tmp = (UINavigationController *)vc;
        return tmp.viewControllers.count?[self topViewController:tmp.topViewController]:vc;
    }else if ([vc isKindOfClass:[UITabBarController class]]){
        UITabBarController *tmp = (UITabBarController *)vc;
        return tmp.viewControllers.count?[self topViewController:tmp.selectedViewController]:vc;
    }
    return vc;
}

@end
