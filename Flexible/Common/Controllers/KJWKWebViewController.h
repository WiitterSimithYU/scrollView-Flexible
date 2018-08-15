//
//  KJWKWebViewViewController.h
//  HealthStation
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 jiankangzhan. All rights reserved.
//

#import "KJBaseViewController.h"
#import "WebViewJavascriptBridge.h"
#import <WebKit/WebKit.h>

typedef void (^KJWebviewFinishLoadBlock)(void);

@interface KJWKWebViewController : KJBaseViewController 

@property (nonatomic, strong) KJWebNavView *navView; // 导航
@property (nonatomic, copy) NSString *titleName; // 导航标题
@property (nonatomic, assign) BOOL hiddenBack; // 隐藏返回
@property (nonatomic, assign) BOOL hiddenClose; // 隐藏关闭

@property (nonatomic, strong) WKWebView *webView; // wkWebView
@property (nonatomic, strong) WebViewJavascriptBridge* bridge; // 桥接对象
@property (nonatomic, assign) BOOL allowRefresh; // 允许刷新
@property (nonatomic, assign) BOOL allowGesture; // 允许手势
@property (nonatomic, assign) BOOL displayJSTitle; // 显示JS标题

@property (nonatomic, copy) KJWebviewFinishLoadBlock webViewFinishBlock;

- (void)loadRequestWithUrl:(NSString *)urlStr; // 加载链接
- (void)reloadWebView; // 刷新网页
- (void)stopLoadingWebView; // 停止刷新
- (void)clearWebCache; // 清除缓存

@end
