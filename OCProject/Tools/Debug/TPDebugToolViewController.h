//
//  TPDebugToolViewController.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/7.
//

#import "TPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class TPDebugToolViewCell,TPDebugToolModel;
@interface TPDebugToolViewController : TPBaseViewController

@end


@interface TPDebugToolViewCell : UICollectionViewCell

@property (nonatomic, copy) TPDebugToolModel *model;

@end

@interface TPDebugToolModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *target;
@property (nonatomic, copy) NSString *action;

+ (NSArray *)data;
@end

NS_ASSUME_NONNULL_END
