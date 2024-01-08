//
//  TPUserDefaultsController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/19.
//

#import "TPUserDefaultsController.h"

@interface TPUserDefaultsController ()
@property (nonatomic, strong) NSDictionary <NSString *, id>*dict;
@end

@implementation TPUserDefaultsController

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
    return [NSObject performTarget:@"TPUserDefaultsTableViewCell_Class" action:@"initWithTableView:withKey:withValue:" objects:@{@"object1":tableView,@"object2":self.dict.allKeys[indexPath.row],@"object3":self.dict[self.dict.allKeys[indexPath.row]]}] ?: [UITableViewCell new];
}
@end
