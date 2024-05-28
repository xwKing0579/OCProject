//
//  TPNetworkMonitor.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/29.
//

#import "TPNetworkMonitor.h"
#import "TPURLProtocol.h"
NSString *const kTPNetworkConfigKey = @"kTPNetworkConfigKey";

@interface TPNetworkMonitor() <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@end

@implementation TPNetworkMonitor

+ (void)load{
#ifdef DEBUG
    [self start];
#endif
}

+ (void)start{
    [[NSUserDefaults standardUserDefaults] setValue:@(YES) forKey:kTPNetworkConfigKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [NSURLProtocol registerClass:[TPURLProtocol class]];
}

+ (void)stop{
    [[NSUserDefaults standardUserDefaults] setValue:@(NO) forKey:kTPNetworkConfigKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [NSURLProtocol unregisterClass:[TPURLProtocol class]];
}

+ (BOOL)isOn{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:kTPNetworkConfigKey] boolValue];
}

+ (NSArray <TPNetworkModel *>*)data{
    return [NSObject performTarget:@"TPURLProtocol".classString action:@"dataList"];
}

+ (void)removeNetData{
    [NSObject performTarget:@"TPURLProtocol".classString action:@"removeNetData"];
}

@end
