//
//  MBProgressHUD+Category.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/18.
//

#import "MBProgressHUD+Category.h"
#import "Lottie/Lottie.h"
#import "NSObject+MemoryLeak.h"

static MBProgressHUD *_textHud;
static MBProgressHUD *_loadingHud;
@implementation MBProgressHUD (Category)

+ (void)showText:(NSString *)text{
    [self showText:text inView:UIViewController.currentViewController.view];
}

+ (void)showText:(NSString *)text inView:(UIView *)view{
    [self showText:text inView:view enable:YES];
}

+ (void)showText:(NSString *)text inView:(UIView *)view enable:(BOOL)enable{
    [self showText:text inView:view enable:enable afterDelay:0];
}

+ (void)showText:(NSString *)text inView:(UIView *)view enable:(BOOL)enable afterDelay:(NSTimeInterval)afterDelay{
    if (!_textHud) _textHud = [MBProgressHUD new];
    MBProgressHUD *hud = _textHud;
    hud.userInteractionEnabled = !enable;
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.7];
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabel.text = text;
    hud.detailsLabel.textColor = UIColor.whiteColor;
    UIView *rootView = view ?: UIViewController.window;
    [rootView addSubview:hud];
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:afterDelay ?: 3];
}

+ (void)showLoading{
    [self showLoadingInView:UIViewController.currentViewController.view];
}

+ (void)showLoadingInView:(UIView *)view{
    [self showLoadingInView:view enable:YES];
}

+ (void)showLoadingInView:(UIView *)view enable:(BOOL)enable{
    if (!_loadingHud) _loadingHud = [MBProgressHUD new];
    MBProgressHUD *hud = _loadingHud;
    hud.userInteractionEnabled = !enable;
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = UIColor.clearColor;
    LOTAnimationView *customView = [LOTAnimationView animationNamed:@"loading"];
    customView.loopAnimation = YES;
    [customView play];
    hud.customView = customView;
    UIView *rootView = view ?: UIViewController.window;
    [rootView addSubview:hud];
    [customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.height.mas_equalTo(100);
    }];
    [hud showAnimated:YES];
}

+ (void)hideLoading{
    [_textHud hideAnimated:YES];
    [_loadingHud hideAnimated:YES];
}

- (BOOL)willDealloc{
    return YES;
}

@end
