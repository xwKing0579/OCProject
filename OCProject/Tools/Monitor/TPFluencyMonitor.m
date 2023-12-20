//
//  TPFluencyMonitor.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/20.
//

#import "TPFluencyMonitor.h"
#import "TPThreadTrace.h"
#import "TPMonitorCache.h"

#define SEMAPHORE_SUCCESS 0
static dispatch_semaphore_t semaphore;
static NSTimeInterval time_out_interval = 0.05;

NSString *const kTPMonitorConfigKey = @"kTPMonitorConfigKey";

@implementation TPFluencyMonitor
static inline dispatch_queue_t fluecy_monitor_queue(void) {
    static dispatch_queue_t fluecy_monitor_queue;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        fluecy_monitor_queue = dispatch_queue_create("com.dream.monitor_queue", NULL);
    });
    return fluecy_monitor_queue;
}

static inline void monitorInit(void) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        semaphore = dispatch_semaphore_create(0);
    });
}

+ (void)load{
#ifdef DEBUG
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self isOn])[self start];
    });
#endif
}

+ (instancetype)sharedManager {
    static TPFluencyMonitor *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [self new];
    });
    return sharedManager;
}

+ (void)start{
    [[NSUserDefaults standardUserDefaults] setValue:@(YES) forKey:kTPMonitorConfigKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    monitorInit();
    dispatch_async(fluecy_monitor_queue(), ^{
        while (1) {
            __block BOOL timeOut = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                timeOut = NO;
                dispatch_semaphore_signal(semaphore);
            });
            [NSThread sleepForTimeInterval:time_out_interval];
            if (timeOut) {
                TPMonitorModel *model = [TPMonitorModel new];
                model.date = [NSDate currentTime];
                model.thread = [NSThread mainThread].description;
                model.stackSymbols = [NSThread callStackSymbols];
                model.backtrace = [TPThreadTrace backtraceOfMainThread];
                model.page = [NSString stringWithFormat:@"%@",UIViewController.currentViewController ?: UIViewController.window];
                
                id obj = [TPMonitorCache monitorData];
                NSMutableArray *data = [NSMutableArray array];
                if (obj) [data addObjectsFromArray:obj];
                [data addObject:model];
                [TPMonitorCache cacheMonitorData:data];
            }
            dispatch_wait(semaphore, DISPATCH_TIME_FOREVER);
        }
    });
}

+ (void)stop{
    [[NSUserDefaults standardUserDefaults] setValue:@(NO) forKey:kTPMonitorConfigKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isOn{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:kTPMonitorConfigKey] boolValue] ?: NO;
}

@end
