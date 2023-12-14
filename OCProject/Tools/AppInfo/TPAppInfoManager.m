//
//  TPAppInfoManager.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/12.
//

#import "TPAppInfoManager.h"
//model
#import <sys/utsname.h>

NSString *const kTPAppInfoUnknown = @"Unknown";

@implementation TPAppInfoManager

//app信息
+ (NSString *)appName{
    return [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"] ?: kTPAppInfoUnknown;
}

+ (NSString *)appBundle{
    return [NSBundle mainBundle].infoDictionary[@"CFBundleIdentifier"] ?: kTPAppInfoUnknown;
}

+ (NSString *)appVersion{
    return [NSString stringWithFormat:@"%@(%@)",[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] ?: kTPAppInfoUnknown,[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"] ?: kTPAppInfoUnknown];
}

//设备信息
+ (NSString *)deviceName{
    return [UIDevice currentDevice].name ?: kTPAppInfoUnknown;
}

///https://www.theiphonewiki.com/wiki/Models
+ (NSString *)deviceModel{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if([platform isEqualToString:@"iPhone1,1"]) return@"iPhone 2G";
    if([platform isEqualToString:@"iPhone1,2"]) return@"iPhone 3G";
    if([platform isEqualToString:@"iPhone2,1"]) return@"iPhone 3GS";
    if([platform isEqualToString:@"iPhone3,1"]) return@"iPhone 4";
    if([platform isEqualToString:@"iPhone3,2"]) return@"iPhone 4";
    if([platform isEqualToString:@"iPhone3,3"]) return@"iPhone 4";
    if([platform isEqualToString:@"iPhone4,1"]) return@"iPhone 4S";
    if([platform isEqualToString:@"iPhone5,1"]) return@"iPhone 5";
    if([platform isEqualToString:@"iPhone5,2"]) return@"iPhone 5";
    if([platform isEqualToString:@"iPhone5,3"]) return@"iPhone 5c";
    if([platform isEqualToString:@"iPhone5,4"]) return@"iPhone 5c";
    if([platform isEqualToString:@"iPhone6,1"]) return@"iPhone 5s";
    if([platform isEqualToString:@"iPhone6,2"]) return@"iPhone 5s";
    if([platform isEqualToString:@"iPhone7,1"]) return@"iPhone 6Plus";
    if([platform isEqualToString:@"iPhone7,2"]) return@"iPhone 6";
    if([platform isEqualToString:@"iPhone8,1"]) return@"iPhone 6s";
    if([platform isEqualToString:@"iPhone8,2"]) return@"iPhone 6sPlus";
    if([platform isEqualToString:@"iPhone8,4"]) return@"iPhone SE";
    if([platform isEqualToString:@"iPhone9,1"]) return@"iPhone 7";
    if([platform isEqualToString:@"iPhone9,2"]) return@"iPhone 7Plus";
    if([platform isEqualToString:@"iPhone10,1"])return@"iPhone 8";
    if([platform isEqualToString:@"iPhone10,4"])return@"iPhone 8";
    if([platform isEqualToString:@"iPhone10,2"])return@"iPhone 8Plus";
    if([platform isEqualToString:@"iPhone10,5"])return@"iPhone 8Plus";
    if([platform isEqualToString:@"iPhone10,3"])return@"iPhone X";
    if([platform isEqualToString:@"iPhone10,6"])return@"iPhone X";
    if([platform isEqualToString:@"iPhone11,8"])return@"iPhone XR";
    if([platform isEqualToString:@"iPhone11,2"])return@"iPhone XS";
    if([platform isEqualToString:@"iPhone11,4"])return@"iPhone XSMax";
    if([platform isEqualToString:@"iPhone11,6"])return@"iPhone XSMax";
    if([platform isEqualToString:@"iPhone12,1"])return@"iPhone 11";
    if([platform isEqualToString:@"iPhone12,3"])return@"iPhone 11 Pro";
    if([platform isEqualToString:@"iPhone12,5"])return@"iPhone 11 Pro Max";
    if([platform isEqualToString:@"iPhone12,8"]) return @"iPhone SE (2nd generation)";
    if([platform isEqualToString:@"iPhone13,1"])return@"iPhone 12 mini";
    if([platform isEqualToString:@"iPhone13,2"])return@"iPhone 12";
    if([platform isEqualToString:@"iPhone13,3"])return@"iPhone 12 Pro";
    if([platform isEqualToString:@"iPhone13,4"])return@"iPhone 12 Pro Max";
    if([platform isEqualToString:@"iPhone14,2"])return@"iPhone 13 Pro";
    if([platform isEqualToString:@"iPhone14,3"])return@"iPhone 13 Pro Max";
    if([platform isEqualToString:@"iPhone14,4"])return@"iPhone 13 Mini";
    if([platform isEqualToString:@"iPhone14,5"])return@"iPhone 13";
    
    //2022年3月9日，新款iPhone SE 三代发布
    if ([platform isEqualToString:@"iPhone14,6"]) return @"iPhone SE (3nd generation)";
    
    //2022年9月8日，新款iPhone 14、14 plus、iPhone 14 Pro、14 Pro Max
    if([platform isEqualToString:@"iPhone14,7"])return@"iPhone 14";
    if([platform isEqualToString:@"iPhone14,8"])return@"iPhone 14 plus";
    if([platform isEqualToString:@"iPhone15,2"])return@"iPhone 14 Pro";
    if([platform isEqualToString:@"iPhone15,3"])return@"iPhone 14 Pro Max";
    if([platform isEqualToString:@"iPod1,1"]) return@"iPod Touch 1G";
    if([platform isEqualToString:@"iPod2,1"]) return@"iPod Touch 2G";
    if([platform isEqualToString:@"iPod3,1"]) return@"iPod Touch 3G";
    if([platform isEqualToString:@"iPod4,1"]) return@"iPod Touch 4G";
    if([platform isEqualToString:@"iPod5,1"]) return@"iPod Touch 5G";
    if([platform isEqualToString:@"iPad1,1"]) return@"iPad 1G";
    if([platform isEqualToString:@"iPad2,1"]) return@"iPad 2";
    if([platform isEqualToString:@"iPad2,2"]) return@"iPad 2";
    if([platform isEqualToString:@"iPad2,3"]) return@"iPad 2";
    if([platform isEqualToString:@"iPad2,4"]) return@"iPad 2";
    if([platform isEqualToString:@"iPad2,5"]) return@"iPad Mini 1G";
    if([platform isEqualToString:@"iPad2,6"]) return@"iPad Mini 1G";
    if([platform isEqualToString:@"iPad2,7"]) return@"iPad Mini 1G";
    if([platform isEqualToString:@"iPad3,1"]) return@"iPad 3";
    if([platform isEqualToString:@"iPad3,2"]) return@"iPad 3";
    if([platform isEqualToString:@"iPad3,3"]) return@"iPad 3";
    if([platform isEqualToString:@"iPad3,4"]) return@"iPad 4";
    if([platform isEqualToString:@"iPad3,5"]) return@"iPad 4";
    if([platform isEqualToString:@"iPad3,6"]) return@"iPad 4";
    if([platform isEqualToString:@"iPad4,1"]) return@"iPad Air";
    if([platform isEqualToString:@"iPad4,2"]) return@"iPad Air";
    if([platform isEqualToString:@"iPad4,3"]) return@"iPad Air";
    if([platform isEqualToString:@"iPad4,4"]) return@"iPad Mini 2G";
    if([platform isEqualToString:@"iPad4,5"]) return@"iPad Mini 2G";
    if([platform isEqualToString:@"iPad4,6"]) return@"iPad Mini 2G";
    if([platform isEqualToString:@"iPad4,7"]) return@"iPad Mini 3";
    if([platform isEqualToString:@"iPad4,8"]) return@"iPad Mini 3";
    if([platform isEqualToString:@"iPad4,9"]) return@"iPad Mini 3";
    if([platform isEqualToString:@"iPad5,1"]) return@"iPad Mini 4";
    if([platform isEqualToString:@"iPad5,2"]) return@"iPad Mini 4";
    if([platform isEqualToString:@"iPad5,3"]) return@"iPad Air 2";
    if([platform isEqualToString:@"iPad5,4"]) return@"iPad Air 2";
    if([platform isEqualToString:@"iPad6,3"]) return@"iPad Pro 9.7";
    if([platform isEqualToString:@"iPad6,4"]) return@"iPad Pro 9.7";
    if([platform isEqualToString:@"iPad6,7"]) return@"iPad Pro 12.9";
    if([platform isEqualToString:@"iPad6,8"]) return@"iPad Pro 12.9";

    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"] || [platform isEqualToString:@"arm64"]) return @"Simulator";
    return kTPAppInfoUnknown;
}

+ (NSString *)deviceSize{
    CGSize size = [UIScreen mainScreen].bounds.size;
    return [NSString stringWithFormat:@"%.0lf * %.0lf",size.width,size.height];
}

+ (NSString *)systemVersion{
    return [UIDevice currentDevice].systemVersion ?: kTPAppInfoUnknown;
}

+ (NSString *)systemLanguage{
    return [NSLocale preferredLanguages].firstObject ?: kTPAppInfoUnknown;
}

@end
