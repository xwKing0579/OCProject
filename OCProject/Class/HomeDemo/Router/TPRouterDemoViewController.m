//
//  TPRouterDemoViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/1/5.
//

#import "TPRouterDemoViewController.h"

@interface TPRouterDemoViewController ()
@property (nonatomic, strong) NSString *vc;
@end

@implementation TPRouterDemoViewController

///默认传递控制器的名字既可以跳转，一般映射一下控制器的名称避免暴漏给外部
///这里可以重写TPRouter的classValue方法起一个页面别名
/*
 1.push
 eg1：<vc>、/<vc>
 eg2：native/<vc>、/native/<vc>
 eg3：ocproject://oc.com/native/<vc> 一般给外部使用
 */

///下面同样支持上面多种写法，不再重复

/*
 2.present
 <vc>/present
 */

/*
 3.presentStyle
 <vc>/present?modalPresentationStyle=0
 modalPresentationStyle在【0,7】& -2区间，或者添加到params中
 eg：
 @{@"modalPresentationStyle":@(1)}
 @{@"modalPresentationStyle":[NSNumber numberWithInteger:UIModalPresentationPageSheet]}
 */

/*
 4.跳转无动画,支持push&present
 <vc>/noanimation
 */

/*
 5.传参，后台参数一般都是字符串类型
 <vc>?param1=我是参数1&param2=我是参数2
 或者将参数添加到字典中，传递给params
 */

/*
 6.自定义参数，开发中我们有许多自定义参数无法以字符串方式传递没
 <vc>
 将参数添加到字典中，传递给params
 */

/*
 7.回调block
 <vc>
 将参数block添加到字典中，传递给params
 */

/*
 8.自定义navigation, 仅支持present
 <vc>?navigationClass=nav
 或者将参数添加到字典中，传递给params
 */

/*
 9.controllerOverlap 同一个页面是否允许连续出现
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.vc = TPRouter.vc_router_params;
    self.data = @[@"push",@"present",@"presentStyle",@"跳转无动画",@"传参",@"自定义参数",@"回调",@"自定义navigation"];
    [self.tableView reloadData];
}

- (NSString *)cellClass{
    return @"TPHomeTableViewCell_Class";
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *customParams = [NSMutableDictionary dictionaryWithDictionary:
                                         @{@"vcString":self.vc,
                                           @"push":@"1",
                                           @"present":@"0",
                                           @"animation":@"1"}];
 
    switch (indexPath.row) {
        case 1:{
            ///BOOL类型支持多种表达
            [customParams setValue:@1 forKey:@"present"];
            NSString *url = [NSString stringWithFormat:@"%@/present",self.vc];
            [TPRouter jumpUrl:url params:customParams];
            break;
        }
        case 2:{
            UIAlertController *alert = [UIAlertController alertStyle:UIAlertControllerStyleActionSheet title:@"presentStyle" message:@"" cancel:@"取消" cancelBlock:^(NSString * _Nonnull cancel) {
                
            } confirms:@[@"UIModalPresentationFullScreen",@"UIModalPresentationPageSheet",@"UIModalPresentationFormSheet",@"UIModalPresentationCurrentContext",@"UIModalPresentationCustom",@"UIModalPresentationOverFullScreen",@"UIModalPresentationOverCurrentContext",@"UIModalPresentationPopover",@"UIModalPresentationAutomatic"] confirmBlock:^(NSUInteger index) {
                NSInteger presentStyle = index;
                if (index == 9) presentStyle = -2;
                [customParams setValue:@1 forKey:@"present"];
                [customParams setValue:@(presentStyle) forKey:@"modalPresentationStyle"];
                NSString *url = [NSString stringWithFormat:@"%@/present",self.vc];
                [TPRouter jumpUrl:url params:customParams];
            }];
            [self presentViewController:alert animated:YES completion:nil];
            break;
        }
        case 3:{
            ///固定写法
            NSString *url = [NSString stringWithFormat:@"%@/noanimation",self.vc];
            [TPRouter jumpUrl:url params:customParams];
            break;
        }
        case 4:{
            NSString *param1 = @"参数1";
            NSString *param2 = @"参数2";
            NSString *url = [NSString stringWithFormat:@"%@?param1=%@&param2=%@",self.vc,param1,param2];
            [TPRouter jumpUrl:url params:customParams];
            break;
        }
        case 5:{
            ///自定义参数
            [customParams setValue:[NSDate date] forKey:@"customParams"];
            [TPRouter jumpUrl:self.vc params:customParams];
            break;
        }
        case 6:{
            ///这里使用通用回调，否则需要引用头文件或者动态时
            TPBaseViewController *vc = [TPRouter jumpUrl:self.vc params:customParams];
            vc.block = ^(id  _Nonnull object) {
                NSLog(@"获取回调内容=%@",object);
            };
            break;
        }
        case 7:{
            ///自定义nav，仅支持present
            NSString *url = [NSString stringWithFormat:@"%@/present?navigationClass=UINavigationController",self.vc];
            //[customParams setValue:@"UINavigationController" forKey:@"navigationClass"];
            [TPRouter jumpUrl:url params:customParams];
            break;
        }
        default:
            [TPRouter jumpUrl:self.vc params:customParams];
            break;
    }
}

@end
