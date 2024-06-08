//
//  TPJsonObjectModel.h
//  FXTP
//
//  Created by 王祥伟 on 2024/6/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPJsonObjectModel : NSObject
@property (nonatomic, copy) NSObject *key;
@property (nonatomic, copy) NSObject *value;
+ (void)toJson:(NSObject * _Nullable)obj;
@end

NS_ASSUME_NONNULL_END
