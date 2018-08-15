//
//  KJStoreNavView.h
//  Shopping
//
//  Created by apple on 2018/7/25.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KJStoreNavView;

typedef void (^LeftBtnClickBolck)(void);
typedef void (^RightBtnClickBolck)(void);
typedef void (^TitleBtnClickBlock)(KJStoreNavView *navView, NSInteger index);

@interface KJStoreNavView : UIView

@property (nonatomic, strong) UIColor *bgColor; // 背景颜色
@property (nonatomic, strong) UIColor *titleColor; // 返回按钮和标题文字颜色
@property (nonatomic, copy) NSString *leftBtnImage; // 左按钮图片
@property (nonatomic, copy) NSString *rightBtnImage; // 右按钮图片

@property (nonatomic, copy) LeftBtnClickBolck leftBlock; // 左按钮触发事件
@property (nonatomic, copy) RightBtnClickBolck rightBlock; // 右按钮触发事件
@property (nonatomic, copy) TitleBtnClickBlock titleBlock; // title触发事件

// 触发segmentView事件
- (void)contenntViewScroll:(CGFloat)pacentage index:(NSInteger)index direction:(NSInteger)direction;
- (void)contenntViewScrollToIndex:(NSInteger)index;
- (void)contenntSelectButtonIndex:(NSInteger)index;

@end
