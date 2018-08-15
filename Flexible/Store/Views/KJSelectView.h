//
//  KJSelectView.h
//  Shopping
//
//  Created by apple on 2018/7/26.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectViewBlock)(NSInteger index);

@interface KJSelectView : UIView

@property (nonatomic, copy) SelectViewBlock selectBlock;

@end
