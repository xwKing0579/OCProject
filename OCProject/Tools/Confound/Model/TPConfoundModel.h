//
//  TPConfoundModel.h
//  OCProject
//
//  Created by 王祥伟 on 2024/3/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPConfoundModel : NSObject
@property (nonatomic, copy) NSString *idStr;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) BOOL setting;
@property (nonatomic, assign) BOOL selecte;

@end

NS_ASSUME_NONNULL_END
