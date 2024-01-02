//
//  TPNetworkMonitor.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/29.
//

#import <Foundation/Foundation.h>
#import "TPNetworkModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPNetworkMonitor : NSObject
+ (void)start;
+ (void)stop;

+ (BOOL)isOn;

+ (NSArray <TPNetworkModel *>*)data;

@end

NS_ASSUME_NONNULL_END
