//
//  KJStoreScrollView.m
//  Shopping
//
//  Created by apple on 2018/7/26.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import "KJStoreScrollView.h"

@interface KJStoreScrollView ()

@property (nonatomic, assign) BOOL isUp;

@end

@implementation KJStoreScrollView

//// 透过上层视图响应下层视图
//- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    NSLog(@"point = %@",NSStringFromCGPoint(point));
//    UIView *hitView = [super hitTest:point withEvent:event];
//    
//    if(hitView == self ) {
//        
//        return hitView;
//    }
//    return hitView;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
