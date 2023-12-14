//
//  TPAppInfoManager.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPAppInfoManager : NSObject

//app信息
+ (NSString *)appName;
+ (NSString *)appBundle;
+ (NSString *)appVersion;

//设备信息
+ (NSString *)deviceName;
+ (NSString *)deviceModel;
+ (NSString *)deviceSize;
+ (NSString *)systemVersion;
+ (NSString *)systemLanguage;

@end

NS_ASSUME_NONNULL_END
