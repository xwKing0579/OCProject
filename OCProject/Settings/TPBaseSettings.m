//
//  TPBaseSettings.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/6.
//

#import "TPBaseSettings.h"

@implementation TPBaseSettings
+ (BOOL)isAuthorized{
    return NO;
}

+ (void)requestAuthorization:(void(^)(TPSettingState state,NSDictionary *info))completion{
    completion(TPSettingStateUnknown,nil);
}

@end
