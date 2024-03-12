//
//  TPOperationManager.h
//  OCProject
//
//  Created by 王祥伟 on 2024/3/11.
//

#import <Foundation/Foundation.h>
#import "TPOperationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPOperationManager : NSObject

+ (void)addOperationModel:(TPOperationModel *)model;
+ (void)removeOperationForView:(UIView *)view;
+ (void)removeAllOperation;
@end

NS_ASSUME_NONNULL_END
