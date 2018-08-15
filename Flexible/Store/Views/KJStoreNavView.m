//
//  KJStoreNavView.m
//  Shopping
//
//  Created by apple on 2018/7/25.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import "KJStoreNavView.h"
#import "KJSegmentView.h"

@interface KJStoreNavView () <KJSegmentViewDelegate>

@property (nonatomic, weak) UIView *titleView;
@property (nonatomic, weak) KJSegmentView *segmentView;
@property (nonatomic, weak) UIButton *leftBtn;
@property (nonatomic, weak) UIButton *rightBtn;
@property (nonatomic, weak) UIImageView *lineView;

@end

@implementation KJStoreNavView

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
    
    KJSegmentView *segmentView = [[KJSegmentView alloc] init];
    segmentView.delegate = self;
    segmentView.titleArray = [NSMutableArray arrayWithObjects:@"商品", @"详情", @"评论", nil];
    [self addSubview:segmentView];
    self.segmentView = segmentView;
    
    UIButton *leftBtn = [[UIButton alloc] init];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBtn setTitleColor:Color(0x66, 0x66, 0x66) forState:UIControlStateNormal];
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    self.leftBtn = leftBtn;

    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"icon_message"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    self.rightBtn = rightBtn;
    
    UIImageView *lineView = [[UIImageView alloc] init];
    lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self addSubview:lineView];
    self.lineView = lineView;
}

- (void)leftBtnClick:(UIButton *)btn {
    
    if (self.leftBlock) {
        self.leftBlock();
    }
}

- (void)rightBtnClick:(UIButton *)btn {
    if (self.rightBlock) {
        self.rightBlock();
    }
}

- (void)segmentView:(KJSegmentView *)segmentView index:(NSInteger)index {
    
    if (self.titleBlock) {
        self.titleBlock(self, index);
    }
}

// 触发segmentView事件
- (void)contenntViewScroll:(CGFloat)pacentage index:(NSInteger)index direction:(NSInteger)direction {
    [self.segmentView selectViewScroll:pacentage index:index direction:direction];
}

- (void)contenntViewScrollToIndex:(NSInteger)index {
    [self.segmentView scrollToIndex:index];
}

- (void)contenntSelectButtonIndex:(NSInteger)index {
    [self.segmentView selectButtonIndex:index];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.segmentView.size = CGSizeMake(ScreenWidth - 60 * 2, KNavigationBarH - KStatusBarH);
    self.segmentView.centerX = self.width * 0.5;
    self.segmentView.centerY = KStatusBarH + (KNavigationBarH - KStatusBarH) * 0.5;
    
    // 改变button内部的lable和image位置
    //    CGFloat imageWidth = self.leftBtn.imageView.width;
    //    CGFloat labelWidth = self.leftBtn.titleLabel.width;
    //    self.leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth , 0, -labelWidth);
    //    self.leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);

    [self.leftBtn sizeToFit];
    self.leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        self.leftBtn.centerY = self.segmentView.centerY;
    self.leftBtn.x = 0;
    
    
    [self.rightBtn sizeToFit];
    self.rightBtn.centerY = self.segmentView.centerY;
    self.rightBtn.x = self.width - self.rightBtn.width - 5;
    
    self.lineView.frame = CGRectMake(0, self.height, ScreenWidth, 0.5);
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
