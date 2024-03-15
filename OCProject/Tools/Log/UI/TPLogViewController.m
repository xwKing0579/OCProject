//
//  TPLogViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/19.
//

#import "TPLogViewController.h"
#import "TPLogManager.h"

@interface TPLogViewController ()
@end

@implementation TPLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"Log(%@)",[TPLogManager isOn] ? @"开" : @"关"];
    
    [self setUpSubViews];
}

- (void)setUpSubViews{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"delete"].original style:(UIBarButtonItemStyleDone) target:self action:@selector(removeLogData)];
    
    self.data = ((NSArray *)TPLogManager.data).reverseObjectEnumerator.allObjects;
    [self.tableView reloadData];
}

- (void)removeLogData{
    [TPLogManager removeData];
    self.data = TPLogManager.data;
    [self.tableView reloadData];
}

- (NSString *)cellClass{
    return TPString.tc_log;
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [TPRouter jumpUrl:TPString.vc_log_detail params:@{@"model":self.data[indexPath.row]}];
}

@end
