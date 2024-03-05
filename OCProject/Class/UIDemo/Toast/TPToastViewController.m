//
//  TPToastViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/1/25.
//

#import "TPToastViewController.h"

@interface TPToastViewController ()

@end

@implementation TPToastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ///这里只demo演示，如需文本和图片混合使用可以自己实现
    self.data = @[@"通用文本",@"动画自定义",@"loading2(未定义)",@"视图自定义",@"时间自定义10s",@"hide"];
}

- (NSString *)cellClass{
    return @"TPHomeTableViewCell_Class";
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [TPToastManager showText:@"TPToastManager使我们上层使用的类，可以自定义类、方法，MBProgressHUD是下层库，一般可以是私有库、三方sdk，这样写既可以解耦，在我们替换三方库的时候直接去修改中间方法实现，即使我们删掉三方库也能正常运行，极大提高开发效率" inView:nil enable:NO];
            break;
        case 1:
            [TPToastManager showLoadingInView:nil enable:NO];
            break;
        case 2:
            ///测试用，当我们定义一个不存在方法也不会出现问题
            [TPToastManager showLoading2];
            break;
        case 3:
            [TPToastManager showText:@"view可以自定义，参考32行demo" inView:UIViewController.window enable:NO];
            break;
        case 4:
            [TPToastManager showText:@"显示时间自定义10s" inView:nil enable:NO afterDelay:10];
            break;
        case 5:
            [TPToastManager hideLoading];
            break;
        default:
            break;
    }
}

@end
