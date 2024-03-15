//
//  NSDate+Category.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Category)

+ (NSString *)currentTime;
+ (NSString *)timeFromDate:(NSDate *)date;

- (NSString *)toString;

@end

NS_ASSUME_NONNULL_END
