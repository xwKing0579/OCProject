//
//  TPThreadTrace.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPThreadTrace : NSObject
/*!
 *  @brief  线程堆栈上下文输出
 */
+ (NSString *)backtraceOfAllThread;
+ (NSString *)backtraceOfMainThread;
+ (NSString *)backtraceOfCurrentThread;
+ (NSString *)backtraceOfNSThread:(NSThread *)thread;

//打印
+ (void)logMain;
+ (void)logCurrent;
+ (void)logAllThread;

+ (NSString *)backtraceLogFilePath;
+ (void)recordLoggerWithFileName: (NSString *)fileName;
@end

NS_ASSUME_NONNULL_END
