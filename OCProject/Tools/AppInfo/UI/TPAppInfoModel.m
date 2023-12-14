//
//  TPAppInfoModel.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/12.
//

#import "TPAppInfoModel.h"
#import "TPAppInfoManager.h"

@implementation TPAppInfoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"item" : [TPAppInfoListModel class]};
}

+ (NSArray <NSDictionary *>*)data{
    NSArray *data = @[
        @{@"title":@"app信息",
          @"item":@[
    @{@"name":@"名称",@"content":[TPAppInfoManager appName]},
    @{@"name":@"bundle",@"content":[TPAppInfoManager appBundle]},
    @{@"name":@"版本",@"content":[TPAppInfoManager appVersion]}]},
        @{@"title":@"设备信息",
          @"item":@[
              @{@"name":@"名称",@"content":[TPAppInfoManager deviceName]},
              @{@"name":@"型号",@"content":[TPAppInfoManager deviceModel]},
              @{@"name":@"尺寸",@"content":[TPAppInfoManager deviceSize]},
              @{@"name":@"版本",@"content":[TPAppInfoManager systemVersion]},
              @{@"name":@"语言",@"content":[TPAppInfoManager systemLanguage]}]}
    ];
    return [NSArray yy_modelArrayWithClass:[self class] json:data];
}

@end


@implementation TPAppInfoListModel

@end
