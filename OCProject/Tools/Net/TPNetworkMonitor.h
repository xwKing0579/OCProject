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


+ (NSArray <TPNetworkModel *>*)data;

@end

NS_ASSUME_NONNULL_END
