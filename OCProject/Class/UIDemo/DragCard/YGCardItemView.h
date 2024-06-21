//
//  YGCardItemView.h
//  OCProject
//
//  Created by 王祥伟 on 2024/6/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YGCardItemView : UIView
@property (nonatomic, copy) void (^switchBlock)(BOOL finish);
@end

NS_ASSUME_NONNULL_END
