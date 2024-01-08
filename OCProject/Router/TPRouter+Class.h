//
//  TPRouter+Class.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/8.
//

#import "TPRouter.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPRouter (Class)
+ (NSString *)router;
+ (NSString *)routerClass;
+ (NSString *)routerJumpUrl;
+ (NSString *)routerJumpUrlParams;
+ (NSString *)routerBack;
+ (NSString *)routerBackUrl;

+ (NSString *)home;
+ (NSString *)homeKey;

+ (NSString *)web;
+ (NSString *)webKey;

+ (NSString *)mine;
+ (NSString *)mineKey;

+ (NSString *)routerParams;
+ (NSString *)routerParamsKey;

+ (NSString *)test;
+ (NSString *)testTableViewCell;
+ (NSString *)testTableViewCellClass;
+ (NSString *)testTableViewCellAlloc;


+ (void)routerEntry;
@end

NS_ASSUME_NONNULL_END
