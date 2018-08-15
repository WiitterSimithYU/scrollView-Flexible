//
//  ViewController.m
//  HealthStation
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 jiankangzhan. All rights reserved.
//

#import "KJTabBarViewController.h"
#import "KJNavigationController.h"
#import "KJStoreViewController.h"
#import "KJOneWebViewController.h"
#import "KJTwoWebViewController.h"

@interface KJTabBarViewController ()

@end

@implementation KJTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tabBar.tintColor = Color(0, 176, 160);
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // tabbar透明
    self.tabBar.translucent = NO;
    
    [self setUpChilidViewController];
}

- (void)setUpChilidViewController {
    [self loadChildrenController:[[KJStoreViewController alloc] init] imageName:@"icon_store" selectImageName:@"icon_store" title:@"FlexStore"];
    
    [self loadChildrenController:[[KJOneWebViewController alloc] init] imageName:@"icon_list" selectImageName:@"icon_list" title:@"WebView"];
    
    [self loadChildrenController:[[KJTwoWebViewController alloc] init] imageName:@"icon_shopping" selectImageName:@"icon_shopping" title:@"WKWebView"];

}

// 定义一个方法用于加载TABbar控制器中的自控制器
- (void)loadChildrenController:(UIViewController *)Vc imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName title:(NSString *)title {
    // 设置tabBarItem.image的普通状态下的图片
//    Vc.tabBarItem.image = [UIImage imageNamed:imageName];
    Vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置tabBarItem.image的选中状态下的图片
    
//    Vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName] ;
    Vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //     设置显示的标题,在当前控制器
    //    Vc.tabBarItem.title = title;
    //    // 栈顶控制器的属性
    //    Vc.navigationItem.title = title;
    
    // 这里设置、返回按钮才能显示
    Vc.title = title;
    
    //设置显示的标题的颜色

    [Vc.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [Vc.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName:Color(0, 176, 160)} forState:UIControlStateSelected];
    
    // 设置image显示大小
    Vc.tabBarItem.imageInsets = UIEdgeInsetsMake(-1.5, 0, 1.5, 0);
    [Vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2.5)];
    
    // 创建一个KJNavigationController
    KJNavigationController *navVc = [[KJNavigationController alloc] initWithRootViewController:Vc];
    
    // UINavigationController 添加到 UITabBarController中
    [self addChildViewController:navVc];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
