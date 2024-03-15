//
//  TPBaseTableViewCell.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/4.
//

#import "TPBaseTableViewCell.h"

@implementation TPBaseTableViewCell

+ (instancetype)initWithTableView:(UITableView *)tableView{
    return [self initWithTableView:tableView andIdentifier:NSStringFromClass([self class])];
}

+ (instancetype)initWithTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier{
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpSubViews];
        
    }
    return self;
}

- (void)setUpSubViews{}

@end
