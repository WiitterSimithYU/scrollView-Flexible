//
//  KJNavView.m
//  HealthStation
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 jiankangzhan. All rights reserved.
//

#import "KJBaseNavView.h"

@interface KJBaseNavView ()

@property (nonatomic, weak) UIButton *leftBtn;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *lineView;

@end

@implementation KJBaseNavView

- (instancetype)init {
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, ScreenWidth, KNavigationBarH);
        self.backgroundColor = [UIColor whiteColor];
        
        [self initView];
    }
    return self;
}

- (void)initSetting {
    
}

- (void)initView {
    
    // 导航标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"标题";
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton *leftBtn = [[UIButton alloc] init];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [leftBtn setTitleColor:Color(0x66, 0x66, 0x66) forState:UIControlStateNormal];
//    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"icon_back_black"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    self.leftBtn = leftBtn;
    

    UIImageView *lineView = [[UIImageView alloc] init];
    lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self addSubview:lineView];
    self.lineView = lineView;
}

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = title;
    [self setNeedsLayout];
}

- (void)setLeftHidden:(BOOL)leftHidden {
    
    _leftHidden = leftHidden;
    self.leftBtn.hidden = leftHidden;
}

- (void)setLineHidden:(BOOL)lineHidden {
    _lineHidden = lineHidden;
    self.lineView.hidden = lineHidden;
}

- (void)leftBtnClick:(UIButton *)btn {
    
    if (self.leftBlock) {
        self.leftBlock();
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    self.titleLabel.centerX = self.width * 0.5;
    self.titleLabel.centerY = KStatusBarH + (KNavigationBarH - KStatusBarH) * 0.5;
    
    [self.leftBtn sizeToFit];
    self.leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.leftBtn.centerY = self.titleLabel.centerY;
    self.leftBtn.x = 0;
    
    
    self.lineView.frame = CGRectMake(0, self.height - 0.5, ScreenWidth, 0.5);
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
