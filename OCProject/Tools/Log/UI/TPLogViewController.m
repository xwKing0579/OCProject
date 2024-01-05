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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageOriginal:[UIImage imageNamed:@"delete"]] style:(UIBarButtonItemStyleDone) target:self action:@selector(removeLogData)];
    
    self.data = ((NSArray *)TPLogManager.data).reverseObjectEnumerator.allObjects;
    [self.tableView reloadData];
}

- (void)removeLogData{
    [TPLogManager removeData];
    self.data = TPLogManager.data;
    [self.tableView reloadData];
}

- (NSString *)cellClass{
    return @"TPLogTableViewCell_Class";
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [NSObject performTarget:TPRouter.routerClass action:TPRouter.routerJumpUrlParams object:@"TPLogDetailViewController" object:@{@"model":self.data[indexPath.row]}];
}

@end
