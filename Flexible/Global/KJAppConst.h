//
//  KJAppConst.h
//  Shopping
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KJAppConst : NSObject

#define FontSize(font) [UIFont systemFontOfSize:font]

#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
#define Color(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define KStatusBarH [UIApplication sharedApplication].statusBarFrame.size.height

#define KNavigationBarH (KStatusBarH + 44.f)
#define KTabBarH 49.f
#define KToolBarH 44.f

#define scale = [UIScreen mainScreen].scale

#define sendNotification(key) [[NSNotificationCenter defaultCenter] postNotificationName:key object:self userInfo:nil];

UIKIT_EXTERN const CGFloat KprogressH;
UIKIT_EXTERN NSString *const kServiceErrorNotify;

@end
