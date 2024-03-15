//
//  TPAnalysisClickViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/1/10.
//

#import "TPAnalysisClickViewController.h"
#import "TPAnalysisDemoModel.h"
@interface TPAnalysisClickViewController ()

@end

@implementation TPAnalysisClickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"常见Click埋点场景";
    self.data = [TPAnalysisDemoModel data];
    [self.tableView reloadData];
}

- (NSString *)cellClass{
    return TPString.tc_analysis_click;
}

- (void)backViewController{
    [TPRouter back];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"tableViewCell点击事件");
}

@end
