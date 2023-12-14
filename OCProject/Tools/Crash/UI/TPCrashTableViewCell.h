//
//  TPCrashTableViewCell.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/14.
//

#import "TPBaseTableViewCell.h"
#import "TPCrashModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPCrashTableViewCell : TPBaseTableViewCell
+ (instancetype)initWithTableView:(UITableView *)tableView withModel:(TPCrashModel *)model;
@end

NS_ASSUME_NONNULL_END
