//
//  TPCrashTableViewCell.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/14.
//

#import "TPCrashTableViewCell.h"
@interface TPCrashTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation TPCrashTableViewCell

+ (instancetype)initWithTableView:(UITableView *)tableView withObject:(TPCrashModel *)model{
    TPCrashTableViewCell *cell = [self initWithTableView:tableView];
    cell.titleLabel.text = model.name;
    cell.contentLabel.text = model.reason;
    cell.dateLabel.text = model.date;
    return cell;
}

- (void)setUpSubViews{
    [self.contentView addSubviews:@[self.titleLabel,self.contentLabel,self.dateLabel,self.arrowImageView,self.lineView]];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-25);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(4);
        make.right.mas_equalTo(-25);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(4);
        make.right.mas_equalTo(-25);
        make.bottom.mas_equalTo(-10);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(12);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = UIFont.fontBold16;
        _titleLabel.textColor = UIColor.c000000;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel){
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = UIFont.font14;
        _contentLabel.textColor = UIColor.c000000;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UILabel *)dateLabel{
    if (!_dateLabel){
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = UIFont.font12;
        _dateLabel.textColor = UIColor.c333333;
        _dateLabel.textAlignment = NSTextAlignmentRight;
    }
    return _dateLabel;
}

- (UIImageView *)arrowImageView{
    if (!_arrowImageView){
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"arrow"];
    }
    return _arrowImageView;
}

- (UIView *)lineView{
    if (!_lineView){
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColor.cCCCCCC;
    }
    return _lineView;
}
@end
