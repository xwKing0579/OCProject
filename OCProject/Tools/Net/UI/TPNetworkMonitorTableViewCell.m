//
//  TPNetworkMonitorTableViewCell.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/29.
//

#import "TPNetworkMonitorTableViewCell.h"
#import "TPNetworkModel.h"
@interface TPNetworkMonitorTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@end

@implementation TPNetworkMonitorTableViewCell

+ (instancetype)initWithTableView:(UITableView *)tableView withObject:(TPNetworkModel *)model{
    TPNetworkMonitorTableViewCell *cell = [self initWithTableView:tableView];
    cell.titleLabel.text = model.url;
    cell.contentLabel.text  = [NSString stringWithFormat:@"%@ > [%ld]",model.httpMethod,(long)model.statusCode];
    cell.contentLabel.backgroundColor = (model.statusCode == 0 || model.statusCode == 200) ? UIColor.whiteColor : UIColor.redColor;
    cell.dateLabel.text = [NSString stringWithFormat:@"%@ 耗时：%.3lf",model.startTime,model.totalDuration];
    return cell;
}

- (void)setUpSubViews{
    [self.contentView addSubviews:@[self.titleLabel,self.contentLabel,self.dateLabel,self.lineView,self.arrowImageView]];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-25);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(4);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(4);
        make.right.mas_equalTo(-25);
        make.bottom.mas_equalTo(-10);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(12);
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = UIFont.font12;
        _titleLabel.textColor = UIColor.c1e1e1e;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel){
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = UIFont.fontBold14;
        _contentLabel.textColor = UIColor.c000000;
        _contentLabel.numberOfLines = 0;
        _contentLabel.layer.cornerRadius = 2;
        _contentLabel.layer.masksToBounds = YES;
    }
    return _contentLabel;
}

- (UILabel *)dateLabel{
    if (!_dateLabel){
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = UIFont.font12;
        _dateLabel.textColor = UIColor.c333333;
    }
    return _dateLabel;
}

- (UIView *)lineView{
    if (!_lineView){
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColor.ccccccC;
    }
    return _lineView;
}

- (UIImageView *)arrowImageView{
    if (!_arrowImageView){
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"arrow"];
    }
    return _arrowImageView;
}

@end
