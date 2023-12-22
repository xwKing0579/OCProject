//
//  NSString+Category.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/15.
//

#import "NSString+Category.h"

@implementation NSString (Category)

+ (NSString *)sizeString:(unsigned long long)fileSize{
    NSString *sizeString = @"0";
    if (fileSize >= pow(10, 9)) { // size >= 1GB
        sizeString = [NSString stringWithFormat:@"%.2fGB", fileSize / pow(10, 9)];
    } else if (fileSize >= pow(10, 6)) { // 1GB > size >= 1MB
        sizeString = [NSString stringWithFormat:@"%.2fMB", fileSize / pow(10, 6)];
    } else if (fileSize >= pow(10, 3)) { // 1MB > size >= 1KB
        sizeString = [NSString stringWithFormat:@"%.2fKB", fileSize / pow(10, 3)];
    } else { // 1KB > size
        sizeString = [NSString stringWithFormat:@"%lluB", fileSize];
    }
    return sizeString;
}

@end
