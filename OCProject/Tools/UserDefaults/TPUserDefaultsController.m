//
//  TPUserDefaultsController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/19.
//

#import "TPUserDefaultsController.h"

@interface TPUserDefaultsController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary <NSString *, id>*data;
@end

@implementation TPUserDefaultsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"UserDefaults";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageOriginal:[UIImage imageNamed:@"delete"]] style:(UIBarButtonItemStyleDone) target:self action:@selector(removeUserDefaulesData)];
    self.data = NSUserDefaults.standardUserDefaults.dictionaryRepresentation;
    [self.tableView reloadData];
}

- (void)removeUserDefaulesData{
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:NSBundle.mainBundle.bundleIdentifier];
    self.data = NSUserDefaults.standardUserDefaults.dictionaryRepresentation;
    [self.tableView reloadData];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TPMediator performTarget:@"TPUserDefaultsTableViewCell_Class" action:@"initWithTableView:withKey:withValue:" objects:@{@"object1":tableView,@"object2":self.data.allKeys[indexPath.row],@"object3":self.data[self.data.allKeys[indexPath.row]]}] ?: [UITableViewCell new];
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
