//
//  TestTableViewCell.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/4.
//

#import "TPBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN


@interface TestTableViewCell : TPBaseTableViewCell

+ (instancetype)initWithTableView:(UITableView *)tableView titleString:(NSString *)titleString;

@end

NS_ASSUME_NONNULL_END
