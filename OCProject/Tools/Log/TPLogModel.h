//
//  TPLogModel.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPLogModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *thread;
@property (nonatomic, copy) NSString *date;
@end

NS_ASSUME_NONNULL_END
