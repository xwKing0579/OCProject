//
//  TPAppInfoModel.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class TPAppInfoListModel;
@interface TPAppInfoModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray <TPAppInfoListModel *>*item;

+ (NSArray <TPAppInfoModel *>*)data;

@end

@interface TPAppInfoListModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *content;
@end
NS_ASSUME_NONNULL_END
