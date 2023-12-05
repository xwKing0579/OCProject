//
//  TPRouter.m
//  OCProject
//
//  Created by 王祥伟 on 2023/11/29.
//

#import "TPRouter.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "UIViewController+Category.h"

NSString *const kTPRouterPathURLName = @"url";
NSString *const kTPRouterPathBackIndex = @"index";

@implementation TPRouter

+ (id)jumpUrl:(NSString *)url{
    return [self jumpUrl:url withModel:nil];
}

+ (id)jumpUrl:(NSString *)url withModel:(TPRouterModel * _Nullable )model{
    if (!model) {
        model = [[TPRouterModel alloc] init];
        model.push = YES;
        model.animation = YES;
    }
    
    ///处理一些业务逻辑
    
    NSRange range = [url rangeOfString:kTPRouterPathURLName];
    if (range.location == NSNotFound) return nil;
    
    NSString *paramUrl = [url substringFromIndex:range.location];
    NSMutableDictionary *params = [self paramsFromUrl:paramUrl];
    NSString *className = params[kTPRouterPathURLName];
    NSString *classString = [TPRouterModel classValue][className];
    Class class = NSClassFromString(classString);
    if (class) {
        __kindof UIViewController *vc = [class new];
        unsigned int outCount = 0;
        objc_property_t *properties = class_copyPropertyList(class, &outCount);
        if (properties) {
            for (int i = 0; i < outCount; i++) {
                objc_property_t property = properties[i];
                NSString *key = [NSString stringWithUTF8String:property_getName(property)];
                NSString *param = params[key];
                if (param != nil) {
                    [vc setValue:param forKey:key];
                }
            }
            free(properties);
        }
        
        __kindof UIViewController *currentVC = UIViewController.currentViewController;
        if (model.push) {
            vc.hidesBottomBarWhenPushed = YES;
            [currentVC.navigationController pushViewController:vc animated:model.animation];
        }else{
            [currentVC presentViewController:vc animated:model.animation completion:nil];
        }
        
        return vc;
    }
    return nil;
}

+ (void)back{
    [self backUrl:nil];
}

+ (void)backUrl:(NSString * _Nullable)url{
    [self backUrl:url withModel:nil];
}

+ (void)backUrl:(NSString * _Nullable)url withModel:(TPRouterModel * _Nullable )model{
    if (!model) {
        model = [[TPRouterModel alloc] init];
        model.push = YES;
        model.animation = YES;
    }
    
    __kindof UIViewController *currentVC = UIViewController.currentViewController;
    if (currentVC.presentingViewController){
        [currentVC dismissViewControllerAnimated:model.animation completion:nil];
    }else{
        NSRange range = [url rangeOfString:kTPRouterPathURLName];
        __kindof UINavigationController *nav = currentVC.navigationController;
        if (nav.viewControllers.count < 2) return;
        
        if (range.location == NSNotFound) {
            [nav popViewControllerAnimated:model.animation];
        }else{
            NSString *paramUrl = [url substringFromIndex:range.location];
            NSMutableDictionary *params = [self paramsFromUrl:paramUrl];
            NSString *className = params[kTPRouterPathURLName];
            NSString *classString = [TPRouterModel classValue][className];
            NSInteger index = [params[kTPRouterPathBackIndex] integerValue];
            Class class = NSClassFromString(classString);
            
            __kindof UIViewController *toVc;
            if (index < nav.viewControllers.count){
                toVc = nav.viewControllers[index];
            }else{
                for (UIViewController *controller in nav.viewControllers) {
                    if ([controller isMemberOfClass:class]) {
                        toVc = controller;
                        break;
                    }
                }
            }
            
            if (toVc && ![toVc isEqual:currentVC]) {
                [nav popToViewController:toVc animated:model.animation];
            }else{
                [nav popToRootViewControllerAnimated:model.animation];
            }
        }
    }
}

+ (NSMutableDictionary *)paramsFromUrl:(NSString *)url{
    NSArray *keyValues = [url componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    for (NSString *obj in keyValues) {
        NSArray *temp = [obj componentsSeparatedByString:@"="];
        if (temp.count == 2) {
            [params setValue:temp.lastObject forKey:temp.firstObject];
        }
    }
    return params;
}

@end


@implementation TPRouterModel

+ (NSDictionary *)classValue {
    return @{};
}

@end
