//
//  TPSpamCodeModel.h
//  OCProject
//
//  Created by 王祥伟 on 2024/3/25.
//

#import <Foundation/Foundation.h>
#import "TPConfoundSetting.h"
#import "TPConfoundModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPSpamCodeModel : NSObject
@property (nonatomic, copy) NSString *idStr;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *detail;

+ (NSArray *)data_file;
+ (NSArray *)data_code;
+ (NSArray *)data_prefix;

@end

NS_ASSUME_NONNULL_END
