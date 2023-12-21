//
//  TPRAMUsage.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 内存使用情况
 */
typedef struct {
    unsigned long long used_size;
    unsigned long long available_size;
    unsigned long long total_size;
}fs_system_ram_usage;

@interface TPRAMUsage : NSObject
/**
 获取APP内存使用量

 @return byte
 */
+ (unsigned long long)getAppRAMUsage;

/**
 获取系统内存使用量

 @return byte
 */
+ (unsigned long long)getSystemRAMUsage;

/**
 获取系统可用内存量

 @return byte
 */
+ (unsigned long long)getSystemRAMAvailable;

/**
 获取系统内存总量

 @return byte
 */
+ (unsigned long long)getSystemRAMTotal;

/**
 获取内存使用结构体

 @return ty_system_ram_usage
 */
+ (fs_system_ram_usage)getSystemRamUsageStruct;
@end

NS_ASSUME_NONNULL_END
