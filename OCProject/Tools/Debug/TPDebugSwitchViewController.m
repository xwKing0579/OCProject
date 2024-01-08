//
//  TPDebugSwitchViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/28.
//

#import "TPDebugSwitchViewController.h"

@implementation TPDebugSwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"开关";
    self.data = @[@{@"打印日志":@"TPLogManager"},
                  @{@"崩溃信息":@"TPCrashManager"},
                  @{@"卡顿检测":@"TPFluencyMonitor"},
                  @{@"视图层级":@"TPUIHierarchyManager"}];
    [self.tableView reloadData];
}

- (NSString *)cellClass{
    return @"TPDebugSwitchTableViewCell_Class";
}

@end


@interface TPDebugSwitchTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, strong) NSString *targetName;
@end

@implementation TPDebugSwitchTableViewCell

+ (instancetype)initWithTableView:(UITableView *)tableView withObject:(NSDictionary *)obj{
    TPDebugSwitchTableViewCell *cell = [self initWithTableView:tableView];
    cell.titleLabel.text = obj.allKeys.firstObject;
    cell.targetName = [NSString stringWithFormat:@"%@_Class",obj.allValues.firstObject];
    cell.switchView.on = [[NSObject performTarget:cell.targetName action:@"isOn"] boolValue];
    return cell;
}

- (void)setUpSubViews{
    [self.contentView addSubviews:@[self.titleLabel,self.lineView,self.switchView]];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-90);
        make.bottom.mas_equalTo(-15);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
}

- (void)clickSwitchAction:(UISwitch *)sender{
    [NSObject performTarget:self.targetName action:self.switchView.isOn ? @"start" : @"stop"];
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
        _lineView.backgroundColor = UIColor.ccccccC;
    }
    return _lineView;
}

- (UISwitch *)switchView{
    if (!_switchView){
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(clickSwitchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}

@end
