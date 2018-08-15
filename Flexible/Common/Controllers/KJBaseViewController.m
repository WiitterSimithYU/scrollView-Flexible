//
//  KJBaseViewController.m
//  HealthStation
//
//  Created by apple on 2017/2/21.
//  Copyright © 2017年 jiankangzhan. All rights reserved.
//

#import "KJBaseViewController.h"

@interface KJBaseViewController () 

@end

@implementation KJBaseViewController

- (KJDisconnectView *)disconnectView {
    if (!_disconnectView) {
        _disconnectView = [[KJDisconnectView alloc] initWithFrame:CGRectMake(0, KNavigationBarH, self.view.width, self.view.height - KNavigationBarH)];
    }
    return _disconnectView;
}

- (KJServerErrorView *)serverErrorView {
    if (!_serverErrorView) {
        _serverErrorView = [[KJServerErrorView alloc] initWithFrame:CGRectMake(0, KNavigationBarH, self.view.width, self.view.height - KNavigationBarH)];
    }
    return _serverErrorView;
}

// 取消所有请求
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    if(![self isKindOfClass:[KJReportViewController class]]) {
//        [[KJRequestManger instance] cancelAllRequest];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置侧滑有效区域
    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 50;
    self.fd_prefersNavigationBarHidden = YES;
    
    // 适配导航栏ios7以后
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 下拉刷新
    typeof(self) weakSelf = self;
    _refreshHeader = [YSRefreshHeader headerWithRefreshingBlock:^{
        if (weakSelf.pullToRefreshBlock) weakSelf.pullToRefreshBlock();
    }];
    _refreshHeader.lastUpdatedTimeLabel.hidden = YES;// 隐藏时间
    _refreshHeader.stateLabel.textColor = Color(153, 153, 153);
    
    // 打开网络监听
    [self openNetworkMonitoring];
    
    // 打开服务监听
    [self openServerMonitoring];
   
}

#pragma mark - pop
- (void)popViewController {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - push
- (void)pushViewController:(UIViewController *)vc {
    [self.navigationController pushViewController:vc animated:YES];
}

/*****************************服务器异常处理*****************************/

- (void)openServerMonitoring {
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(serverErrorNotify) name:kServiceErrorNotify object:nil];
}

- (void)removeServerMonitoring {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kServiceErrorNotify object:nil];
}

// 服务器错误
- (void)serverErrorNotify {
    [self.view addSubview:self.serverErrorView];
    [self.view bringSubviewToFront:self.serverErrorView];
    
    typeof(self) weakSelf = self;
    self.serverErrorView.serverErrorBlock = ^{
        if (weakSelf.retryBlock) {
            weakSelf.retryBlock();
        }
    };
}

// 移除服务器出错view
- (void)dismissServerErrorView {
    
    if (self.serverErrorView != nil) {
        [self.serverErrorView removeFromSuperview];
        self.serverErrorView = nil;
    }
}

/*****************************服务器异常处理*****************************/

/*****************************网络监听处理*****************************/
#pragma mark - 监听网络变化
- (void)openNetworkMonitoring {

    AFNetworkReachabilityManager *netManager = [AFNetworkReachabilityManager sharedManager];
    [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: [self networkDisconnect];  break;
            case AFNetworkReachabilityStatusNotReachable: [self networkDisconnect]; break;

            case AFNetworkReachabilityStatusReachableViaWWAN: [self networkConnect]; break;
            case AFNetworkReachabilityStatusReachableViaWiFi: [self networkConnect];  break;
            default: break;
        }
    }];
    [netManager startMonitoring];
}

// 处理没网情况
- (void)networkDisconnect {
    NSLog(@"%@",[self class]);
    
    self.isConnect = NO;

    [self.view addSubview:self.disconnectView];
    [self.view bringSubviewToFront:self.disconnectView];

    typeof(self) weakSelf = self;
    self.disconnectView.retryConnectBlock = ^{
        if (weakSelf.retryBlock) {
            weakSelf.retryBlock();
        }
    };
}

// 有网络
- (void)networkConnect {
    self.isConnect = YES;
}

// 移除断网view
- (void)dismissDisconnectView {

    if (self.disconnectView != nil) {
        [self.disconnectView removeFromSuperview];
        self.disconnectView = nil;
    }
}

/*****************************网络监听处理*****************************/

- (void)dealloc {
    [self removeServerMonitoring];
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
#pragma mark - 设置系统返回按钮

