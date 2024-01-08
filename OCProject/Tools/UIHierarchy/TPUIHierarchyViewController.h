//
//  TPUIHierarchyViewController.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/25.
//

#import "TPBaseTableViewController.h"
#import "TPUIHierarchyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPUIHierarchyViewController : TPBaseTableViewController

@property (nonatomic, strong) TPUIHierarchyModel *views;
@property (nonatomic, strong) TPUIHierarchyModel *vcs;
@end

NS_ASSUME_NONNULL_END
