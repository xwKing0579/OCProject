//
//  TPMonitorCache.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/20.
//

#import "TPMonitorCache.h"
#import "YYCache.h"

static YYCache *_monitorCache;
static NSString *const TPMonitorDataCachePathKey = @"TPMonitorDataCachePathKey";
@implementation TPMonitorCache

+ (void)initialize {
    _monitorCache = [YYCache cacheWithName:@"TPMonitorCacheKey"];
}

+ (id)monitorData{
    return [_monitorCache objectForKey:TPMonitorDataCachePathKey];
}

+ (void)cacheMonitorData:(id)monitorData{
    [_monitorCache setObject:monitorData forKey:TPMonitorDataCachePathKey];
}

+ (void)removeMonitorData{
    [_monitorCache removeAllObjects];
}
@end
