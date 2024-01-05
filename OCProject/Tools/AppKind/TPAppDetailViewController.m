//
//  TPAppDetailViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/22.
//

#import "TPAppDetailViewController.h"

@interface TPAppDetailViewController ()
@end

@implementation TPAppDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"app信息详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"openUrl" style:(UIBarButtonItemStyleDone) target:self action:@selector(openURL)];
    
    self.data = self.model.propertyList;
    [self.tableView reloadData];
}

- (void)openURL{
#ifdef DEBUG
    NSObject *workspace = [NSObject performTarget:@"LSApplicationWorkspace_Class" action:@"defaultWorkspace"];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [workspace performSelector:NSSelectorFromString(@"openApplicationWithBundleID:") withObject:self.model.bundleIdentifier];
#pragma clang diagnostic pop
#endif
}

- (NSString *)cellClass{
    return @"TPPoObjectTableViewCell_Class";
}

@end
