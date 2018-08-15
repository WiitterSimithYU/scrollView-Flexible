//
//  KJNavigationController.h
//  HealthStation
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 jiankangzhan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NavTypeColorBlack = 0,
    NavTypeColorWhite = 1,
} NavTypeColor;

@interface KJNavigationController : UINavigationController

- (void)setNavigationBarColor:(NavTypeColor)color;

@end
