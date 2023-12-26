//
//  TPLeakObjectViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/22.
//

#import "TPLeakObjectViewController.h"

@interface TPLeakObjectViewController ()
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIButton *shotView;
@end

@implementation TPLeakObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"对象闪照";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"color" style:(UIBarButtonItemStyleDone) target:self action:@selector(changeLeakObjectColor)];
    [self leakObjectShotImage];
}

- (void)changeLeakObjectColor{
    NSDictionary *colors = @{@"clear":UIColor.clearColor,@"white":UIColor.whiteColor,@"black":UIColor.blackColor};
    UIAlertController *alertController = [UIAlertController alertStyle:UIAlertControllerStyleActionSheet title:@"修改背景色" message:@"" cancel:@"取消" cancelBlock:^(NSString * _Nonnull cancel) {
        
    } confirm:colors.allKeys confirmBlock:^(NSUInteger index) {
        NSArray *values = colors.allValues;
        self.bgColor = values[index];
        [self leakObjectShotImage];
    }];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)leakObjectShotImage{
    UIImage *shotImage = nil;
    if ([self.object isKindOfClass:[UIViewController class]]){
        UIViewController *vc = (UIViewController *)self.object;
        if (self.bgColor) vc.view.backgroundColor = self.bgColor;
        shotImage = [vc.view toImage];
    }else if ([self.object isKindOfClass:[UIView class]]) {
        UIView *view = (UIView *)self.object;
        if (self.bgColor) view.backgroundColor = self.bgColor;
        shotImage = [view toImage];
    }else if ([self.object isKindOfClass:[NSObject class]]) {
        NSString *desc = [self.object description];
        UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
        label.text = desc;
        label.font = UIFont.font16;
        label.textColor = UIColor.redColor;
        label.numberOfLines = 0;
        if (self.bgColor) label.backgroundColor = self.bgColor;
        
        shotImage = [label toImage];
    }
    if (shotImage) [self.shotView setImage:shotImage forState:UIControlStateNormal];
}

- (UIButton *)shotView{
    if (!_shotView){
        _shotView = [[UIButton alloc] init];
        _shotView.layer.borderWidth = 2;
        _shotView.layer.borderColor = UIColor.redColor.CGColor;
        [self.view addSubview:_shotView];
        [_shotView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.width.mas_lessThanOrEqualTo(self.view.width-60);
            make.height.mas_lessThanOrEqualTo(self.view.height-120);
        }];
    }
    return _shotView;
}

@end
