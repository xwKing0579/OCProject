//
//  TPLogManager.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/19.
//

#import "TPLogManager.h"
#include "fishhook.h"

NSString *const kTPLogConfigKey = @"kTPLogConfigKey";

//函数指针，用来保存原始的函数的地址
static void(*oldLog)(NSString *format, ...);

//新的NSLog
void newLog(NSString *format, ...){
    
    va_list vl;
    va_start(vl, format);
    NSString *str = [[NSString alloc] initWithFormat:format arguments:vl];
    va_end(vl);
    
    [[TPLogManager sharedManager] addLog:str];

    oldLog(@"%@",str);
}

@interface TPLogManager ()
@property (nonatomic, strong) NSMutableArray<TPLogModel *> *data;
@end

@implementation TPLogManager

+ (void)load {
#ifdef DEBUG
    if ([self isOn]) [self start];
#endif
}

+ (instancetype)sharedManager {
    static TPLogManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [self new];
        sharedManager.data = [NSMutableArray array];
    });
    
    return sharedManager;
}

+ (void)start{
    rebind_symbols((struct rebinding[1]){"NSLog", (void *)newLog, (void **)&oldLog},1);
    [[NSUserDefaults standardUserDefaults] setValue:@(YES) forKey:kTPLogConfigKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)stop{
    rebind_symbols((struct rebinding[1]){"NSLog", (void *)oldLog, NULL},1);
    [[NSUserDefaults standardUserDefaults] setValue:@(NO) forKey:kTPLogConfigKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isOn{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:kTPLogConfigKey] boolValue] ?: NO;
}

- (void)addLog:(NSString *)log{
    TPLogModel *model = [TPLogModel new];
    model.content = log;
    model.thread = [NSThread currentThread].description;
    model.date = [NSDate currentTime];
    [[TPLogManager sharedManager].data addObject:model];
}

+ (NSMutableArray<TPLogModel *> *)data{
    return [self sharedManager].data;
}

+ (void)removeData{
    [[self sharedManager].data removeAllObjects];
}

@end
