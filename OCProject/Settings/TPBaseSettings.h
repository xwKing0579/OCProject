//
//  TPBaseSettings.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,TPSettingState){
    TPSettingStateNotDetermined = 0,
    TPSettingStateRestricted,
    TPSettingStateDenied,
    TPSettingStateAuthorized,
    TPSettingStateLimited,
    TPSettingStateUnknown,
};

@interface TPBaseSettings : NSObject

+ (BOOL)isAuthorized;

+ (void)requestAuthorization:(void(^)(TPSettingState state,NSDictionary *info))completion;

@end

NS_ASSUME_NONNULL_END
