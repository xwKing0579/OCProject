//
//  TPRouterModel+Class.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/1.
//

#import "TPRouterModel+Class.h"
#import <objc/runtime.h>

@implementation TPRouterModel (Class)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
+ (NSDictionary *)classValue{
    return @{[self test]:[self testKey],
             [self home]:[self homeKey],
    };
}
#pragma clang diagnostic pop

+ (NSString *)router{return @"TPRouter";}
+ (NSString *)routerClass{return @"TPRouter_Class";}
+ (NSString *)routerJumpUrl{return @"jumpUrl:";}
+ (NSString *)routerJumpUrlWithModel{return @"jumpUrl:withModel:";}

+ (NSString *)test{return @"test";}
+ (NSString *)testKey{return @"TestViewController";}
+ (NSString *)testTableViewCell{return @"TestTableViewCell";}
+ (NSString *)testTableViewCellClass{return @"TestTableViewCell_Class";}
+ (NSString *)testTableViewCellAlloc{return @"initWithTableView:titleString:";}

+ (NSString *)home{return @"home";}
+ (NSString *)homeKey{return @"TPHomeViewController";}
@end
