//
//  TPAppKindViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/22.
//

#import "TPAppKindViewController.h"
#import "TPAppKindModel.h"

@interface TPAppKindViewController ()
@property (nonatomic, strong) NSArray <TPAppKindModel *>*result;
@end

@implementation TPAppKindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"手机安装APP";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"sort" style:(UIBarButtonItemStyleDone) target:self action:@selector(sortUserData)];
    
    [TPToastManager showText:@"数据加载中..."];
    
#ifdef DEBUG
    [TPAppKindModel sysetmAppList:^(NSArray<TPAppKindModel *> * _Nonnull appList) {
        self.data = appList;
        self.result = appList;
        [self.tableView reloadData];
    }];
#endif
}

- (void)sortUserData{
    UIAlertController *alertController = [UIAlertController alertStyle:UIAlertControllerStyleActionSheet title:@"appList" message:nil cancel:@"取消" cancelBlock:^(NSString * _Nonnull cancel) {
        
    } confirms:@[@"system",@"user",@"system&user"] confirmBlock:^(NSUInteger index) {
        if (index == 0){
            self.data = [self.result filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"applicationType != %@",@"User"]];
        }else if (index == 1){
            self.data = [self.result filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"applicationType == %@",@"User"]];
        }else{
            self.data = self.result;
        }
        [self.tableView reloadData];
    }];
    [self presentViewController:alertController animated:YES completion:nil];
   
}

- (NSString *)cellClass{
    return TPString.tc_app_kind;
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [TPRouter jumpUrl:TPString.vc_app_detail params:@{@"model":self.data[indexPath.row]}];
}

@end
