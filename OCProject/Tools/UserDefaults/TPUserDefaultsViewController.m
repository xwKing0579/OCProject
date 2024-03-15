//
//  TPUserDefaultsViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/15.
//

#import "TPUserDefaultsViewController.h"

@interface TPUserDefaultsViewController ()
@property (nonatomic, strong) NSDictionary <NSString *, id>*dict;
@end

@implementation TPUserDefaultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"UserDefaults";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"delete"].original style:(UIBarButtonItemStyleDone) target:self action:@selector(removeUserDefaulesData)];
    self.dict = NSUserDefaults.standardUserDefaults.dictionaryRepresentation;
    [self.tableView reloadData];
}

- (void)removeUserDefaulesData{
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:NSBundle.mainBundle.bundleIdentifier];
    self.dict = NSUserDefaults.standardUserDefaults.dictionaryRepresentation;
    [self.tableView reloadData];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dict.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [NSObject performTarget:TPString.tc_user_defaults.classString action:@"initWithTableView:withKey:withValue:" objects:@{@"1":tableView,@"2":self.dict.allKeys[indexPath.row],@"3":self.dict[self.dict.allKeys[indexPath.row]]}] ?: [UITableViewCell new];
}

@end
