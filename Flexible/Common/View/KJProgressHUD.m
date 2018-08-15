//
//  KJProgressHUD.m
//  HealthStation
//
//  Created by apple on 2018/8/3.
//  Copyright © 2018年 jiankangzhan. All rights reserved.
//

#import "KJProgressHUD.h"

@interface KJProgressHUD ()

//@property (nonatomic, strong) JQIndicatorView *indicatorView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation KJProgressHUD

static KJProgressHUD * gThis = nil;

+ (KJProgressHUD *)instance {
    if ( gThis == nil ){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            gThis = [[KJProgressHUD alloc] init];
        });
    }
    return gThis;
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [self initView];
    }
    return self;
}

- (void)initView {
//    _indicatorView = [[JQIndicatorView alloc] initWithType:JQIndicatorTypeCyclingLine tintColor:Color(0, 176, 160) size:CGSizeMake(30, 30)];
//    [self addSubview:_indicatorView];
    
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    _indicatorView.color = ThemeColor;
    [self addSubview:_indicatorView];
}

- (void)showHUD {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [_indicatorView startAnimating];
}

- (void)hideHUD {
    if (_indicatorView) [_indicatorView stopAnimating];
    if (self) [self removeFromSuperview];
}

//+ (instancetype)showHUDAddedTo:(UIView *)view {
//    KJProgressHUD *hud = [[self alloc] init];
//    [hud.indicatorView startAnimating];
//    [view addSubview:hud];
//    return hud;
//}
//
//+ (BOOL)hideHUDForView:(UIView *)view {
//    KJProgressHUD *hud = [self HUDForView:view];
//    if (hud != nil) {
//        [hud.indicatorView stopAnimating];
//        [hud removeFromSuperview];
//        return YES;
//    }
//    return NO;
//}
//
//+ (KJProgressHUD *)HUDForView:(UIView *)view {
//    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
//    for (UIView *subview in subviewsEnum) {
//        if ([subview isKindOfClass:self]) {
//            return (KJProgressHUD *)subview;
//        }
//    }
//    return nil;
//}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _indicatorView.centerX = self.width * 0.5;
    _indicatorView.centerY = (self.height - KNavigationBarH) * 0.5 + KNavigationBarH;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
