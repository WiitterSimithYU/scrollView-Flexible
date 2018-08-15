//
//  KJHomeNavBar.m
//  HealthStation
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 jiankangzhan. All rights reserved.
//

#import "KJHomeNavView.h"

@interface KJHomeNavView ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *lineView;
@property (nonatomic, weak) UIButton *scanBtn;
@property (nonatomic, weak) UIButton *signBtn;

@end

@implementation KJHomeNavView

- (instancetype)init {
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, ScreenWidth, KNavigationBarH);
        self.backgroundColor = [UIColor whiteColor];
        
        [self initView];
    }
    return self;
}

- (void)initView {
    
    // 导航标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
    titleLabel.textColor = Color(0x33, 0x33, 0x33);
    titleLabel.text = @"健康报告";
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton *scanBtn = [[UIButton alloc] init];
    scanBtn.tag = 0;
    scanBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [scanBtn setTitleColor:Color(0x33, 0x33, 0x33) forState:UIControlStateNormal];
    [scanBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    scanBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    scanBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [scanBtn setImage:[UIImage imageNamed:@"icon_report_scan"] forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(navViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:scanBtn];
    self.scanBtn = scanBtn;
    
    UIButton *signBtn = [[UIButton alloc] init];
    signBtn.tag = 1;
    signBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [signBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [signBtn setTitle:@"签到" forState:UIControlStateNormal];
    signBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    signBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [signBtn setImage:[UIImage imageNamed:@"icon_report_coin"] forState:UIControlStateNormal];
    [signBtn addTarget:self action:@selector(navViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:signBtn];
    self.signBtn = signBtn;
    
    UIImageView *lineView = [[UIImageView alloc] init];
    lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self addSubview:lineView];
    self.lineView = lineView;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    
    [self setNeedsLayout];
}

- (void)navViewBtnClick:(UIButton *)btn {
    if (self.homeNavBlock) {
        self.homeNavBlock(btn.tag);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    self.titleLabel.centerY = KStatusBarH + (KNavigationBarH - KStatusBarH) * 0.5;
    self.titleLabel.centerX = self.width * 0.5;
    
    [self.scanBtn sizeToFit];
    //获取imageView中的宽度和高度
    CGFloat imageW = self.scanBtn.imageView.width;
    CGFloat imageH = self.scanBtn.imageView.height;
    //获取titleLabel的宽度
    CGFloat labelW = self.scanBtn.titleLabel.width;
    CGFloat labelH = self.scanBtn.titleLabel.height;
    //计算移动距离
    CGFloat imageDistance = (self.scanBtn.width - imageW) * 0.5;
    //设置上内距
    CGFloat imageTop = (self.scanBtn.height - imageH - labelH) * 0.5;
    //进行移动
    self.scanBtn.imageEdgeInsets = UIEdgeInsetsMake(imageTop, imageDistance, 0, 0);
    
    //计算移动距离
    CGFloat labelDistance = - imageW + (self.scanBtn.width - labelW) *0.5;
    //上内距
    CGFloat labelTop = imageTop + imageH;
    self.scanBtn.titleEdgeInsets = UIEdgeInsetsMake(labelTop + 2.f, labelDistance, 0, 0);
    
    self.scanBtn.centerY = self.titleLabel.centerY;
    self.scanBtn.x = 0;
    
    [self.signBtn sizeToFit];
    {
        //获取imageView中的宽度和高度
        CGFloat imageW = self.signBtn.imageView.width;
        CGFloat imageH = self.signBtn.imageView.height;
        //获取titleLabel的宽度
        CGFloat labelW = self.signBtn.titleLabel.width;
        CGFloat labelH = self.signBtn.titleLabel.height;
        //计算移动距离
        CGFloat imageDistance = (self.signBtn.width - imageW) * 0.5;
        //设置上内距
        CGFloat imageTop = (self.signBtn.height - imageH - labelH) * 0.5;
        //进行移动
        self.signBtn.imageEdgeInsets = UIEdgeInsetsMake(imageTop, imageDistance, 0, 0);
        
        //计算移动距离
        CGFloat labelDistance = - imageW + (self.signBtn.width - labelW) *0.5;
        //上内距
        CGFloat labelTop = imageTop + imageH;
        self.signBtn.titleEdgeInsets = UIEdgeInsetsMake(labelTop + 2.f, labelDistance, 0, 0);
        
        self.signBtn.centerY = self.titleLabel.centerY;
        CGFloat offset = (self.scanBtn.width - self.signBtn.width) * 0.5;
        self.signBtn.x = self.width - self.signBtn.width - offset;
    }
    
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
