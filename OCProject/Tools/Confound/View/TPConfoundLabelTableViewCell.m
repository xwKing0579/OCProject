//
//  TPConfoundLabelTableViewCell.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/27.
//

#import "TPConfoundLabelTableViewCell.h"
#import "TPConfoundModel.h"
@interface TPConfoundLabelTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *copyBtn;
@property (nonatomic, strong) TPConfoundModel *model;
@end

@implementation TPConfoundLabelTableViewCell

+ (instancetype)initWithTableView:(UITableView *)tableView withObject:(TPConfoundModel *)obj{
    TPConfoundLabelTableViewCell *cell = [self initWithTableView:tableView];
    cell.titleLabel.text = obj.title;
    cell.contentLabel.text = obj.content;
    cell.model = obj;
    return cell;
}

- (void)setUpSubViews{
    [self.contentView addSubviews:@[self.titleLabel,self.contentLabel,self.lineView,self.copyBtn]];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(88);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(8);
        make.right.mas_equalTo(self.copyBtn.mas_left).offset(-8);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    [self.copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
}

- (void)clickCopyAction{
    UIPasteboard *pastboard = [UIPasteboard generalPasteboard];
    [pastboard setString:self.contentLabel.text];

    [TPToastManager showText:@"复制成功"];
}

- (UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = UIFont.font14;
        _titleLabel.textColor = UIColor.c1e1e1e;
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

- (UIView *)lineView{
    if (!_lineView){
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColor.ccccccc;
    }
    return _lineView;
}

- (UIButton *)copyBtn{
    if (!_copyBtn){
        _copyBtn = [[UIButton alloc] init];
        [_copyBtn setImage:[UIImage imageNamed:@"copy"] forState:UIControlStateNormal];
        [_copyBtn addTarget:self action:@selector(clickCopyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _copyBtn;
}
@end

