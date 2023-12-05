//
//  TPNetworkError.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPNetworkError : NSObject
@property(nonatomic, strong) NSError *error;
@property(nonatomic, strong) NSString *errorCode;
@property(nonatomic, strong) NSString *errorMessage;
@end

NS_ASSUME_NONNULL_END
