//
//  UIFont+Category.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import "UIFont+Category.h"

@implementation UIFont (Category)

+ (UIFont *)font10{return [self fontSize:10];}
+ (UIFont *)font11{return [self fontSize:11];}
+ (UIFont *)font12{return [self fontSize:12];}
+ (UIFont *)font13{return [self fontSize:13];}
+ (UIFont *)font14{return [self fontSize:14];}
+ (UIFont *)font15{return [self fontSize:15];}
+ (UIFont *)font16{return [self fontSize:16];}
+ (UIFont *)font17{return [self fontSize:17];}
+ (UIFont *)font18{return [self fontSize:18];}
+ (UIFont *)font19{return [self fontSize:19];}
+ (UIFont *)font20{return [self fontSize:20];}

+ (UIFont *)fontBold10{return [self fontBoldSize:10];}
+ (UIFont *)fontBold11{return [self fontBoldSize:11];}
+ (UIFont *)fontBold12{return [self fontBoldSize:12];}
+ (UIFont *)fontBold13{return [self fontBoldSize:13];}
+ (UIFont *)fontBold14{return [self fontBoldSize:14];}
+ (UIFont *)fontBold15{return [self fontBoldSize:15];}
+ (UIFont *)fontBold16{return [self fontBoldSize:16];}
+ (UIFont *)fontBold17{return [self fontBoldSize:17];}
+ (UIFont *)fontBold18{return [self fontBoldSize:18];}
+ (UIFont *)fontBold19{return [self fontBoldSize:19];}
+ (UIFont *)fontBold20{return [self fontBoldSize:20];}

+ (UIFont *)fontSize:(CGFloat)size{
    return [UIFont fontWithName:@"PingFangSC-Regular" size:size];
}

+ (UIFont *)fontBoldSize:(CGFloat)size{
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
}

@end
