//
//  KJStoreMoveView.h
//  Shopping
//
//  Created by apple on 2018/7/17.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^KJMoveHiddenBlock)(void);

@interface KJStoreMoveView : UIView

@property (nonatomic, assign) BOOL isListDisplay;
@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) KJMoveHiddenBlock hiddenBlock;

- (void)showInView:(UIView *)view;

@end
