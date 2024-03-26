//
//  NSDate+Category.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/13.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)

+ (NSString *)currentTime{
    return [self currentTimeFormatterString:[self yearToSecond]];
}

+ (NSString *)currentTimeFormatterString:(NSString *)formatterString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterString];
    return [formatter stringFromDate:[NSDate date]];
}

+ (NSString *)timeFromDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:[self yearToSecond]];
    return [formatter stringFromDate:date];
}

- (NSString *)toString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:[self yearToSecond]];
    return [formatter stringFromDate:self];
}

- (NSString *)yearToSecond{
    return [NSDate yearToSecond];
}

+ (NSString *)yearToSecond{
    return @"yyyy-MM-dd HH:mm:ss";
}

@end
