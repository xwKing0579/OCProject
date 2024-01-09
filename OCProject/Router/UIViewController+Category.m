//
//  UIViewController+Category.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/4.
//

#import "UIViewController+Category.h"

@implementation UIViewController (Category)

- (BOOL)isForbidShot{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsForbidShot:(BOOL)isForbidShot{
    if ([self.view isKindOfClass:[UITabBarController class]] ||
        [self.view isKindOfClass:[UISplitViewController class]] ||
        [self.view isKindOfClass:[UINavigationController class]]) return;
    if (isForbidShot && [self.view isMemberOfClass:[UIView class]]) {
        UITextField *textField = [[UITextField alloc] initWithFrame:UIScreen.mainScreen.bounds];
        textField.secureTextEntry = YES;
        textField.subviews.firstObject.backgroundColor = self.view.backgroundColor;
        self.view = textField.subviews.firstObject;
        objc_setAssociatedObject(self, @selector(isForbidShot), @(isForbidShot), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

+ (__kindof UIViewController *)currentViewController{
    __block UIViewController *controller = nil;
    void (^block)(void) = ^{
        controller = [self topViewController:[self rootViewController]];
    };
    NSThread.isMainThread ? block() : dispatch_sync(dispatch_get_main_queue(), block);
    return controller;
}

+ (UIWindow *)window{
    __block UIWindow *window = nil;
    void (^block)(void) = ^{
        if (@available(iOS 13.0, *)) {
            NSSet *set = [UIApplication sharedApplication].connectedScenes;
            UIWindowScene *windowScene = [set anyObject];
            window = windowScene.windows.firstObject;
        }else{
            window = [UIApplication sharedApplication].delegate.window;
        }
    };
    NSThread.isMainThread ? block() : dispatch_sync(dispatch_get_main_queue(), block);
    return window;
}

+ (__kindof UIViewController *)rootViewController{
    __block UIViewController *controller = nil;
    void (^block)(void) = ^{
        controller = [self window].rootViewController;
    };
    NSThread.isMainThread ? block() : dispatch_sync(dispatch_get_main_queue(), block);
    return controller;
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

+ (CGFloat)statusBarHeight{
    return [self window].safeAreaInsets.top;
}
@end
