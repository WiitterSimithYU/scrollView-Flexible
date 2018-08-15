//
//  KJProgressHUD.h
//  HealthStation
//
//  Created by apple on 2018/8/3.
//  Copyright © 2018年 jiankangzhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJProgressHUD : UIView

+ (KJProgressHUD *)instance;
- (void)showHUD;
- (void)hideHUD;

//+ (instancetype)showHUDAddedTo:(UIView *)view;
//+ (BOOL)hideHUDForView:(UIView *)view;

@end
