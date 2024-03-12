//
//  TPOperation.h
//  OCProject
//
//  Created by 王祥伟 on 2024/3/11.
//

#import <Foundation/Foundation.h>
#import "TPOperationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPOperation : NSOperation
@property (nonatomic, strong) TPOperationModel *model;
@property (nonatomic, getter = isFinished)  BOOL finished;
@property (nonatomic, getter = isExecuting) BOOL executing;
@end

NS_ASSUME_NONNULL_END
