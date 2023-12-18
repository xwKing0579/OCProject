//
//  TPFileDataTableViewCell.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/15.
//

#import "TPBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPFileDataTableViewCell : TPBaseTableViewCell
+ (instancetype)initWithTableView:(UITableView *)tableView withKey:(NSString *)key withValue:(id)value;
@end

NS_ASSUME_NONNULL_END
