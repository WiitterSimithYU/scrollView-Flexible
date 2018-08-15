//
//  KJWebNavView.h
//  HealthStation
//
//  Created by apple on 2018/8/13.
//  Copyright © 2018年 jiankangzhan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>

typedef void (^LeftBtnClickBolck)(void);
typedef void (^CloseBtnClickBolck)(void);

@interface KJWebNavView : UIView

@property (nonatomic, copy) NSString *title; // 标题
@property (nonatomic, strong) UIColor *titleColor; // 返回按钮和标题文字颜色
@property (nonatomic, strong) UIColor *bgColor; // 背景颜色
@property (nonatomic, copy) NSString *leftBtnImage; // 左按钮图片
@property (nonatomic, assign, getter=isLeftHidden) BOOL leftHidden; // 默认显示
@property (nonatomic, assign, getter=isLineHidden) BOOL lineHidden; // 默认显示
@property (nonatomic, assign, getter=isCloseHidden) BOOL closeHidden; // 默认不显示

@property (nonatomic, copy) LeftBtnClickBolck leftBlock; // 左按钮触发事件
@property (nonatomic, copy) CloseBtnClickBolck closeBlock; // 关闭按钮触发事件

@end
