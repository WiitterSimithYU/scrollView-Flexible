//
//  KJBuyView.m
//  Shopping
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import "KJBuyView.h"
#import "PPNumberButton.h"
#define bgViewH 400

@interface KJBuyView ()

@property (nonatomic, strong) UIView *darkView;
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, weak) UIView *titleView;
@property (nonatomic, weak) UIImageView *iconImage;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *countLabel;

@property (nonatomic, weak) UIView *selectView;
@property (nonatomic, weak) UIImageView *topline;
@property (nonatomic, weak) UIImageView *bottomline;

@property (nonatomic, weak) UIView *buyCountView;
@property (nonatomic, weak)  UILabel *buyLabel;
@property (nonatomic, weak)  PPNumberButton *numberButton;

@property (nonatomic, weak) UIView *bottomView;
@property (nonatomic, weak) UIButton *joinBtn;
@property (nonatomic, weak) UIButton *buyBtn;

@end

@implementation KJBuyView

- (UIView *)darkView {
    if (!_darkView) {
        _darkView = [[UIView alloc]init];
        _darkView.frame = CGRectMake(0, 0, self.width, self.height);
        _darkView.backgroundColor = [UIColor blackColor];
        _darkView.alpha = 0.6;
    }
    return _darkView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.frame = CGRectMake(0, self.height, self.width, bgViewH);
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initGesture];
        [self initView];
    }
    return self;
}

- (void)initGesture {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.darkView addGestureRecognizer:tap];
}

- (void)showInView:(UIView *)view {
    
    [self show:view];
}

// 透过上层视图响应下层视图
//- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *hitView = [super hitTest:point withEvent:event];
//
//    // 转换坐标系
//    CGPoint newPoint = [self.bgView convertPoint:point fromView:self];
//    // 判断触摸点是否在button上
//    if (CGRectContainsPoint(self.bgView.bounds, newPoint)) {
//        hitView = nil;
//    }
//
//    return hitView;
//}

- (void)initView {
    [self addSubview:self.darkView];
    [self addSubview:self.bgView];
    
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:titleView];
    self.titleView = titleView;
    
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.backgroundColor = [UIColor whiteColor];
    iconImage.layer.borderWidth = 1;
    iconImage.layer.borderColor = [UIColor blackColor].CGColor;
    [titleView addSubview:iconImage];
    self.iconImage = iconImage;
    
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.font = [UIFont systemFontOfSize:15];
    titleLable.textColor = [UIColor blackColor];
    titleLable.text = @"德国喜宝益生菌奶粉pre段600g 6桶";
    [titleView addSubview:titleLable];
    self.titleLabel = titleLable;
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.text = @"￥799";
    [titleView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.font = [UIFont systemFontOfSize:12];
    countLabel.textColor = [UIColor darkGrayColor];
    countLabel.text = @"销量: 789件";
    [titleView addSubview:countLabel];
    self.countLabel = countLabel;
    
    UIView *selectView = [[UIView alloc] init];
    selectView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:selectView];
    self.selectView = selectView;
    
    UIImageView *topline = [[UIImageView alloc] init];
    topline.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [selectView addSubview:topline];
    self.topline = topline;
    
    UIImageView *bottomline = [[UIImageView alloc] init];
    bottomline.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [selectView addSubview:bottomline];
    self.bottomline = bottomline;
    
    UIView *buyCountView = [[UIView alloc] init];
    buyCountView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:buyCountView];
    self.buyCountView = buyCountView;
    
    UILabel *buyLabel = [[UILabel alloc] init];
    buyLabel.font = [UIFont systemFontOfSize:15];
    buyLabel.textColor = [UIColor blackColor];
    buyLabel.text = @"购买数量";
    [buyCountView addSubview:buyLabel];
    self.buyLabel = buyLabel;
    
    PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectZero];
    //设置边框颜色
    numberButton.borderColor = [UIColor grayColor];
    numberButton.increaseTitle = @"＋";
    numberButton.decreaseTitle = @"－";
    numberButton.minValue = 1;
//    __weak typeof(self) weakSelf = self;
//    numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus){
//        weakSelf.productInfo.productCount = number;
//        if ([weakSelf.delegate respondsToSelector:@selector(refreshPrice)]) {
//            [weakSelf.delegate refreshPrice];
//        }
//    };
    [buyCountView addSubview:numberButton];
    self.numberButton = numberButton;
    
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:bottomView];
    self.bottomView = bottomView;
    
    UIButton *joinBtn = [[UIButton alloc] init];
    joinBtn.tag = 0;
    joinBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    joinBtn.backgroundColor = [UIColor orangeColor];
    [joinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [joinBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [joinBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:joinBtn];
    self.joinBtn = joinBtn;
    
    UIButton *buyBtn = [[UIButton alloc] init];
    buyBtn.tag = 1;
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    buyBtn.backgroundColor = [UIColor redColor];
    [buyBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:buyBtn];
    self.buyBtn = buyBtn;
}

- (void)bottomBtnClick:(UIButton *)btn {
    
}

- (void)show:(UIView *)view {
    
    [UIView animateWithDuration:0.3 animations:^{
        
//        CGPoint point = self.center;
//        point.y -= bgViewH ;
//        self.center = point;
        self.bgView.y -= bgViewH;
    } completion:^(BOOL finished) {
    }];

    [view addSubview:self];
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.3 animations:^{
        
//        CGPoint point = self.center;
//        point.y      += bgViewH;
//        self.center   = point;
        self.bgView.y += bgViewH;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}



- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleView.frame = CGRectMake(0, 0, self.bgView.width, 100);
    self.iconImage.frame = CGRectMake(10, 10, 80, 80);
    
    [self.titleLabel sizeToFit];
    self.titleLabel.x = self.iconImage.right + 10;
    self.titleLabel.y = 10;
    
    [self.priceLabel sizeToFit];
    self.priceLabel.x = self.iconImage.right + 10;
    self.priceLabel.y = self.iconImage.bottom - self.priceLabel.height;
    
    [self.countLabel sizeToFit];
    self.countLabel.x = self.bgView.width - self.countLabel.width - 10;
    self.countLabel.centerY = self.priceLabel.centerY;
    
    self.selectView.frame = CGRectMake(0, self.titleView.bottom, self.bgView.width, 100);
    self.topline.frame = CGRectMake(0, 0, self.bgView.width, 0.5);
    self.bottomline.frame = CGRectMake(0, self.selectView.height - 0.5, self.bgView.width, 0.5);
    
    self.buyCountView.frame = CGRectMake(0, self.selectView.bottom, self.bgView.width, 50);
    [self.buyLabel sizeToFit];
    self.buyLabel.x = 10;
    self.buyLabel.centerY = self.buyCountView.height * 0.5;
    
    self.numberButton.size = CGSizeMake(70, 20);
    self.numberButton.centerY = self.buyLabel.centerY;
    self.numberButton.x = self.buyCountView.width - self.numberButton.width - 10;
    
    self.bottomView.frame = CGRectMake(0, self.bgView.height - 44, self.bgView.width, 44);
    self.joinBtn.frame = CGRectMake(0, 0, self.bottomView.width * 0.5, 44);
    self.buyBtn.frame = CGRectMake(self.bottomView.width * 0.5, 0, self.bottomView.width * 0.5, 44);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
