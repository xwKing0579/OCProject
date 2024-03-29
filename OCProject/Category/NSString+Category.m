//
//  NSString+Category.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/15.
//

#import "NSString+Category.h"

@implementation NSString (Category)


- (BOOL)isNumber{
    if (!self) return NO;
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (NSString *)whitespace{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

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

+ (NSString *)convertJsonFromData:(NSData *)data{
    if (data == nil) return nil;
    NSError *error = nil;
    id returnValue = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error || !returnValue || returnValue == [NSNull null]) return nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:returnValue options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSArray *)subStartStr:(NSString *)startStr endStr:endStr{
    NSUInteger startLocation = 0;
    NSUInteger endLocation = 0;

    NSMutableArray *resultArray = [NSMutableArray array];
    while (startLocation < self.length && endLocation < self.length) {
        NSRange startRange = [self rangeOfString:startStr options:0 range:NSMakeRange(startLocation, self.length - startLocation)];
        if (startRange.location == NSNotFound) break;
        startLocation = startRange.location + startRange.length;
        NSRange endRange = [self rangeOfString:endStr options:0 range:NSMakeRange(startLocation, self.length - startLocation)];
        if (endRange.location == NSNotFound) break;
        endLocation = endRange.location;
        NSRange subRange = NSMakeRange(startLocation, endLocation - startLocation);
        NSString *subString = [self substringWithRange:subRange];
        [resultArray addObject:subString];
        startLocation = endLocation + endRange.length;
    }
    return resultArray;
}

- (NSArray *)filterString{
    return [self componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"@／ ：；（）¥「」,＂、[]{}#%-*+=_//|~＜＞$€^•'@#$%^&*()_+'/"""]];
}

- (NSArray *)regexPattern:(NSString *)regexString{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    NSMutableArray *result = [NSMutableArray array];
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match rangeAtIndex:1];
        NSString *matchedString = [self substringWithRange:matchRange];
        [result addObject:matchedString];
    }
    return result;
}

@end
