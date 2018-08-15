//
//  KJStoreBottomView.h
//  Shopping
//
//  Created by apple on 2018/7/25.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KJStoreBottomView;

typedef void (^BottomBtnClickBlock)(KJStoreBottomView *bottomView, NSInteger index);

@interface KJStoreBottomView : UIView

@property (nonatomic, copy) BottomBtnClickBlock bottomBlock;

@end
