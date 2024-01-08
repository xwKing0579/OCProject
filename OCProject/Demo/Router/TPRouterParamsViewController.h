//
//  TPRouterParamsViewController.h
//  OCProject
//
//  Created by 王祥伟 on 2024/1/8.
//

#import "TPBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPRouterParamsViewController : TPBaseTableViewController
@property (nonatomic, strong) NSString *vcString;
@property (nonatomic, assign) BOOL push;
@property (nonatomic, assign) BOOL present;
@property (nonatomic, assign) NSInteger presentStyle;
@property (nonatomic, assign) BOOL animation;
@property (nonatomic, strong) NSString *param1;
@property (nonatomic, strong) NSString *param2;
@property (nonatomic, strong) id customParams;

@end

NS_ASSUME_NONNULL_END
