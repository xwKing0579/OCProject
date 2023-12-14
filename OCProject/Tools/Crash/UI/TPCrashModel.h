//
//  TPCrashModel.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPCrashModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *thread;
@property (nonatomic, strong) NSDictionary <NSString *,id>*userInfo;
@property (nonatomic, copy) NSArray <NSString *>*stackSymbols;
@end

NS_ASSUME_NONNULL_END
