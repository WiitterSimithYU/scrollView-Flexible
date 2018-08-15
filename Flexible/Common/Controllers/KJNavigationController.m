//
//  KJNavigationController.m
//  HealthStation
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 jiankangzhan. All rights reserved.
//

#import "KJNavigationController.h"

@interface KJNavigationController ()

@end

@implementation KJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置导航背景图片
//    [self.navigationBar setBackgroundImage:[UIImage resizedImage:@"icon_nav_image"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置背景颜色
//    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    // 设置title标题中的颜色
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
//    NSFontAttributeName:FontSize(12)
    
    // 设置返回按钮的颜色
    [self.navigationBar setTintColor:[UIColor blackColor]];
    
    // 设置导航栏不透明
    self.navigationBar.translucent = NO;

}

- (void)setNavigationBarColor:(NavTypeColor)color {
    
    if (color == NavTypeColorBlack) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        [self.navigationBar setTintColor:[UIColor blackColor]];
        
    } else if (color == NavTypeColorWhite) {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [self.navigationBar setTintColor:[UIColor whiteColor]];
    }
    
}

//- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
//    
//    // 如果有大于控制器
//    if (self.childViewControllers.count >= 1) {
//        
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果有大于控制器
    if (self.childViewControllers.count >= 1) {

        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
    // 修正push控制器tabbar上移问题
    if (@available(iOS 11.0, *)){
        // 修改tabBra的frame
        CGRect frame = self.tabBarController.tabBar.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        self.tabBarController.tabBar.frame = frame;
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
