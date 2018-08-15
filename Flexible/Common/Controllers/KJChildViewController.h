//
//  KJChildViewController.h
//  HealthStation
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 jiankangzhan. All rights reserved.
//

#import "KJBaseViewController.h"

@interface KJChildViewController : KJBaseViewController

@property (nonatomic, strong) KJBaseNavView *navView; // 导航
@property (nonatomic, copy) NSString *titleName; // 标题
@property (nonatomic, assign) BOOL hiddenBack; // 隐藏返回

@end
