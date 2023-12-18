//
//  NSString+Category.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Category)
+ (NSString *)sizeString:(unsigned long long)fileSize;
@end

NS_ASSUME_NONNULL_END
