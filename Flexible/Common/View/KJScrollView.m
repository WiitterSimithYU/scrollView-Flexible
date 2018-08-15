//
//  KJScrollView.m
//  HealthStation
//
//  Created by apple on 2017/3/13.
//  Copyright © 2017年 jiankangzhan. All rights reserved.
//

#import "KJScrollView.h"

@implementation KJScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    // 判断 otherGestureRecognizer 是不是系统 POP 手势
    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
        // 判断 POP 手势的状态是 begin 还是 fail，同时判断 scrollView 的 ContentOffset.x 是不是在最左边
        if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.contentOffset.x == 0) {
            return YES;
        }
    }
    return NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
