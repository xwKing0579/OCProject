//
//  TPFontTableViewCell.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/20.
//

#import "TPFontTableViewCell.h"
@interface TPFontTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@end


@implementation TPFontTableViewCell

+ (instancetype)initWithTableView:(UITableView *)tableView withString:(NSString *)string{
    TPFontTableViewCell *cell = [self initWithTableView:tableView];
    cell.titleLabel.text = string;
    return cell;
}

- (void)setUpSubViews{
    [self.contentView addSubviews:@[self.titleLabel,self.lineView]];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-10);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = UIFont.font14;
        _titleLabel.textColor = UIColor.c1E1E1E;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIView *)lineView{
    if (!_lineView){
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColor.cCCCCCC;
    }
    return _lineView;
}

@end
