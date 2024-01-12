//
//  TPSafeObjectManager.m
//  OCProject
//
//  Created by 王祥伟 on 2024/1/12.
//

#import "TPSafeObjectManager.h"
#import "NSObject+Safe.h"

NSString *const kTPSafeConfigKey = @"kTPSafeConfigKey";

@implementation TPSafeObjectManager
+ (void)load{
#ifdef DEBUG
    if ([self isOn]) [self start];
#endif
}

+ (void)start{
    [[NSUserDefaults standardUserDefaults] setValue:@(YES) forKey:kTPSafeConfigKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self safeSwitch];
}

+ (void)stop{
    [[NSUserDefaults standardUserDefaults] setValue:@(NO) forKey:kTPSafeConfigKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self safeSwitch];
}

+ (BOOL)isOn{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:kTPSafeConfigKey] boolValue];
}

+ (void)safeObjectWithException:(NSException *)exception{
#ifdef DEBUG
    NSArray *callStackSymbols = [NSThread callStackSymbols];
    if (callStackSymbols.count < 2) return;
    NSLog(@">>>>>>>>>>>>>>> [Crash Type]: %@\n>>>>>>>>>>>>>>> [Crash Reason]: %@\n>>>>>>>>>>>>>>> [Error Place]: %@\n",exception.name,exception.reason,[self getMainCallStackSymbolMessage:callStackSymbols[2]]);
#endif
}


//+[类名 方法名]  或者 -[类名 方法名]
+ (NSString *)getMainCallStackSymbolMessage:(NSString *)callStackSymbol{
    __block NSString *mainCallStackSymbolMsg = nil;
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    [regularExp enumerateMatchesInString:callStackSymbol options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbol.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        if (result) {
            mainCallStackSymbolMsg = [callStackSymbol substringWithRange:result.range];
            *stop = YES;
        }
    }];
    return mainCallStackSymbolMsg;
}
@end
