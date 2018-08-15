//
//  KJLoopView.h
//  HealthStation
//
//  Created by apple on 2018/1/10.
//  Copyright © 2018年 jiankangzhan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KJLoopView;

@protocol KJLoopViewDelegate <NSObject>

- (void)loopView:(KJLoopView *)loopView clieckIndex:(NSInteger)index;

@end

@interface KJLoopView : UIView

@property (nonatomic, strong) NSArray *imageItems;

@property (nonatomic, weak) id <KJLoopViewDelegate> delegate;

- (void)addLoopTimer;
- (void)invalidateTimer;

@end
