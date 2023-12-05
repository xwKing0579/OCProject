//
//  TPNetworkCache.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPNetworkCache : NSObject
+ (void)setHttpCache:(id)httpData URL:(NSString *)URL params:(id)params;
+ (id)httpCacheForURL:(NSString *)URL params:(id)params;
+ (void)removeAllHttpCache;
@end

NS_ASSUME_NONNULL_END
