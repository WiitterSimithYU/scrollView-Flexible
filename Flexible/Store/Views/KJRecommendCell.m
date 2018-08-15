//
//  KJRecommendCell.m
//  Shopping
//
//  Created by apple on 2018/7/26.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import "KJRecommendCell.h"

@interface KJRecommendCell ()

@property (nonatomic, weak) UIImageView *iconImage;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *priceLabel;

@end

@implementation KJRecommendCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.layer.borderColor = [UIColor darkGrayColor].CGColor;
    iconImage.layer.borderWidth = 1;
    [self.contentView addSubview:iconImage];
    self.iconImage = iconImage;
    
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.font = [UIFont systemFontOfSize:10];
    titleLable.textColor = [UIColor darkGrayColor];
    titleLable.text = @"美国Baby Ddrops 维生素";
    titleLable.numberOfLines = 2;
    [self addSubview:titleLable];
    self.titleLabel = titleLable;
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.font = [UIFont systemFontOfSize:10];
    priceLabel.textColor = [UIColor blackColor];
    priceLabel.text = @"￥13.00";
    [self addSubview:priceLabel];
    self.priceLabel = priceLabel;
}

// 用于获取控件的宽和高
- (CGSize)textSize:(NSString *)text maxSize:(CGSize )maxSize font:(UIFont *)font {
    
    NSDictionary *dict = @{NSFontAttributeName:font};
    return  [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconImage.frame = CGRectMake(self.width * 0.05, 0, self.width * 0.9, self.width * 0.9);
    
    CGSize size = [self textSize:self.titleLabel.text maxSize:CGSizeMake(self.width * 0.9, MAXFLOAT) font:[UIFont systemFontOfSize:10]];
    self.titleLabel.size = size;
    self.titleLabel.x = self.width * 0.05;
    self.titleLabel.y = self.iconImage.bottom + 5;
    
    [self.priceLabel sizeToFit];
    self.priceLabel.x = self.width * 0.05;
    self.priceLabel.y = self.titleLabel.bottom;
}

@end
