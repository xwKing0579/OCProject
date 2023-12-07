//
//  TPRouterModel+Class.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/1.
//

#import "TPRouter.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPRouterModel (Class)

+ (NSString *)router;
+ (NSString *)routerClass;
+ (NSString *)routerJumpUrl;
+ (NSString *)routerJumpUrlWithModel;
+ (NSString *)back;
+ (NSString *)backUrl;

+ (NSString *)home;
+ (NSString *)homeKey;

+ (NSString *)web;
+ (NSString *)webKey;

+ (NSString *)test;
+ (NSString *)testTableViewCell;
+ (NSString *)testTableViewCellClass;
+ (NSString *)testTableViewCellAlloc;
@end

NS_ASSUME_NONNULL_END
