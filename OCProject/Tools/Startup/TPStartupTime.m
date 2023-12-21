//
//  TPStartupTime.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/20.
//

#import "TPStartupTime.h"
#import <mach/mach_time.h>

static uint64_t loadTime;
static uint64_t applicationRespondedTime = -1;
static mach_timebase_info_data_t timebaseInfo;
NSString *const kTPStartupTimeKey = @"kTPStartupTimeKey";

static inline NSTimeInterval MachTimeToSeconds(uint64_t machTime) {
    return ((machTime / 1e9) * timebaseInfo.numer) / timebaseInfo.denom;
}

@implementation TPStartupTime

+ (void)load {
#ifdef DEBUG
    loadTime = mach_absolute_time();
    mach_timebase_info(&timebaseInfo);
    
    @autoreleasepool {
        __block id<NSObject> obs;
        obs = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
            dispatch_async(dispatch_get_main_queue(), ^{
                applicationRespondedTime = mach_absolute_time();
                NSTimeInterval startupTime = MachTimeToSeconds(applicationRespondedTime - loadTime);
                [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithDouble:startupTime] forKey:kTPStartupTimeKey];
            });
            [[NSNotificationCenter defaultCenter] removeObserver:obs];
        }];
    }
#endif
}

@end
