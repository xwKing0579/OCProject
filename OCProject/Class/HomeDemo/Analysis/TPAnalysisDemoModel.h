//
//  TPAnalysisDemoModel.h
//  OCProject
//
//  Created by 王祥伟 on 2024/1/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPAnalysisDemoModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *labelString;
@property (nonatomic, copy) NSString *buttonString;
@property (nonatomic, copy) NSString *controlString;

+ (NSArray <TPAnalysisDemoModel *>*)data;
@end

NS_ASSUME_NONNULL_END
