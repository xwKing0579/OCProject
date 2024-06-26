//
//  TPHomeViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import "TPHomeViewController.h"
#import "TPSpamMethod.h"
#import "TPModifyProject.h"
@interface TPHomeViewController ()

@end

@implementation TPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.data = @[ROUTER_DEMO(TPString.vc_router_demo,@"路由演示demo"),
                  ROUTER_DEMO(TPString.vc_meditor_demo,@"中间件demo"),
                  ROUTER_DEMO(TPString.vc_analysis_demo,@"无痕埋点demo"),
    ];
    [self.tableView reloadData];
 

    //[TPModifyProject searchProjectName:@"/Users/wangxiangwei/Desktop/fxtp" keyWord:@"该文件内容自动生成，手动修改无效"];
    //[TPModifyProject modify2FilePrefix:@"/Users/wangxiangwei/Desktop/uasa_Live" newPrefix:@""];
    [TPModifyProject replaceImagesInDirectory:@"/Users/wangxiangwei/Desktop/test" toDirectory:@"/Users/wangxiangwei/Desktop/test"];
}

- (NSString *)cellClass{
    return TPString.tc_home;
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [TPRouter jumpUrl:self.data[indexPath.row]];
}

@end
