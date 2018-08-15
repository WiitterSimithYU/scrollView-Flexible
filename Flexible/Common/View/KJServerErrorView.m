//
//  KJServerErrorView.m
//  HealthStation
//
//  Created by apple on 2018/8/7.
//  Copyright © 2018年 jiankangzhan. All rights reserved.
//

#import "KJServerErrorView.h"

@interface KJServerErrorView ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLb;

@property (nonatomic, strong) UILabel *detailLb;

@property (nonatomic, strong) UIButton *refreshBtn;

@end

@implementation KJServerErrorView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_network_disconnect"]];
        [self addSubview:self.imageView];
        
        self.titleLb = [self creatLableWithTitle:@"服务器异常" font:15 color:[UIColor darkGrayColor]];
        [self addSubview:self.titleLb];
        
        self.detailLb = [self creatLableWithTitle:@"哎呦，被挤爆了，请稍后重试。" font:15 color:[UIColor darkGrayColor]];
        [self addSubview:self.detailLb];
        
        self.refreshBtn = [self creatButtonWithTitle:@"点击重试" target:self action:@selector(refreshBtnClick:)];
        [self addSubview:self.refreshBtn];
    }
    return self;
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.centerX = self.width * 0.5;
    self.imageView.y = self.height * 0.5 - 1.5 * self.imageView.height;
    
    self.titleLb.centerX = self.imageView.centerX;
    self.titleLb.y = CGRectGetMaxY(self.imageView.frame) + 20;
    
    self.detailLb.centerX = self.imageView.centerX;
    self.detailLb.y = CGRectGetMaxY(self.titleLb.frame) + 10;
    
    self.refreshBtn.size = CGSizeMake(100, 35);
    self.refreshBtn.centerX = self.imageView.centerX;
    self.refreshBtn.y = CGRectGetMaxY(self.detailLb.frame) + 20;
}

- (void)refreshBtnClick:(UIButton *)button {
    
    if (self.serverErrorBlock) {
        self.serverErrorBlock();
    }
}


- (UILabel *)creatLableWithTitle:(NSString *)title font:(CGFloat)font color:(UIColor *)color{
    UILabel *lable = [[UILabel alloc] init];
    lable.text = title;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = FontSize(font);
    lable.textColor = color;
    [lable sizeToFit];
    return lable;
}

// 0 有边框  1有背景
- (UIButton *)creatButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    
    UIButton *button = [[UIButton alloc] init];
    
    button.layer.borderColor = Color(0, 176, 160).CGColor;
    button.layer.borderWidth = 1.f;
    button.backgroundColor = [UIColor clearColor];
    
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:Color(0, 176, 160) forState:UIControlStateNormal];
    button.titleLabel.font = FontSize(15);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
