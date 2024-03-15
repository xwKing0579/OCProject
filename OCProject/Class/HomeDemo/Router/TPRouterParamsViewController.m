//
//  TPRouterParamsViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/1/8.
//

#import "TPRouterParamsViewController.h"

@interface TPRouterParamsViewController ()

@end

@implementation TPRouterParamsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"路由参数列表";
    NSMutableArray *data = [NSMutableArray arrayWithArray:self.propertyList];
    if (self.navigationController){
        [data addObject:@{@"navigation":NSStringFromClass([self.navigationController class])}];
    }
    if (self.block){
        [data addObject:@{@"block":@"点击回调"}];
    }
    [data addObject:@{@"back":@"点击返回上一页"}];
    [data addObject:@{@"noanimation":@"点击返回无动画"}];
    [data addObject:@{TPString.vc_home:@"点击返回home页面"}];
    [data addObject:@{@"index_2":@"点击返回我的页面"}];
    self.data = data;
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.data[indexPath.row];
    NSString *key = dict.allKeys.firstObject;
    NSString *cellClass = TPString.tc_file_data;
    if ([key isEqualToString:@"block"] || 
        [key isEqualToString:@"back"] ||
        [key isEqualToString:@"noanimation"] ||
        [key isEqualToString:TPString.vc_home] ||
        [key isEqualToString:@"index_2"]){
        cellClass = TPString.tc_router_params;
    }
    return [NSObject performTarget:cellClass.classString action:[self actionString] object:tableView object:dict] ?: [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.data[indexPath.row];
    NSString *key = dict.allKeys.firstObject;
    if ([key isEqualToString:@"block"]){
        if (self.block) self.block(@"success");
    }else if ([key isEqualToString:@"back"]){
        [TPRouter back];
    }else if ([key isEqualToString:@"noanimation"] ||
              [key isEqualToString:TPString.vc_home] ||
              [key isEqualToString:@"index_2"]){
        [TPRouter backUrl:key];
    }
}

@end
