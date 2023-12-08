//
//  TPRouter.m
//  OCProject
//
//  Created by 王祥伟 on 2023/11/29.
//

#import "TPRouter.h"
#import <UIKit/UIKit.h>
#import "UIViewController+Category.h"
#import "TPBaseNavigationController.h"
NSString *const kTPRouterPathURLName = @"native/";
NSString *const kTPRouterPathJumpStyle = @"present";
NSString *const kTPRouterPathNoAnimation = @"noanimation";

@implementation TPRouter

+ (id)jumpUrl:(NSString *)url{
    return [self jumpUrl:url params:nil];
}

+ (id)jumpUrl:(NSString *)url params:(NSDictionary * _Nullable )params{
    if (![url isKindOfClass:[NSString class]]) return nil;
    ///处理一些业务逻辑
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url];
    NSString *path = urlComponents.path;
    if (![path hasPrefix:kTPRouterPathURLName]) return nil;
    path = [path stringByReplacingOccurrencesOfString:kTPRouterPathURLName withString:@""];
    NSArray <NSString *>*temp = [path componentsSeparatedByString:@"/"];
    if (temp.count == 0) return nil;
    NSString *classString = [self classValue][temp.firstObject];
    if (!classString) classString = temp.firstObject;
    Class class = NSClassFromString(classString);
    if (!class) return nil;
    
    NSMutableDictionary *propertys = [NSMutableDictionary dictionaryWithDictionary:params];
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.value&&obj.name) {
            [propertys setObject:obj.value forKey:obj.name];
        }
    }];
    
    __kindof UIViewController *vc = [class yy_modelWithDictionary:propertys];
    if (!vc) return nil;
    __kindof UIViewController *currentVC = UIViewController.currentViewController;
    if (!currentVC) return nil;
    
    BOOL push = ![temp containsObject:kTPRouterPathJumpStyle];
    BOOL animation = ![temp containsObject:kTPRouterPathNoAnimation];
    
    if (push) {
        vc.hidesBottomBarWhenPushed = YES;
        [currentVC.navigationController pushViewController:vc animated:animation];
    }else{
        ///自定义nav
        Class navClass = NSClassFromString([propertys valueForKey:@"navigationController"]);
        __kindof UINavigationController *nav = [navClass alloc];
        if ([nav isKindOfClass:[UINavigationController class]]) {
            vc = [nav initWithRootViewController:vc];
        }
        ///自定义model
        if (![propertys valueForKey:@"modalPresentationStyle"]) {
            vc.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [currentVC presentViewController:vc animated:animation completion:nil];
    }
    
    return vc;
}

+ (void)back{
    [self backUrl:nil];
}

+ (void)backUrl:(NSString * _Nullable)url{
    NSArray <NSString *>*temp = [url componentsSeparatedByString:@"/"];
    
    BOOL animation = ![temp containsObject:kTPRouterPathNoAnimation];
    __kindof UIViewController *currentVC = UIViewController.currentViewController;
    if (!currentVC) return;
    
    if (currentVC.presentingViewController){
        [currentVC dismissViewControllerAnimated:animation completion:nil];
    }else{
        __kindof UINavigationController *nav = currentVC.navigationController;
        Class class = NSClassFromString([self classValue][temp.firstObject]);
        if (!class) {
            [nav popViewControllerAnimated:YES];
            return;
        }
        __kindof UIViewController *toVc;
        for (UIViewController *controller in nav.viewControllers) {
            if ([controller isMemberOfClass:class]) {
                toVc = controller;
                break;
            }
        }
        
        toVc ? [nav popToViewController:toVc animated:animation] : [nav popToRootViewControllerAnimated:animation];
    }
}


+ (NSDictionary *)classValue {
    return @{};
}

@end
