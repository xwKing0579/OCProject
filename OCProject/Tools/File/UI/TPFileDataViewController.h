//
//  TPFileDataViewController.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/15.
//

#import "TPBaseViewController.h"
#import "TPBaseTableViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPFileDataViewController : TPBaseTableViewController
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSDictionary *dic;
@end

NS_ASSUME_NONNULL_END
