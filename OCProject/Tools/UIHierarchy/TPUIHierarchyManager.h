//
//  TPUIHierarchyManager.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/25.
//

#import <Foundation/Foundation.h>
#import "TPUIHierarchyModel.h"
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXTERN NSString *const kTPUIHierarchyNotification;

@interface TPUIHierarchyManager : NSObject
+ (void)start;
+ (void)stop;

+ (BOOL)isOn;

+ (TPUIHierarchyModel *)currentUIHierarchy:(id)obj;

@end

NS_ASSUME_NONNULL_END
