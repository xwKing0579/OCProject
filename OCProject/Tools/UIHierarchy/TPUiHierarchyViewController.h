//
//  TPUiHierarchyViewController.h
//  OCProject
//
//  Created by 王祥伟 on 2024/3/14.
//

#import "TPBaseTableViewController.h"
#import "TPUIHierarchyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPUiHierarchyViewController : TPBaseTableViewController

@property (nonatomic, strong) TPUIHierarchyModel *views;
@property (nonatomic, strong) TPUIHierarchyModel *vcs;

@end

NS_ASSUME_NONNULL_END
