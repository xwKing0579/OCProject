//
//  TPConfoundTableViewCell.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/22.
//

#import "TPConfoundTableViewCell.h"
#import "TPConfoundModel.h"
#import "TPConfoundSetting.h"
@interface TPConfoundTableViewCell ()
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) TPConfoundModel *model;
@end

@implementation TPConfoundTableViewCell

+ (instancetype)initWithTableView:(UITableView *)tableView withObject:(TPConfoundModel *)obj{
    TPConfoundTableViewCell *cell = [self initWithTableView:tableView];
    cell.titleLabel.text = obj.title;
    cell.arrowImageView.hidden = !obj.setting;
    cell.selectBtn.selected = obj.selecte;
    cell.model = obj;
    return cell;
}

- (void)setUpSubViews{
    [self.contentView addSubviews:@[self.selectBtn,self.titleLabel,self.lineView,self.arrowImageView]];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.width.height.mas_equalTo(30);
        make.bottom.mas_equalTo(-15);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.selectBtn.mas_right).offset(10);
        make.right.mas_equalTo(self.arrowImageView.mas_left).offset(-10);
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

- (void)clickSelectAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.model.selecte = sender.selected;
    
    TPConfoundSetting *set = TPConfoundSetting.sharedManager;
    TPSpamCodeSetting *codeSet = set.spamSet;
    TPSpamCodeFileSetting *fileSet = codeSet.spamFileSet;
    
    switch (self.model.idStr.intValue) {
        case 1:
            set.isSpam = sender.selected;
            break;
        case 11:
            codeSet.isSpamInOldCode = sender.selected;
            break;
        case 12:
            codeSet.isSpamInNewDir = sender.selected;
            break;
        case 13:
            codeSet.isSpamMethod = sender.selected;
            break;
        case 14:
            codeSet.isSpamOldWords = sender.selected;
            break;
        default:
            break;
    }
}

- (UIButton *)selectBtn{
    if (!_selectBtn){
        _selectBtn = [[UIButton alloc] init];
        [_selectBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
        [_selectBtn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        [_selectBtn addTarget:self action:@selector(clickSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
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

- (UIView *)lineView{
    if (!_lineView){
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColor.ccccccc;
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

