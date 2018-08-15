//
//  KJStoreCell.m
//  Shopping
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import "KJStoreCell.h"
#import "KJStoreMoveView.h"

@interface KJStoreCell ()

@property (nonatomic, weak) UIImageView *iconImage;
@property (nonatomic, weak) UILabel *titleLable;
@property (nonatomic, weak) UILabel *ticketLable;
@property (nonatomic, weak) UILabel *freeLable;
@property (nonatomic, weak) UILabel *publicLable;
@property (nonatomic, weak) UILabel *priceLable;
@property (nonatomic, weak) UILabel *countLable;
@property (nonatomic, weak) UILabel *storeLable;
@property (nonatomic, weak) UILabel *locationLable;
@property (nonatomic, weak) UIButton *storeBtn;
@property (nonatomic, weak) UIButton *pointBtn;

@end

@implementation KJStoreCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {

        self.backgroundColor = [UIColor whiteColor];
        
        [self initView];
    }
    
    return self;
}

- (void)initView {
    
    // 创建子控件
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.layer.cornerRadius = 5.f;
    iconImage.layer.masksToBounds = YES;
    iconImage.image = [UIImage imageNamed:@"icon_home_device"];
    iconImage.contentMode = UIViewContentModeScaleAspectFit;
    iconImage.backgroundColor = Color(0, 172, 160);
    [self.contentView addSubview:iconImage];
    self.iconImage = iconImage;

    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.font = [UIFont systemFontOfSize:14];
    titleLable.textColor = [UIColor blackColor];
    titleLable.numberOfLines = 2;
    titleLable.text = @"商品名称";
    [self.contentView addSubview:titleLable];
    self.titleLable = titleLable;
    
    UILabel *ticketLable = [[UILabel alloc] init];
    ticketLable.font = [UIFont systemFontOfSize:10];
    ticketLable.textColor = Color(0x66, 0x66, 0x66);
    ticketLable.backgroundColor = Color(246, 246, 246);
    ticketLable.text = @"店铺券满100减200";
    ticketLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:ticketLable];
    self.ticketLable = ticketLable;
    
    UILabel *freeLable = [[UILabel alloc] init];
    freeLable.font = [UIFont systemFontOfSize:8];
    freeLable.textColor = [UIColor orangeColor];
    freeLable.backgroundColor = [UIColor whiteColor];
    freeLable.text = @"免邮";
    freeLable.layer.cornerRadius = 2;
    freeLable.layer.masksToBounds = YES;
    freeLable.layer.borderColor = [UIColor orangeColor].CGColor;
    freeLable.layer.borderWidth = 0.5;
    freeLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:freeLable];
    self.freeLable = freeLable;
    
    UILabel *publicLable = [[UILabel alloc] init];
    publicLable.font = [UIFont systemFontOfSize:8];
    publicLable.textColor = [UIColor redColor];
    publicLable.backgroundColor = [UIColor whiteColor];
    publicLable.text = @"公益宝贝";
    publicLable.layer.cornerRadius = 2;
    publicLable.layer.masksToBounds = YES;
    publicLable.layer.borderColor = [UIColor redColor].CGColor;
    publicLable.layer.borderWidth = 0.5;
    publicLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:publicLable];
    self.publicLable = publicLable;

    UILabel *priceLable = [[UILabel alloc] init];
    priceLable.font = [UIFont systemFontOfSize:15];
    priceLable.textColor = [UIColor redColor];
    priceLable.text = @"商品价格";
    priceLable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:priceLable];
    self.priceLable = priceLable;
    
    UILabel *countLable = [[UILabel alloc] init];
    countLable.font = [UIFont systemFontOfSize:10];
    countLable.textColor = Color(0x66, 0x66, 0x66);
    countLable.text = @"100人付款";
    [self.contentView addSubview:countLable];
    self.countLable = countLable;
    
    UILabel *storeLable = [[UILabel alloc] init];
    storeLable.font = [UIFont systemFontOfSize:10];
    storeLable.textColor = Color(0x66, 0x66, 0x66);
    storeLable.text = @"xxxxxxxx店铺";
    [self.contentView addSubview:storeLable];
    self.storeLable = storeLable;
    
    UILabel *locationLable = [[UILabel alloc] init];
    locationLable.font = [UIFont systemFontOfSize:10];
    locationLable.textColor = Color(0x66, 0x66, 0x66);
    locationLable.text = @"北京";
    [self.contentView addSubview:locationLable];
    self.locationLable = locationLable;
    
    UIButton *storeBtn = [[UIButton alloc] init];
    storeBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [storeBtn setTitleColor:Color(0x66, 0x66, 0x66) forState:UIControlStateNormal];
    [storeBtn setTitle:@"进店" forState:UIControlStateNormal];
    [storeBtn setImage:[UIImage imageNamed:@"icon_right_arrow"] forState:UIControlStateNormal];
    [storeBtn addTarget:self action:@selector(storeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:storeBtn];
    self.storeBtn = storeBtn;
    
    UIButton *pointBtn = [[UIButton alloc] init];
    [pointBtn setImage:[UIImage imageNamed:@"icon_point"] forState:UIControlStateNormal];
    [pointBtn addTarget:self action:@selector(pointBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:pointBtn];
    self.pointBtn = pointBtn;
    
    KJStoreMoveView *moveView = [[KJStoreMoveView alloc] init];
    [self.contentView addSubview:moveView];
    self.moveView = moveView;
}


- (void)storeBtnClick:(UIButton *)btn {
    [MBProgressHUD showMessageWithText:@"进入商家店铺"];
}

- (void)pointBtnClick:(UIButton *)btn {
//    [MBProgressHUD showMessageWithText:@"视图移入操作"];
    [self.moveView showInView:self.contentView];
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    self.moveView.indexPath = indexPath;
}

- (void)setProductInfo:(KJProductInfo *)productInfo {
    _productInfo = productInfo;
    self.titleLable.text = productInfo.productName;
    self.priceLable.text = [NSString stringWithFormat:@"￥%@",productInfo.productPrice];
    
    self.moveView.isShow = productInfo.isShow;
    
    // 重新布局
    [self setNeedsLayout];
}

- (void)setIsListDisplay:(BOOL)isListDisplay {
    _isListDisplay = isListDisplay;
    
    self.moveView.isListDisplay = isListDisplay;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_isListDisplay) {
        
        self.titleLable.numberOfLines = 2;
        self.ticketLable.hidden = NO;
        self.storeLable.hidden = NO;
    
        self.iconImage.frame = CGRectMake(10, 5, self.height - 10, self.height - 10);
        
//        self.titleLable.size = [self textSize:self.titleLable.text width:self.width font:15];
        self.titleLable.size = CGSizeMake(self.width - self.iconImage.width - 30, 40);
        self.titleLable.y = self.iconImage.y;
        self.titleLable.x = self.iconImage.right + 10;
        
        [self.ticketLable sizeToFit];
        self.ticketLable.width += self.ticketLable.height;
        self.ticketLable.layer.cornerRadius = self.ticketLable.height * 0.5;
        self.ticketLable.layer.masksToBounds = YES;
        self.ticketLable.y = self.titleLable.bottom + 5;
        self.ticketLable.x = self.titleLable.x;
        
        [self.freeLable sizeToFit];
        self.freeLable.size = CGSizeMake(self.freeLable.width + 4.f, self.freeLable.height + 4.f);
        self.freeLable.x = self.titleLable.x;
        self.freeLable.y = self.ticketLable.bottom + 8;
        
        [self.publicLable sizeToFit];
        self.publicLable.size = CGSizeMake(self.publicLable.width + 4.f, self.publicLable.height + 4.f);
        self.publicLable.x = self.freeLable.right + 5;
        self.publicLable.y = self.freeLable.y;
        
        [self.storeLable sizeToFit];
        self.storeLable.x = self.iconImage.right + 10;
        self.storeLable.y = self.height - 10 - self.storeLable.height;
        
        [self.locationLable sizeToFit];
        self.locationLable.centerY = self.storeLable.centerY;
        self.locationLable.x = self.storeLable.right + 5;
        
        [self.storeBtn sizeToFit];
        // 改变button内部的lable和image位置
        CGFloat imageWidth = self.storeBtn.imageView.width;
        CGFloat labelWidth = self.storeBtn.titleLabel.width;
        self.storeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth , 0, -labelWidth);
        self.storeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
        self.storeBtn.centerY = self.storeLable.centerY;
        self.storeBtn.x = self.locationLable.right + 5;
        
        [self.pointBtn sizeToFit];
        self.pointBtn.centerY = self.storeLable.centerY;
        self.pointBtn.x = self.width - 10 - self.pointBtn.width;
        
        [self.priceLable sizeToFit];
        self.priceLable.x = self.iconImage.right + 10;
        self.priceLable.y = self.storeLable.y - 5 - self.priceLable.height;
        
        [self.countLable sizeToFit];
        self.countLable.x = self.priceLable.right + 10;
        self.countLable.y = self.storeLable.y - 5  - self.countLable.height;
        
        if (!self.moveView.isShow) {
            self.moveView.size = CGSizeMake(self.width - (self.height - 10) - 20, self.height);
            self.moveView.x = self.width;
            self.moveView.y = 0;
        } else {
            self.moveView.size = CGSizeMake(self.width - (self.height - 10) - 20, self.height);
            self.moveView.x = self.width - self.moveView.width;
            self.moveView.y = 0;
        }
    
        
    } else {
        
        self.titleLable.numberOfLines = 1;
        self.ticketLable.hidden = YES;
        self.storeLable.hidden = YES;
    
        self.iconImage.size = CGSizeMake(self.width, self.width);
        self.iconImage.x = self.iconImage.y = 0;
        
//        self.titleLable.size = [self textSize:self.titleLable.text width:self.width font:15];
        self.titleLable.size = CGSizeMake(self.width - 10, 20);
        self.titleLable.x = 5;
        self.titleLable.y = self.iconImage.bottom + 5;
        
        [self.freeLable sizeToFit];
        self.freeLable.size = CGSizeMake(self.freeLable.width + 4.f, self.freeLable.height + 4.f);
        self.freeLable.x = self.titleLable.x;
        self.freeLable.y = self.titleLable.bottom + 8;
        
        [self.publicLable sizeToFit];
        self.publicLable.size = CGSizeMake(self.publicLable.width + 4.f, self.publicLable.height + 4.f);
        self.publicLable.x = self.freeLable.right + 5;
        self.publicLable.y = self.freeLable.y;
        
        [self.locationLable sizeToFit];
        self.locationLable.centerY = self.freeLable.centerY;
        self.locationLable.x = self.width - 5 - self.locationLable.width;
        
        [self.priceLable sizeToFit];
        self.priceLable.x = 5;
        self.priceLable.y = self.height - self.priceLable.height - 5;
        
        [self.countLable sizeToFit];
        self.countLable.x = self.priceLable.right + 10;
        self.countLable.y = self.height - self.countLable.height - 5;
        
        [self.pointBtn sizeToFit];
        self.pointBtn.centerY = self.countLable.centerY;
        self.pointBtn.x = self.width - 5 - self.pointBtn.width;
        
        if (!self.moveView.isShow) {
            self.moveView.size = CGSizeMake(self.width, self.height * 0.5);
            self.moveView.y = self.height * 0.5;
            self.moveView.x = self.width;
        } else {
            self.moveView.size = CGSizeMake(self.width, self.height * 0.5);
            self.moveView.y = self.height * 0.5;
            self.moveView.x = 0;
        }
        
    }
    
}

// 用于获取控件的宽和高
- (CGSize)textSize:(NSString *)text width:(CGFloat)width font:(CGFloat)fontSize
{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGSize maxSize = CGSizeMake(width - 10, MAXFLOAT);
    NSDictionary *dict = @{NSFontAttributeName:font};
    return  [text boundingRectWithSize:maxSize options: NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}


@end
