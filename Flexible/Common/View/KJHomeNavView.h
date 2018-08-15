//
//  KJHomeNavBar.h
//  HealthStation
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 jiankangzhan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HomeNavViewBlock)(NSInteger index);

@interface KJHomeNavView : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) HomeNavViewBlock homeNavBlock;

@end
