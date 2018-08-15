//
//  KJProductView.m
//  Shopping
//
//  Created by apple on 2018/7/26.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import "KJProductView.h"

@interface KJProductView ()

@property (nonatomic, weak) UIView *titleView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *countLabel;

@property (nonatomic, weak) UIView *locationView;
@property (nonatomic, weak) UILabel *toLabel;
@property (nonatomic, weak) UILabel *locationLabel;
@property (nonatomic, weak) UILabel *haveLabel;
@property (nonatomic, weak) UIImageView *locationImage;
@property (nonatomic, weak) UILabel *freightLabel;

@property (nonatomic, weak) UIImageView *lineView;

@end

@implementation KJProductView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:titleView];
    self.titleView = titleView;
    
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.font = [UIFont systemFontOfSize:15];
    titleLable.textColor = [UIColor blackColor];
    titleLable.text = @"德国喜宝益生菌奶粉pre段600g 6桶";
    [titleView addSubview:titleLable];
    self.titleLabel = titleLable;
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.font = [UIFont systemFontOfSize:18];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.text = @"￥799";
    [titleView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.font = [UIFont systemFontOfSize:12];
    countLabel.textColor = [UIColor blackColor];
    countLabel.text = @"销量: 0件";
    [titleView addSubview:countLabel];
    self.countLabel = countLabel;
    
    UIView *locationView = [[UIView alloc] init];
    locationView.backgroundColor = [UIColor whiteColor];
    [self addSubview:locationView];
    self.locationView = locationView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [locationView addGestureRecognizer:tap];
    
    UILabel *toLabel = [[UILabel alloc] init];
    toLabel.font = [UIFont systemFontOfSize:12];
    toLabel.textColor = [UIColor darkGrayColor];
    toLabel.text = @"送至";
    [locationView addSubview:toLabel];
    self.toLabel = toLabel;
    
    UILabel *locationLabel = [[UILabel alloc] init];
    locationLabel.font = [UIFont systemFontOfSize:12];
    locationLabel.textColor = [UIColor blackColor];
    locationLabel.text = @"全国";
    [locationView addSubview:locationLabel];
    self.locationLabel = locationLabel;
    
    UILabel *haveLabel = [[UILabel alloc] init];
    haveLabel.font = [UIFont systemFontOfSize:12];
    haveLabel.textColor = [UIColor redColor];
    haveLabel.text = @"有货";
    [locationView addSubview:haveLabel];
    self.haveLabel = haveLabel;
    
    UIImageView *locationImage = [[UIImageView alloc] init];
    locationImage.image = [UIImage imageNamed:@"icon_store_location"];
    [locationView addSubview:locationImage];
    self.locationImage = locationImage;
    
    UILabel *freightLabel = [[UILabel alloc] init];
    freightLabel.font = [UIFont systemFontOfSize:12];
    freightLabel.textColor = [UIColor darkGrayColor];
    freightLabel.text = @"免运费";
    [locationView addSubview:freightLabel];
    self.freightLabel = freightLabel;
    
    UIImageView *lineView = [[UIImageView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.78 alpha:1];
    [locationView addSubview:lineView];
    self.lineView = lineView;

}

- (void)tapGesture:(UIGestureRecognizer *)gesture {
    if (self.locationBlock) {
        self.locationBlock();
    }
}

- (CGFloat)currentH {
    return self.locationView.bottom;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleView.frame = CGRectMake(0, 0, self.width, 70);
    
    [self.titleLabel sizeToFit];
    self.titleLabel.x = 10;
    self.titleLabel.y = 10;
    
    [self.priceLabel sizeToFit];
    self.priceLabel.x = self.titleLabel.x;
    self.priceLabel.y = self.titleLabel.bottom + 10;
    
    [self.countLabel sizeToFit];
    self.countLabel.x = self.width - self.countLabel.width - 10;
    self.countLabel.y = self.priceLabel.bottom - self.countLabel.height;
    
    self.locationView.frame = CGRectMake(0, self.titleView.bottom, self.width, 70);
    
    [self.toLabel sizeToFit];
    self.toLabel.x = self.titleLabel.x;
    self.toLabel.y = 15;
    
    [self.locationLabel sizeToFit];
    self.locationLabel.centerY = self.toLabel.centerY;
    self.locationLabel.x = self.toLabel.right + 10;
    
    [self.haveLabel sizeToFit];
    self.haveLabel.centerY = self.toLabel.centerY;
    self.haveLabel.x = self.locationLabel.right + 10;
    
    self.locationImage.size = CGSizeMake(20, 20);
    self.locationImage.centerY = self.toLabel.centerY;
    self.locationImage.x = self.width - self.locationImage.width - 10;
    
    [self.freightLabel sizeToFit];
    self.freightLabel.x = self.locationLabel.x;
    self.freightLabel.y = self.locationLabel.bottom + 10;
    
    self.lineView.frame = CGRectMake(0, self.locationView.height - 0.5, self.width, 0.5);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
