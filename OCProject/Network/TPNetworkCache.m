//
//  TPNetworkCache.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import "TPNetworkCache.h"
#import "YYCache.h"

static NSString *const kTPNetworkResponseCache = @"kTPNetworkResponseCache";

@implementation TPNetworkCache
static YYCache *_dataCache;

+ (void)initialize {
    _dataCache = [YYCache cacheWithName:kTPNetworkResponseCache];
}

+ (void)setHttpCache:(id)httpData URL:(NSString *)URL params:(NSDictionary *)params {
    NSString *cacheKey = [self cacheKeyWithURL:URL params:params];
    [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
}

+ (id)httpCacheForURL:(NSString *)URL params:(NSDictionary *)params {
    NSString *cacheKey = [self cacheKeyWithURL:URL params:params];
    return [_dataCache objectForKey:cacheKey];
}

+ (NSInteger)getAllHttpCacheSize {
    return [_dataCache.diskCache totalCost];
}

+ (void)removeAllHttpCache {
    [_dataCache.diskCache removeAllObjects];
}

+ (NSString *)cacheKeyWithURL:(NSString *)URL params:(NSDictionary *)params {
    if(!params || params.count == 0){return URL;};
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@%@",URL,paraString];
}

@end
