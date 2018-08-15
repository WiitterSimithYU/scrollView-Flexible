//
//  KJBaseViewController.h
//  HealthStation
//
//  Created by apple on 2017/2/21.
//  Copyright © 2017年 jiankangzhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJDisconnectView.h"
#import "KJServerErrorView.h"

typedef void (^KJPullToRefreshBlock)(void); // 下拉刷新
typedef void (^KJRetryConnectBlock)(void); // 尝试刷新

@interface KJBaseViewController : UIViewController

@property (nonatomic, strong) YSRefreshHeader *refreshHeader; // 下拉刷新
@property (nonatomic, copy) KJPullToRefreshBlock pullToRefreshBlock;

- (void)popViewController; // pop
- (void)pushViewController:(UIViewController *)vc; // push

@property (nonatomic, strong) KJServerErrorView *serverErrorView; // 服务器异常
@property (nonatomic, strong) KJDisconnectView *disconnectView; // 断网
@property (nonatomic, copy) KJRetryConnectBlock retryBlock; // 尝试连接
@property (nonatomic, assign) BOOL isConnect; // 网络连接

- (void)dismissDisconnectView; // 移除断网
- (void)dismissServerErrorView; // 异常服务器错误view

@end
