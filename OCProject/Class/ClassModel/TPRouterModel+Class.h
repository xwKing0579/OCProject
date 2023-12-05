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

+ (NSString *)test;
+ (NSString *)testTableViewCell;
+ (NSString *)testTableViewCellClass;
+ (NSString *)testTableViewCellAlloc;

+ (NSString *)home;
+ (NSString *)homeKey;
@end

NS_ASSUME_NONNULL_END
