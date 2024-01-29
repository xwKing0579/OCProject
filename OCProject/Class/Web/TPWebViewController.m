//
//  TPWebViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/5.
//

#import "TPWebViewController.h"
#import <WebKit/WebKit.h>

@interface TPWebViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation TPWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpSubViews];
}

//- (BOOL)hideNavigationBar{
//    return YES;
//}

- (void)setUpSubViews{
    [self.view addSubview:self.webView];
    if (self.url) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
        
        [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    }
}

#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]){
        if (object == self.webView){
            self.title = self.webView.title;
        }
    }
}

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - WKNavigationDelegate
/* 页面开始加载 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [TPToastManager showLoading];
}

/* 开始返回内容 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    [TPToastManager hideLoading];
}

/* 页面加载完成 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [TPToastManager hideLoading];
}

/* 页面加载失败 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [TPToastManager hideLoading];
}

/* 在发送请求之前，决定是否跳转 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
}

/* 在收到响应后，决定是否跳转 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

#pragma mark - WKNavigationDelegate
#pragma mark - WKUIDelegate
/// 处理alert弹窗事件
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    [self alert:@"温馨提示" message:message?:@"" buttonTitles:@[@"确认"] handler:^(int index, NSString *title) {
        completionHandler();
    }];
}

/// 处理Confirm弹窗事件
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    [self alert:@"温馨提示" message:message?:@"" buttonTitles:@[@"取消", @"确认"] handler:^(int index, NSString *title) {
        completionHandler(index != 0);
    }];
}

/// 处理TextInput弹窗事件
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:prompt preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(nil);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *text = [alert.textFields firstObject].text;
        NSLog(@"字符串：%@", text);
        completionHandler(text);
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 弹窗
- (void)alert:(NSString *)title message:(NSString *)message {
    [self alert:title message:message buttonTitles:@[@"确定"] handler:nil];
}

- (void)alert:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles handler:(void(^)(int, NSString *))handler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i < buttonTitles.count; i++) {
        [alert addAction:[UIAlertAction actionWithTitle:buttonTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (handler) {
                handler(i, action.title);
            }
        }]];
    }
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - lazy
- (WKWebView *)webView{
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.selectionGranularity = WKSelectionGranularityDynamic;
        configuration.allowsInlineMediaPlayback = YES;
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        configuration.preferences = preferences;
        
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}

@end
