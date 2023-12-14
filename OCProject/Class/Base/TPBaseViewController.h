//
//  TPBaseViewController.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPBaseViewController : UIViewController

///hidden navbar
- (BOOL)hideNavigationBar;

///back
- (void)backViewController;

///允许重复出现
- (BOOL)controllerOverlap;

@end

NS_ASSUME_NONNULL_END
