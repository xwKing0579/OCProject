//
//  TPFluencyMonitor.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/20.
//

#import <Foundation/Foundation.h>
#import "TPMonitorModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPFluencyMonitor : NSObject

+ (void)start;
+ (void)stop;

+ (BOOL)isOn;

@end

NS_ASSUME_NONNULL_END
