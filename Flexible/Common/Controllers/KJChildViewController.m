//
//  KJChildViewController.m
//  HealthStation
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 jiankangzhan. All rights reserved.
//

#import "KJChildViewController.h"

@interface KJChildViewController ()

@end

@implementation KJChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    typeof(self) weakSelf = self;
    _navView = [[KJBaseNavView alloc] init];
    [_navView setLeftBlock:^{
        
        [weakSelf popViewController];
    }];
    [self.view addSubview:_navView];

}

/*****************************公共****************************/
// 设置标题
- (void)setTitleName:(NSString *)titleName {
    _titleName = titleName;
    
    _navView.title = titleName;
}

- (void)setHiddenBack:(BOOL)hiddenBack {
    _hiddenBack = hiddenBack;
    self.navView.leftHidden = hiddenBack;
}
/*****************************公共****************************/

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
