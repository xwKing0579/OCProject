//
//  TPRouter.h
//  OCProject
//
//  Created by 王祥伟 on 2023/11/29.
//

#import <Foundation/Foundation.h>

@class TPRouter;

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString *const kTPRouterPathURLName;
FOUNDATION_EXTERN NSString *const kTPRouterPathJumpStyle;
FOUNDATION_EXTERN NSString *const kTPRouterPathNoAnimation;

@interface TPRouter : NSObject

+ (id)jumpUrl:(NSString *)url;
+ (id)jumpUrl:(NSString *)url params:(NSDictionary * _Nullable )params;

+ (void)back;
+ (void)backUrl:(NSString * _Nullable)url; ///home/noanimation/index_1

///自定义页面参数
+ (NSDictionary *)classValue;
@end


NS_ASSUME_NONNULL_END
