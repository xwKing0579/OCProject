//
//  TPRouter.h
//  OCProject
//
//  Created by 王祥伟 on 2023/11/29.
//

#import <Foundation/Foundation.h>

@class TPRouterModel;

NS_ASSUME_NONNULL_BEGIN

@interface TPRouter : NSObject

+ (id)jumpUrl:(NSString *)url;
+ (id)jumpUrl:(NSString *)url withModel:(TPRouterModel * _Nullable )model;

+ (void)back;
+ (void)backUrl:(NSString * _Nullable)url; //native=home&animation=1

@end



@interface TPRouterModel : NSObject

@property (nonatomic, assign) BOOL push;
@property (nonatomic, assign) BOOL animation;
@property (nonatomic, strong) NSDictionary *params;

///自定义页面参数
+ (NSDictionary *)classValue;

@end

NS_ASSUME_NONNULL_END
