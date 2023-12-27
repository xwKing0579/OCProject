//
//  TPLogViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/19.
//

#import "TPLogViewController.h"
#import "TPLogManager.h"

@interface TPLogViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <TPLogModel *>*data;

@end

@implementation TPLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"Log(%@)",[TPLogManager isOn] ? @"开" : @"关"];
    
    [self setUpSubViews];
}

- (void)setUpSubViews{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageOriginal:[UIImage imageNamed:@"delete"]] style:(UIBarButtonItemStyleDone) target:self action:@selector(removeLogData)];
    
    self.data = ((NSArray *)TPLogManager.data).reverseObjectEnumerator.allObjects;
    [self.tableView reloadData];
    
    UIButton *customView = [[UIButton alloc] init];
    customView.backgroundColor = UIColor.redColor;
    customView.layer.cornerRadius = 20;
    [customView setTitle:[TPLogManager isOn] ? @"关" : @"开" forState:UIControlStateNormal];
    [customView setTitleColor:UIColor.cFFFFFF forState:UIControlStateNormal];
    [customView addTarget:self action:@selector(clickOn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customView];
    [customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30);
        make.width.height.mas_equalTo(40);
        make.bottom.mas_equalTo(-50);
    }];
}

- (void)removeLogData{
    [TPLogManager removeData];
    self.data = TPLogManager.data;
    [self.tableView reloadData];
}

- (void)clickOn:(UIButton *)sender{
    [TPLogManager isOn] ? [TPLogManager stop] : [TPLogManager start];
    [sender setTitle:[TPLogManager isOn] ? @"关" : @"开" forState:UIControlStateNormal];
    self.title = [NSString stringWithFormat:@"Log(%@)",[TPLogManager isOn] ? @"开" : @"关"];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [NSObject performTarget:@"TPLogTableViewCell_Class" action:@"initWithTableView:withModel:" object:tableView object:self.data[indexPath.row]] ?: [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [NSObject performTarget:TPRouter.routerClass action:TPRouter.routerJumpUrlParams object:@"TPLogDetailViewController" object:@{@"model":self.data[indexPath.row]}];
}

#pragma mark -- setter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0.01)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0.01)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _tableView;
}
@end
