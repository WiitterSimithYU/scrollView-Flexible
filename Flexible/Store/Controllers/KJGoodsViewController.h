//
//  KJGoodsViewController.h
//  Shopping
//
//  Created by apple on 2018/7/25.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ScrollCommentBlock)(void);
typedef void (^RecommendBlock)(NSInteger index);

@interface KJGoodsViewController : UIViewController

@property (nonatomic, copy) ScrollCommentBlock commentBlock;
@property (nonatomic, copy) RecommendBlock recommendBlock;

@end
