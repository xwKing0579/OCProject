//
//  TPLeaksViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/22.
//

#import "TPLeaksViewController.h"
#import "MLeaksMessenger.h"
@interface TPLeaksViewController ()
@end

@implementation TPLeaksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"内存泄漏";
    
    NSMutableArray *data = [NSMutableArray array];
    for (NSNumber *num in [MLeaksMessenger leaks]) {
        NSString *ptr = [[NSString alloc] initWithFormat:@"0x%llx",num.unsignedLongLongValue];
        uintptr_t hex = strtoull(ptr.UTF8String, NULL, 0);
        id obj = (__bridge id)(void *)hex;
        if (obj) [data addObject:obj];
    }
    self.data = data;
    [self.tableView reloadData];
}

- (NSString *)cellClass{
    return @"TPLeaksTableViewCell_Class";
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [NSObject performTarget:TPRouter.routerClass action:TPRouter.routerJumpUrlParams object:@"TPPoObjectViewController" object:@{@"object":self.data[indexPath.row]}];
}

@end
