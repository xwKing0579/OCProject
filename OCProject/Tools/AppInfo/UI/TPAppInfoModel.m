//
//  TPAppInfoModel.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/12.
//

#import "TPAppInfoModel.h"
#import "TPAppInfoManager.h"
#import "TPRAMUsage.h"
@implementation TPAppInfoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"item" : [TPAppInfoListModel class]};
}

+ (NSArray <NSDictionary *>*)data{
    NSArray *data = @[
        @{@"title":@"app信息",
          @"item":@[
              @{@"name":@"bundle name",@"content":[TPAppInfoManager bundleName]},
              @{@"name":@"名称",@"content":[TPAppInfoManager appName]},
              @{@"name":@"bundle",@"content":[TPAppInfoManager appBundle]},
              @{@"name":@"版本",@"content":[TPAppInfoManager appVersion]},
              @{@"name":@"最低系统版本",@"content":[TPAppInfoManager appMinSystemVersion]},
              @{@"name":@"内存使用",@"content":[NSString sizeString:[TPRAMUsage getAppRAMUsage]]},
          ]},
        @{@"title":@"设备信息",
          @"item":@[
              @{@"name":@"名称",@"content":[TPAppInfoManager deviceName]},
              @{@"name":@"型号",@"content":[TPAppInfoManager deviceModel]},
              @{@"name":@"尺寸",@"content":[TPAppInfoManager deviceSize]},
              @{@"name":@"scale",@"content":[TPAppInfoManager deviceScale]},
              @{@"name":@"版本",@"content":[TPAppInfoManager systemVersion]},
              @{@"name":@"语言",@"content":[TPAppInfoManager systemLanguage]},
              @{@"name":@"内存使用",@"content":[NSString sizeString:[TPRAMUsage getSystemRAMUsage]]},
              @{@"name":@"内存剩余",@"content":[NSString sizeString:[TPRAMUsage getSystemRAMAvailable]]},
              @{@"name":@"内存总量",@"content":[NSString sizeString:[TPRAMUsage getSystemRAMTotal]]},
          ]}
    ];
    return [NSArray yy_modelArrayWithClass:[self class] json:data];
}

@end


@implementation TPAppInfoListModel

@end
