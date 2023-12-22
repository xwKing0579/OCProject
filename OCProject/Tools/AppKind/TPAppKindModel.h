//
//  TPAppKindModel.h
//  OCProject
//
//  Created by 王祥伟 on 2023/12/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPAppKindModel : NSObject

@property (nonatomic, copy) NSString *bundleIdentifier;
@property (nonatomic, copy) NSString *applicationDSID;
@property (nonatomic, copy) NSString *applicationIdentifier;
@property (nonatomic, copy) NSString *applicationType;
@property (nonatomic, copy) NSString *dynamicDiskUsage;
@property (nonatomic, copy) NSString *itemID;
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *minimumSystemVersion;
@property (nonatomic, copy) NSString *requiredDeviceCapabilities;
@property (nonatomic, copy) NSString *sdkVersion;
@property (nonatomic, copy) NSString *shortVersionString;
@property (nonatomic, copy) NSString *sourceAppIdentifier;
@property (nonatomic, copy) NSString *staticDiskUsage;
@property (nonatomic, copy) NSString *teamID;
@property (nonatomic, copy) NSString *vendorName;

typedef void(^TPAppListBlock)(NSArray <TPAppKindModel *>*appList);

#ifdef DEBUG
+ (void)sysetmAppList:(TPAppListBlock)block;
#endif

@end

NS_ASSUME_NONNULL_END
