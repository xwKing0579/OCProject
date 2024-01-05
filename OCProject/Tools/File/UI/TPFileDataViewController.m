//
//  TPFileDataViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/15.
//

#import "TPFileDataViewController.h"

@interface TPFileDataViewController ()
@end

@implementation TPFileDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.fileName;
    
    [self.tableView reloadData];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dic.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [NSObject performTarget:@"TPFileDataTableViewCell_Class" action:@"initWithTableView:withKey:withValue:" objects:@{@"object1":tableView,@"object2":self.dic.allKeys[indexPath.row],@"object3":self.dic[self.dic.allKeys[indexPath.row]]}] ?: [UITableViewCell new];
}

@end
