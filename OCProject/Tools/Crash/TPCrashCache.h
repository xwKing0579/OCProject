//
//  TPCrashCache.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPCrashCache : NSObject

+ (id)crashData;
+ (void)cacheCrashData:(id)crashData;

+ (void)removeCrashData;

@end

NS_ASSUME_NONNULL_END
