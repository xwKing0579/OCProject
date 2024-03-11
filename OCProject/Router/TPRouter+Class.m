//
//  TPRouter+Class.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/8.
//

#import "TPRouter+Class.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation TPRouter (Class)
#pragma clang diagnostic pop

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
+ (NSDictionary *)classValue{
    return @{
        self.vc_home:@"TPHomeViewController",
        self.vc_ui:@"TPUIViewController",
        self.vc_mine:@"TPMineViewController",
        self.vc_web:@"TPWebViewController",
        self.vc_router_params:@"TPRouterParamsViewController",
    };
}
#pragma clang diagnostic pop

+ (BOOL)resolveClassMethod:(SEL)selector{
    NSString *string = NSStringFromSelector(selector);
    if ([string hasPrefix:@"vc_"]) {
        Method method = class_getClassMethod([self class],@selector(viewControllerClassAbbreviatedString));
        Class metacls = objc_getMetaClass(NSStringFromClass([self class]).UTF8String);
        class_addMethod(metacls,selector,method_getImplementation(method),method_getTypeEncoding(method));
        return YES;
    }
    return [super resolveClassMethod:selector];
}

+ (NSString *)viewControllerClassAbbreviatedString{
    return NSStringFromSelector(_cmd);
}

+ (NSString *)routerClass{return @"TPRouter_Class";}
+ (NSString *)routerJumpUrl{return @"jumpUrl:";}
+ (NSString *)routerJumpUrlParams{return @"jumpUrl:params:";}


///路由测试
+ (void)routerEntry{
   __block UIAlertController *alertController = [UIAlertController alertTitle:@"路由测试" message:nil cancel:@"取消" cancelBlock:^(NSString * _Nonnull cancel) {
       alertController = nil;
    } confirm:@"跳转" confirmBlock:^(NSUInteger index) {
        UITextField *textField = alertController.textFields.firstObject;
        [NSObject performTarget:[self routerClass] action:[self routerJumpUrl] object:textField.text];
        alertController = nil;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入url";
    }];
    [UIViewController.currentViewController presentViewController:alertController animated:YES completion:nil];
}
@end
