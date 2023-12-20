//
//  TPLogManager.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/19.
//

#import <Foundation/Foundation.h>
#import "TPLogModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPLogManager : NSObject

+ (instancetype)sharedManager;

+ (void)start;
+ (void)stop;

+ (BOOL)isOn;
- (void)addLog:(NSString *)log;

+ (NSArray<TPLogModel *> *)data;
+ (void)removeData;
@end

NS_ASSUME_NONNULL_END
