//
//  TestTableViewCell.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/4.
//

#import "TestTableViewCell.h"
@interface TestTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation TestTableViewCell

+ (instancetype)initWithTableView:(UITableView *)tableView withObject:(NSString *)titleString{
    TestTableViewCell *cell = [self initWithTableView:tableView];
    cell.titleLabel.text = titleString;
    return cell;
}

- (void)setUpSubViews{
    [self.contentView addSubview:self.titleLabel];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 200, 50)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}
@end
