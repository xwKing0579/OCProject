//
//  MBProgressHUD+Category.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/18.
//

#import "MBProgressHUD+Category.h"

@implementation MBProgressHUD (Category)

+ (void)showText:(NSString *)text{
    UIView *container = UIViewController.currentViewController.view;
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:container];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.7];
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabel.text = text;
    hud.detailsLabel.textColor = UIColor.cffffff;
    [container addSubview:hud];
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:3];
}

@end
