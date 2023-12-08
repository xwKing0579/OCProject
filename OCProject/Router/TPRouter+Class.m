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
@end
