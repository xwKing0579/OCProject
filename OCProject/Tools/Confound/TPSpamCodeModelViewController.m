//
//  TPSpamCodeModelViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/22.
//

#import "TPSpamCodeModelViewController.h"

@interface TPSpamCodeModelViewController ()
@property (nonatomic, strong) UITextView *textView;
@end

@implementation TPSpamCodeModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (UITextView *)textView{
    if (!_textView){
        _textView = [[UITextView alloc] init];
        _textView.font = UIFont.font16;
        _textView.textColor = UIColor.c000000;
        _textView.placeholder = @".h文件模版";
        _textView.backgroundColor = UIColor.cbfbfbf;
       
        [self.view addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.top.mas_equalTo(30);
            make.height.mas_equalTo(150);
        }];
    }
    return _textView;
}

@end
