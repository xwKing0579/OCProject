//
//  TPBaseViewController.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPBaseViewController : UIViewController

///通用回调
@property (nonatomic, copy) TPRouterBlock block;

///hidden navbar
- (BOOL)hideNavigationBar;

///back
- (void)backViewController;

@end

NS_ASSUME_NONNULL_END
