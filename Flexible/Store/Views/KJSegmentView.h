//
//  KJSegmentView.h
//  HealthStation
//
//  Created by apple on 2018/1/10.
//  Copyright © 2018年 jiankangzhan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KJSegmentView;

@protocol KJSegmentViewDelegate <NSObject>

- (void)segmentView:(KJSegmentView *)segmentView index:(NSInteger)index;

@end

@interface KJSegmentView : UIView

@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, weak) id <KJSegmentViewDelegate> delegate;

- (void)selectViewScroll:(CGFloat)pacentage index:(NSInteger)index direction:(NSInteger)direction;

- (void)scrollToIndex:(NSInteger)index;

- (void)selectButtonIndex:(NSInteger)index;

@end
