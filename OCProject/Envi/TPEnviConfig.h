//
//  TPEnviConfig.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,TPSchemeEnvi){
    TPSchemeEnviDev = 0,
    TPSchemeEnviPreRelese,
    TPSchemeEnviRelese,
};
@interface TPEnviConfig : NSObject

+ (TPSchemeEnvi)envi;

@end

NS_ASSUME_NONNULL_END
