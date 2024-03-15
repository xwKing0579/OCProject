//
//  NSString+Category.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, NSDateFormatterType){
    NSDateFormatterYearMonthDay = 0,
    NSDateFormatterYearToMinute,
    NSDateFormatterYearToSecond,
    NSDateFormatterHourMinuteSecond,
};

@interface NSString (Category)
///是否是纯数字
- (BOOL)isNumber;
///数据转字符串
+ (NSString *)convertJsonFromData:(NSData *)data;
///文件大小转换K
+ (NSString *)sizeString:(unsigned long long)fileSize;

- (NSString *)toFormatter:(NSDateFormatterType)type;
@end

NS_ASSUME_NONNULL_END
