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

NSString *const kTPRouterPathURLName = @"native";
NSString *const kTPRouterPathBackIndex = @"index";
NSString *const kTPRouterPathBackAnimation = @"animation";

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
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url];
    NSString *path = urlComponents.path;
    if (![path hasPrefix:kTPRouterPathURLName]) return nil;
    path = [path stringByReplacingOccurrencesOfString:kTPRouterPathURLName withString:@""];
    path = [path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSString *classString = [TPRouterModel classValue][path];
    Class class = NSClassFromString(classString);
    if (!class) return nil;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.value&&obj.name) {
            [params setObject:obj.value forKey:obj.name];
        }
    }];
    
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

+ (void)back{
    [self backUrl:nil];
}

+ (void)backUrl:(NSString * _Nullable)url{
    NSArray *keyValues = [url componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    for (NSString *obj in keyValues) {
        NSArray *temp = [obj componentsSeparatedByString:@"="];
        if (temp.count == 2) {
            [params setValue:temp.lastObject forKey:temp.firstObject];
        }
    }
    
    BOOL animation = YES;
    if (params[kTPRouterPathBackAnimation]) animation = params[kTPRouterPathBackAnimation];
    
    __kindof UIViewController *currentVC = UIViewController.currentViewController;
    if (currentVC.presentingViewController){
        [currentVC dismissViewControllerAnimated:animation completion:nil];
    }else{
        NSString *path = params[kTPRouterPathURLName];
        NSString *index = params[kTPRouterPathBackIndex];
        Class class = NSClassFromString([TPRouterModel classValue][path]);
        
        __kindof UINavigationController *nav = currentVC.navigationController;
        if (class == nil && index == nil) {
            [nav popViewControllerAnimated:animation];
        }else{
            __kindof UIViewController *toVc;
            NSInteger indexPath = [index integerValue];
            if (indexPath < nav.navigationController.viewControllers.count) toVc = nav.viewControllers[indexPath];
            
            for (UIViewController *controller in nav.viewControllers) {
                if ([controller isMemberOfClass:class]) {
                    toVc = controller;
                    break;
                }
            }
            
            toVc ? [nav popToViewController:toVc animated:animation] : [nav popToRootViewControllerAnimated:animation];
        }
    }
}

@end


@implementation TPRouterModel

+ (NSDictionary *)classValue {
    return @{};
}

@end
