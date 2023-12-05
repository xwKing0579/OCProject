//
//  TPBaseTableViewCell.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPBaseTableViewCell : UITableViewCell
+ (instancetype)initWithTableView:(UITableView *)tableView;//同一个cell复用
+ (instancetype)initWithTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier;//多个cell建议使用这种，内存优化
- (void)setUpSubViews;
@end

NS_ASSUME_NONNULL_END
