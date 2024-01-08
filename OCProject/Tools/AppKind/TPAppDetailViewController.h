//
//  TPAppDetailViewController.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/22.
//

#import "TPBaseTableViewController.h"
#import "TPAppKindModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPAppDetailViewController : TPBaseTableViewController
@property (nonatomic, strong) TPAppKindModel *model;
@end

NS_ASSUME_NONNULL_END
