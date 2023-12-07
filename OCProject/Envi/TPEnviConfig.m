//
//  TPEnviConfig.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/6.
//

#import "TPEnviConfig.h"

NSString *const kTPEnviConfigNetworkKey = @"kTPEnviConfigNetworkKey";
@implementation TPEnviConfig


+ (TPSchemeEnvi)envi{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *envi = [userDefaults valueForKey:kTPEnviConfigNetworkKey];
    if (envi == nil){
        envi = @(TPSchemeEnviDev);
        [userDefaults setValue:envi forKey:kTPEnviConfigNetworkKey];
        [userDefaults synchronize];
    }
    return (TPSchemeEnvi)envi.integerValue;
}

@end
