//
//  KJWebViewController.m
//  HealthStation
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 jiankangzhan. All rights reserved.
//

#import "KJWebViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"

@interface KJWebViewController () <UIWebViewDelegate, UIScrollViewDelegate, NJKWebViewProgressDelegate>

@property (nonatomic, strong) NJKWebViewProgressView *progressView;
@property (nonatomic, strong) NJKWebViewProgress *progressProxy;

@end

@implementation KJWebViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.progressView removeFromSuperview];
    [self stopLoadingWebView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupRootUI];
}

- (void)setupRootUI {
    
    // 导航
    typeof(self) weakSelf = self;
    _navView = [[KJWebNavView alloc] init];
    [_navView setLeftBlock:^{
        
        if ([weakSelf.webView canGoBack]) {
            [weakSelf.webView goBack];
        
            weakSelf.navView.closeHidden = NO;
        } else {
            [weakSelf popViewController];
        }
    }];
    [_navView setCloseBlock:^{
        // goback到首页
    }];
    [self.view addSubview:_navView];
    
    // webView
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, KNavigationBarH, ScreenWidth, ScreenHeight - KNavigationBarH)];
    _webView.scrollView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.delegate = self;
    _webView.scrollView.delegate = self;
    // 适配ios11
    if (@available(iOS 11.0, *)){
        [_webView.scrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self.view addSubview:_webView];
    
    // OC与JS桥接对象
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge setWebViewDelegate:self];
    
    // 进度条
    self.progressProxy = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progressProxy;
    self.progressProxy.webViewProxyDelegate = _bridge; // 代理冲突
    self.progressProxy.progressDelegate = self;
    
    // 设置进度条
    self.progressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, _navView.height - KprogressH, ScreenWidth, KprogressH)];
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

- (void)reloadWebView {
    [_webView reload];
}

- (void)stopLoadingWebView {
    if (_webView.isLoading) {
        [_webView stopLoading];
    }
}
/*****************************公共****************************/

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [_progressView setProgress:progress animated:YES];
    if (_displayJSTitle) self.titleName = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

// 开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"开始加载");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// 加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_webView.scrollView.mj_header endRefreshing];
}

// 加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"加载完成");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [webView stringByEvaluatingJavaScriptFromString:@"setWebViewFlag()"];
    [_webView.scrollView.mj_header endRefreshing];
    
    self.navView.leftHidden = !_webView.canGoBack;
    if (!webView.canGoBack) self.navView.closeHidden = YES;
    
    if (self.webViewFinishBlock) self.webViewFinishBlock();
    
    if (self.disconnectView) {
        [self dismissDisconnectView];
    }
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
