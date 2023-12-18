//
//  TPFileManager.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/15.
//

#import <Foundation/Foundation.h>
#import "TPFileModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPFileManager : NSObject

+ (NSArray <TPFileModel *>*)defaultFile;
+ (NSArray <TPFileModel *>*)dataForFilePath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
