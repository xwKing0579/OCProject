//
//  TPCrashCache.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/13.
//

#import "TPCrashCache.h"
#import "YYCache.h"

static YYCache *_crashCache;
static NSString *const TPCrashDataCachePathKey = @"TPCrashDataCachePathKey";
@implementation TPCrashCache

+ (void)initialize {
    _crashCache = [YYCache cacheWithName:@"TPCrashCacheKey"];
}

+ (id)crashData{
    return [_crashCache objectForKey:TPCrashDataCachePathKey];
}

+ (void)cacheCrashData:(id)crashData{
    [_crashCache setObject:crashData forKey:TPCrashDataCachePathKey];
}

+ (void)removeCrashData{
    [_crashCache removeAllObjects];
}

@end
