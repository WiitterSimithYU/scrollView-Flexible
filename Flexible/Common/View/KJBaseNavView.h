//
//  KJNavView.h
//  HealthStation
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 jiankangzhan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LeftBtnClickBolck)(void);

@interface KJBaseNavView : UIView

@property (nonatomic, copy) NSString *title; // 标题
@property (nonatomic, strong) UIColor *titleColor; // 返回按钮和标题文字颜色
@property (nonatomic, strong) UIColor *bgColor; // 背景颜色
@property (nonatomic, copy) NSString *leftBtnImage; // 左按钮图片
@property (nonatomic, assign, getter=isLeftHidden) BOOL leftHidden;
@property (nonatomic, assign, getter=isLineHidden) BOOL lineHidden;

@property (nonatomic, copy) LeftBtnClickBolck leftBlock; // 左按钮触发事件

@end
