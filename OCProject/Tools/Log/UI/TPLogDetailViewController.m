//
//  TPLogDetailViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/19.
//

#import "TPLogDetailViewController.h"

@interface TPLogDetailViewController ()

@end

@implementation TPLogDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"日志详情";
    
    [self setUpSubViews];
}

- (void)setUpSubViews{
    UITextView *textView = [[UITextView alloc] init];
    textView.editable = NO;
    textView.font = UIFont.font14;
    [self.view addSubview:textView];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    textView.text = [NSString stringWithFormat:@"日志：%@\n\n时间：%@\n\n线程：%@",self.model.content,self.model.date,self.model.thread];
}

@end
