//
//  TPEmptyDataViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/1/12.
//

#import "TPEmptyDataViewController.h"
#import <UIScrollView+EmptyDataSet.h>

@interface TPEmptyDataViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation TPEmptyDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    [self.tableView reloadData];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    return [[NSAttributedString alloc] initWithString:self.title];
}

@end
