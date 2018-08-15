//
//  KJRecommendView.h
//  Shopping
//
//  Created by apple on 2018/7/26.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RecommendClickBlock)(NSInteger index);

@interface KJRecommendView : UIView

@property (nonatomic, copy) RecommendClickBlock recommendBlock;

@end
