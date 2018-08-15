//
//  KJProductView.h
//  Shopping
//
//  Created by apple on 2018/7/26.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LocationViewBlock)(void);

@interface KJProductView : UIView

@property (nonatomic, assign) CGFloat currentH;
@property (nonatomic, copy) LocationViewBlock locationBlock;

@end
