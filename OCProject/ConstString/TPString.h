//
//  TPString.h
//  OCProject
//
//  Created by 王祥伟 on 2024/3/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPString : NSObject

//tableViewCell ===========================================================================
+ (NSString *)tc_log;
+ (NSString *)tc_font;
+ (NSString *)tc_home;
+ (NSString *)tc_mine;
+ (NSString *)tc_leaks;
+ (NSString *)tc_crash;
+ (NSString *)tc_monitor;
+ (NSString *)tc_po_object;
+ (NSString *)tc_app_kind;
+ (NSString *)tc_app_info;
+ (NSString *)tc_file;
+ (NSString *)tc_file_data;
+ (NSString *)tc_debug_switch;
+ (NSString *)tc_ui_hierarchy;
+ (NSString *)tc_user_defaults;
+ (NSString *)tc_router_params;
+ (NSString *)tc_analysis_click;
+ (NSString *)tc_network_monitor;
+ (NSString *)tc_confound;
+ (NSString *)tc_spam_code_model;
+ (NSString *)tc_confound_label;

//viewController ===========================================================================
///基类
+ (NSString *)vc_base;
+ (NSString *)vc_base_table;
+ (NSString *)vc_base_tabbar;
+ (NSString *)vc_base_navigation;

///demo演示页面
+ (NSString *)vc_tabbar;
+ (NSString *)vc_home;
+ (NSString *)vc_ui;
+ (NSString *)vc_mine;
+ (NSString *)vc_web;

+ (NSString *)vc_router_demo;
+ (NSString *)vc_router_params;
+ (NSString *)vc_meditor_demo;
+ (NSString *)vc_analysis_demo;
+ (NSString *)vc_analysis_click;
+ (NSString *)vc_forbid_shot_demo;
+ (NSString *)vc_i_carousel;
+ (NSString *)vc_empty_data;
+ (NSString *)vc_crypto;
+ (NSString *)vc_toast;
+ (NSString *)vc_pop_views;

///debug工具页面
+ (NSString *)vc_log;
+ (NSString *)vc_font;
+ (NSString *)vc_file;
+ (NSString *)vc_file_data;
+ (NSString *)vc_log_detail;
+ (NSString *)vc_leaks;
+ (NSString *)vc_crash;
+ (NSString *)vc_monitor;
+ (NSString *)vc_app_kind;
+ (NSString *)vc_app_info;
+ (NSString *)vc_app_detail;
+ (NSString *)vc_po_object;
+ (NSString *)vc_shot_object;
+ (NSString *)vc_debug_tool;
+ (NSString *)vc_debug_switch;
+ (NSString *)vc_ui_hierarchy;
+ (NSString *)vc_user_defaults;
+ (NSString *)vc_network_monitor;
+ (NSString *)vc_confound;
+ (NSString *)vc_spam_code;
+ (NSString *)vc_spam_code_model;
+ (NSString *)vc_spam_code_method;
+ (NSString *)vc_spam_code_word;

///其他类 ===========================================================================
+ (NSString *)tp_debug_tool;

///提供给外部路由配置页面集合 ===========================================================================
+ (NSSet *)routerSet;

//公用头 ===========================================================================
+ (NSString *)prefix_app;
+ (NSString *)prefix_viewController;
@end

@interface NSString (SelectorName)

- (Class)toClass;

///vc别名
- (NSString *)abbr;

///首字母大写
- (NSString *)prefixCapital;
@end
NS_ASSUME_NONNULL_END
