//
//  KJServerErrorView.h
//  HealthStation
//
//  Created by apple on 2018/8/7.
//  Copyright © 2018年 jiankangzhan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^KJServerErrorBlock)(void);

@interface KJServerErrorView : UIView

@property (nonatomic, copy) KJServerErrorBlock serverErrorBlock;

@end
