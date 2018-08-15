//
//  KJOneWebViewController.m
//  Flexible
//
//  Created by apple on 2018/8/14.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import "KJOneWebViewController.h"

@interface KJOneWebViewController ()

@end

@implementation KJOneWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleName = @"UIWebView";
    
    self.hiddenBack = YES;
    self.allowRefresh = NO;
    self.displayJSTitle = NO;
    
    [self loadRequestWithUrl:@"https://www.baidu.com"];
    
    /********************************这里进行交互******************************/
    // OC注册 JS调用
    [self.bridge registerHandler:@"goToPay" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"JS传过来的参数: %@", data);
        responseCallback(@"这是JS调用OC成功后，OC回调的参数");
    }];
    
    // JS注册 OC调用
    id data = @{ @"userId": @"123456789" };
    [self.bridge callHandler:@"goToStore" data:data responseCallback:^(id response) {
        NSLog(@"这里是OC调用JS成功后，JS回调的参数:%@", response);

    }];
    /********************************这里进行交互******************************/
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
