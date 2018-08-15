//
//  KJSegmentView.m
//  HealthStation
//
//  Created by apple on 2018/1/10.
//  Copyright © 2018年 jiankangzhan. All rights reserved.
//

#import "KJSegmentView.h"

#define KMargin 20
#define KSelectFont 16
#define KNormalFont 16
#define KSelectColor Color(0, 176, 160)
#define KNormalColor [UIColor blackColor]

@interface KJSegmentView ()

@property (nonatomic, strong) UIView *selectView;

@property (nonatomic, assign) CGFloat currentX;

@property (nonatomic, weak) UIButton *lastButton;

@property (nonatomic, weak) UIButton *currentButton;

@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation KJSegmentView

- (UIView *)selectView {
    if (!_selectView) {
        
        _selectView = [[UIView alloc] init];
        _selectView.backgroundColor = KSelectColor;
    }
    return _selectView;
}

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.selectView];
    }
    return self;
}

- (void)setTitleArray:(NSMutableArray *)titleArray {
    _titleArray = titleArray;
    
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:KSelectFont];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:KNormalColor forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        [self.buttonArray addObject:button];
        
        // 记录当前X值
        _currentX = CGRectGetMaxX(button.frame);
        
        // 初始化选择第一个
        if (i == 0) {
            
            [button setTitleColor:KSelectColor forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:KSelectFont];
            
            self.lastButton = button;
        
        } else {
            [button setTitleColor:KNormalColor forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:KNormalFont];
        }
    }
    
//    self.scrollView.contentSize = CGSizeMake(_currentX + KMargin, 0);
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.selectView.y = self.height - 3.f;
    self.selectView.height = 2.f;
    
    CGFloat buttonW  = 40;
    CGFloat LRMargin = (self.width - buttonW * 3 - 2 * KMargin) * 0.5;
    
    for (int i = 0; i < self.buttonArray.count; i++) {
        UIButton *button = self.buttonArray[i];
        button.size = CGSizeMake(buttonW, 35);
        button.centerY = self.height * 0.5;
        button.x = LRMargin + (button.width + KMargin) * i;
        
        if (i == 0) {
            self.selectView.width = button.width;
            self.selectView.centerX = button.centerX;
        }
    }
}


- (void)selectViewScroll:(CGFloat)pacentage index:(NSInteger)index direction:(NSInteger)direction {
    
    if (pacentage != 0) {
        // 向后
        if (direction) {
            
            UIButton *current = self.buttonArray[index];
            UIButton *next = self.buttonArray[index + 1];
            
            CGFloat distance = next.centerX - current.centerX;
            
            // 设置位置
            self.selectView.width = (next.width - current.width) * pacentage + current.width;
            self.selectView.centerX = current.centerX + distance * pacentage;
            
            //            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@""];
            
            
            // 设置字体大小
            current.titleLabel.font = [UIFont systemFontOfSize:KSelectFont - (KSelectFont - KNormalFont) * pacentage];
            next.titleLabel.font = [UIFont systemFontOfSize:KNormalFont + (KSelectFont - KNormalFont) * pacentage];
            
            // 设置渐变颜色
            CGFloat currentR = 0;
            CGFloat currentG = 0.67 * (1 - pacentage);
            CGFloat currentB = 0.62 * (1 - pacentage);
            [current setTitleColor:[UIColor colorWithRed:currentR green:currentG blue:currentB alpha:1] forState:UIControlStateNormal];
            
            CGFloat nextR = 0;
            CGFloat nextG = 0.67 * pacentage;
            CGFloat nextB = 0.62 * pacentage;
            [next setTitleColor:[UIColor colorWithRed:nextR green:nextG blue:nextB alpha:1] forState:UIControlStateNormal];
            
        } else {
            
            UIButton *current = self.buttonArray[index];
            UIButton *before = self.buttonArray[index - 1];
            
            CGFloat distance = current.centerX - before.centerX;
            
            // 设置位置
            self.selectView.width = (before.width - current.width) * (1 - pacentage) + current.width;
            self.selectView.centerX = current.centerX - distance * (1 - pacentage);
            
            // 设置字体大小
            current.titleLabel.font = [UIFont systemFontOfSize:KSelectFont - (KSelectFont - KNormalFont) * (1 - pacentage)];
            before.titleLabel.font = [UIFont systemFontOfSize:KNormalFont + (KSelectFont - KNormalFont) * (1- pacentage)];
            
            // 设置渐变颜色
            CGFloat currentR = 0;
            CGFloat currentG = 0.67 * pacentage;
            CGFloat currentB = 0.62 * pacentage;
            [current setTitleColor:[UIColor colorWithRed:currentR green:currentG blue:currentB alpha:1] forState:UIControlStateNormal];
            
            CGFloat beforeR = 0;
            CGFloat beforeG = 0.67 * (1 - pacentage);
            CGFloat beforeB = 0.62 * (1- pacentage);
            [before setTitleColor:[UIColor colorWithRed:beforeR green:beforeG blue:beforeB alpha:1] forState:UIControlStateNormal];
        }
    }
    
}

#pragma mark - 滚动选择button
- (void)scrollToIndex:(NSInteger)index {
    
    UIButton *button = self.buttonArray[index];
    
    if ([button isEqual:self.lastButton]) {
        return;
    }
    
    [self.lastButton setTitleColor:KNormalColor forState:UIControlStateNormal];
    self.lastButton.titleLabel.font = [UIFont systemFontOfSize:KNormalFont];
    
    [button setTitleColor:KSelectColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:KSelectFont];
    
    self.lastButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.selectView.width = button.width;
        self.selectView.centerX = button.centerX;
    }];
    
}

- (void)selectButtonIndex:(NSInteger)index {
    UIButton *btn = self.buttonArray[index];
    [self buttonClick:btn];
}

#pragma mark - action
- (void)buttonClick:(UIButton *)button {
    
    if ([button isEqual:self.lastButton]) {
        return;
    }
    
    [self.lastButton setTitleColor:KNormalColor forState:UIControlStateNormal];
    self.lastButton.titleLabel.font = [UIFont systemFontOfSize:KNormalFont];
    
    [button setTitleColor:KSelectColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:KSelectFont];
    
    self.lastButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.selectView.width = button.width;
        self.selectView.centerX = button.centerX;
    }];
    

    if ([self.delegate respondsToSelector:@selector(segmentView:index:)]) {
        
        [self.delegate segmentView:self index:button.tag];
    }
    
}

@end
