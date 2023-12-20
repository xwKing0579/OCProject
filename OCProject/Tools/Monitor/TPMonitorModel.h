//
//  TPMonitorModel.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPMonitorModel : NSObject
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *thread;
@property (nonatomic, copy) NSString *page;
@property (nonatomic, copy) NSString *backtrace;
@property (nonatomic, copy) NSArray <NSString *>*stackSymbols;
@end

NS_ASSUME_NONNULL_END
