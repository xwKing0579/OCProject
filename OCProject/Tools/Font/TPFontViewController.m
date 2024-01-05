//
//  TPFontViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/20.
//

#import "TPFontViewController.h"

@interface TPFontViewController ()

@end

@implementation TPFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"字体列表";
    
    self.data = [UIFont familyNames];
    [self.tableView reloadData];
}

- (NSString *)cellClass{
    return @"TPFontTableViewCell_Class";
}

@end
