//
//  KJWKWebViewViewController.m
//  HealthStation
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 jiankangzhan. All rights reserved.
//

#import "KJWKWebViewController.h"

@interface KJWKWebViewController () <WKNavigationDelegate, WKUIDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, assign) NSTimeInterval barAnimationDuration; // default 0.1
@property (nonatomic, assign) NSTimeInterval fadeAnimationDuration; // default 0.27
@property (nonatomic, assign) NSTimeInterval fadeOutDelay; // default 0.1

@end

@implementation KJWKWebViewController

- (UIView *)progressView {
    if (!_progressView) {
        
        _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, KNavigationBarH - KprogressH, 0, KprogressH)];
        _progressView.backgroundColor = Color(0, 176, 160);
    }
    return _progressView;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self stopLoadingWebView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"class = %@",[self class]);
    _barAnimationDuration = 0.27f;
    _fadeAnimationDuration = 0.27f;
    _fadeOutDelay = 0.1f;
    
    [self setupRootUI];
}

- (void)setupRootUI {
    // 导航
    typeof(self) weakSelf = self;
    _navView = [[KJWebNavView alloc] init];
    [_navView setLeftBlock:^{
        if ([weakSelf.webView canGoBack]) {
            [weakSelf.webView goBack];
            if (weakSelf.webView.backForwardList.backList.count <= 1) {
                weakSelf.navView.closeHidden = YES;
            } else {
                weakSelf.navView.closeHidden = NO;
            }
            
        } else {
            [weakSelf popViewController];
        }
    }];
    [_navView setCloseBlock:^{
        WKBackForwardListItem *backItem = weakSelf.webView.backForwardList.backList.firstObject;
        [weakSelf.webView goToBackForwardListItem:backItem];
    }];
    [self.view addSubview:_navView];
    
    // 添加webView
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, KNavigationBarH, self.view.width, self.view.height - KNavigationBarH)];
    _webView.scrollView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.allowsBackForwardNavigationGestures = NO; // 手势侧滑
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    _webView.scrollView.delegate = self;

    // 适配ios11
    if (@available(iOS 11.0, *)){
        [_webView.scrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:_webView];
    
    // OC与JS桥接对象
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge setWebViewDelegate:self];
    
    // 进度条
    [_navView addSubview:self.progressView];
    
    // 下拉刷新
    self.pullToRefreshBlock = ^{
        [weakSelf reloadWebView];
    };
    
    // 断网刷新
    self.retryBlock = ^{
        [weakSelf reloadWebView];
    };
}

/*****************************公共****************************/
- (void)setTitleName:(NSString *)titleName {
    
    _titleName = titleName;
    self.navView.title = titleName;
}

- (void)setHiddenBack:(BOOL)hiddenBack {
    _hiddenBack = hiddenBack;
    self.navView.leftHidden = hiddenBack;
}

- (void)setHiddenClose:(BOOL)hiddenClose {
    _hiddenClose = hiddenClose;
    self.navView.closeHidden = hiddenClose;
}

- (void)setDisplayJSTitle:(BOOL)displayJSTitle {
    _displayJSTitle = displayJSTitle;
    
    if (displayJSTitle) {
          [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)setAllowGesture:(BOOL)allowGesture {
    _webView.allowsBackForwardNavigationGestures = allowGesture;
}

- (void)setAllowRefresh:(BOOL)allowRefresh {
    _allowRefresh = allowRefresh;
    if (allowRefresh) _webView.scrollView.mj_header = self.refreshHeader;
}

// 加载链接
- (void)loadRequestWithUrl:(NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

// 刷新
- (void)reloadWebView {
    [_webView reload];
}

// 停止加载
- (void)stopLoadingWebView {
    if (_webView.isLoading) {
        [_webView stopLoading];
    }
}

// 清除缓存
- (void)clearWebCache {
    
    if([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        }];
        
    } else {
        
        NSString*libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) objectAtIndex:0];
        NSString*cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
}

/*****************************公共****************************/

/******************************WKNavigationDelegate********************************/

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

// 内容开始到达时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"开始返回内容");
}

// 页面加载完成调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSLog(@"加载完成");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_webView.scrollView.mj_header endRefreshing];
    
    NSLog(@"count = %zd",webView.backForwardList.backList.count);
    
    // 跳转webview大小
    if (webView.backForwardList.backList.count > 0 && webView.canGoBack) {
        self.tabBarController.tabBar.hidden = YES;
        _webView.frame = CGRectMake(0, KNavigationBarH, self.view.width, self.view.height - KNavigationBarH + KTabBarH);
    } else {
        
        if (self.webViewFinishBlock) self.webViewFinishBlock();
        
        self.tabBarController.tabBar.hidden = NO;
        _webView.frame = CGRectMake(0, KNavigationBarH, self.view.width, self.view.height - KNavigationBarH);
    }
    
    // 返回和关闭按钮
    self.navView.leftHidden = !webView.canGoBack;
    if (!webView.canGoBack) self.navView.closeHidden = YES;

    // 断网视图
    if (self.disconnectView) [self dismissDisconnectView];
}

// 页面加载失败调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
 
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_webView.scrollView.mj_header endRefreshing];
    [MBProgressHUD showMessageWithText:@"加载失败"];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    UIApplication *app = [UIApplication sharedApplication];
    // 打电话
    if ([scheme isEqualToString:@"tel"]) {
        if ([app canOpenURL:URL]) {
            [app openURL:URL];
            // 一定要加上这句,否则会打开新页面
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }

    decisionHandler(WKNavigationActionPolicyAllow);
}
/******************************WKNavigationDelegate********************************/

/**********************************WKUIDelegate************************************/
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];

    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];

    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];

    [self presentViewController:alertController animated:YES completion:nil];
}
/**********************************WKUIDelegate************************************/

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        [self setProgress:_webView.estimatedProgress animated:YES];
        
    } else if ([keyPath isEqualToString:@"title"]) {
        
        self.titleName = self.webView.title;
    }
}

- (void)setProgress:(float)progress animated:(BOOL)animated {
    BOOL isGrowing = progress > 0.0;
    [UIView animateWithDuration:(isGrowing && animated) ? _barAnimationDuration : 0.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.progressView.frame;
        frame.size.width = progress * self.view.size.width;
        self.progressView.frame = frame;
    } completion:nil];
    
    if (progress >= 1.0) {
        [UIView animateWithDuration:animated ? _fadeAnimationDuration : 0.0 delay:_fadeOutDelay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.progressView.alpha = 0.0;
        } completion:^(BOOL completed){
            CGRect frame = self.progressView.frame;
            frame.size.width = 0;
            self.progressView.frame = frame;
        }];
    }
    else {
        [UIView animateWithDuration:animated ? _fadeAnimationDuration : 0.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.progressView.alpha = 1.0;
        } completion:nil];
    }
}

- (void)dealloc {
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView removeObserver:self forKeyPath:@"title"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
