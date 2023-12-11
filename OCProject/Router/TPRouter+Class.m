//
//  TPRouter+Class.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/8.
//

#import "TPRouter+Class.h"

@implementation TPRouter (Class)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
+ (NSDictionary *)classValue{
    return @{[self testKey]:[self test],
             [self homeKey]:[self home],
             [self webKey] :[self web],
    };
}
#pragma clang diagnostic pop

///TPRouter
+ (NSString *)router{return @"TPRouter";}
+ (NSString *)routerClass{return @"TPRouter_Class";}
+ (NSString *)routerJumpUrl{return @"jumpUrl:";}
+ (NSString *)routerJumpUrlParams{return @"jumpUrl:params:";}
+ (NSString *)routerBack{return @"back";}
+ (NSString *)routerBackUrl{return @"backUrl:";}

///TPHomeViewController
+ (NSString *)homeKey{return @"home";}
+ (NSString *)home{return @"TPHomeViewController";}

///TPWebViewController
+ (NSString *)webKey{return @"web";}
+ (NSString *)web{return @"TPWebViewController";}


///TestViewController
+ (NSString *)testKey{return @"test";}
+ (NSString *)test{return @"TestViewController";}
+ (NSString *)testTableViewCell{return @"TestTableViewCell";}
+ (NSString *)testTableViewCellClass{return @"TestTableViewCell_Class";}
+ (NSString *)testTableViewCellAlloc{return @"initWithTableView:titleString:";}


///路由测试
+ (void)routerEntry{
   __block UIAlertController *alertController = [UIAlertController alertTitle:@"路由测试" message:nil cancel:@"取消" cancelBlock:^(NSString * _Nonnull cancel) {
       alertController = nil;
    } confirm:@"跳转" confirmBlock:^(NSUInteger index) {
        UITextField *textField = alertController.textFields.firstObject;
        [TPMediator performTarget:[self routerClass] action:[self routerJumpUrl] object:textField.text];
        alertController = nil;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入url";
    }];
    [UIViewController.currentViewController presentViewController:alertController animated:YES completion:nil];
}
@end
