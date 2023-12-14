//
//  NSDate+Category.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/13.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)

+ (NSString *)currentTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM:SS"];
    return [formatter stringFromDate:[NSDate date]];
}

@end
