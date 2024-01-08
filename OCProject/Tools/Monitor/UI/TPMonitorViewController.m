//
//  TPMonitorViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/20.
//

#import "TPMonitorViewController.h"
#import "TPFluencyMonitor.h"
#import "TPMonitorCache.h"

@interface TPMonitorViewController ()

@end

@implementation TPMonitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"卡顿检测(%@)",[TPFluencyMonitor isOn] ? @"开" : @"关"];
    
    [self setUpSubViews];
}

- (void)setUpSubViews{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"delete"].original style:(UIBarButtonItemStyleDone) target:self action:@selector(removeMonitorData)];
    self.data = ((NSArray *)[TPMonitorCache monitorData]).reverseObjectEnumerator.allObjects;
    [self.tableView reloadData];
}

- (void)removeMonitorData{
    [TPMonitorCache removeMonitorData];
    self.data = [TPMonitorCache monitorData];
    [self.tableView reloadData];
}

- (NSString *)cellClass{
    return @"TPMonitorTableViewCell_Class";
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [NSObject performTarget:TPRouter.routerClass action:TPRouter.routerJumpUrlParams object:@"TPPoObjectViewController" object:@{@"object":self.data[indexPath.row]}];
}
@end
