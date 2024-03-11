//
//  TPRouter+Class.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/8.
//

#import "TPRouter.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPRouter (Class)

+ (NSString *)vc_home;
+ (NSString *)vc_ui;
+ (NSString *)vc_mine;
+ (NSString *)vc_web;

///演示路由页面
+ (NSString *)vc_router_params;

+ (NSString *)routerClass;
+ (NSString *)routerJumpUrl;
+ (NSString *)routerJumpUrlParams;


+ (void)routerEntry;
@end

NS_ASSUME_NONNULL_END
