//
//  TPMineTableViewCell.m
//  OCProject
//
//  Created by 王祥伟 on 2024/1/12.
//

#import "TPMineTableViewCell.h"

@interface TPMineTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@end

@implementation TPMineTableViewCell

+ (instancetype)initWithTableView:(UITableView *)tableView withObject:(id)object{
    TPMineTableViewCell *cell = [self initWithTableView:tableView];
    NSString *string;
    if ([object isKindOfClass:[NSDictionary class]]){
        NSString *key = ((NSDictionary *)object).allKeys.firstObject;
        id value = ((NSDictionary *)object).allValues.firstObject;
        if ([value isKindOfClass:[NSString class]]) {
            string = [NSString stringWithFormat:@"%@\n%@",key,value];
        }else if ([value isKindOfClass:[NSArray class]] && ((NSArray *)value).count == 1){
            string = [NSString stringWithFormat:@"%@\n%@",key,((NSArray *)value)[0]];
        }else{
            string = key;
        }
    }else if ([object isKindOfClass:[NSString class]]){
        string = object;
    }
    cell.titleLabel.text = string;
    return cell;
}

- (void)setUpSubViews{
    [self.contentView addSubviews:@[self.titleLabel,self.lineView,self.arrowImageView]];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-30);
        make.bottom.mas_equalTo(-15);
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
