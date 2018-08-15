//
//  YSRefreshGifHeader.h
//  MyChat
//
//  Created by apple on 2017/6/27.
//  Copyright © 2017年 jiankangzhan. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface YSRefreshGifHeader : MJRefreshGifHeader

@property (weak, nonatomic, readonly) UIImageView *gifView;

@property (weak, nonatomic) UIImageView *logo;

/** 设置state状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state;
- (void)setImages:(NSArray *)images forState:(MJRefreshState)state;

@end
