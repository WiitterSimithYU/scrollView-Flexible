//
//  KJStoreMoveView.m
//  Shopping
//
//  Created by apple on 2018/7/17.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import "KJStoreMoveView.h"
#import "KJStoreCell.h"

@interface KJStoreMoveView()

@property (nonatomic, weak) UIView *fatherView;
@property (nonatomic, weak) UIButton *eqalBtn; //同款
@property (nonatomic, weak) UIButton *sameBtn; // 相似
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *descLabel;
@property (nonatomic, weak) UILabel *commentLabel;
@property (nonatomic, weak) UILabel *serviceLabel;
@property (nonatomic, weak) UILabel *pictureLabel;
@property (nonatomic, weak) UILabel *transLabel;
@property (nonatomic, weak) UILabel *appendLabel;


@end

@implementation KJStoreMoveView

- (instancetype)init {
    if (self = [super init]) {
        
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95];
        
        [self initView];
    }
    return self;
}

- (void)initView {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    
    UIButton *eqalBtn = [[UIButton alloc] init];
    eqalBtn.backgroundColor = [UIColor redColor];
    [eqalBtn setTitle:@"找同款" forState:UIControlStateNormal];
    [eqalBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    eqalBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [eqalBtn addTarget:self action:@selector(eqalBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:eqalBtn];
    self.eqalBtn = eqalBtn;
    
    UIButton *sameBtn = [[UIButton alloc] init];
    sameBtn.backgroundColor = [UIColor orangeColor];
    [sameBtn setTitle:@"找同款" forState:UIControlStateNormal];
    [sameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sameBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [sameBtn addTarget:self action:@selector(sameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sameBtn];
    self.sameBtn = sameBtn;
    
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.font = [UIFont systemFontOfSize:12];
    titleLable.textColor = [UIColor darkGrayColor];
    titleLable.text = @"xxxxxxxxx公司";
    [self addSubview:titleLable];
    self.titleLabel = titleLable;
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.font = [UIFont systemFontOfSize:10];
    descLabel.textColor = [UIColor darkGrayColor];
    descLabel.text = @"描述 4.8";
    [self addSubview:descLabel];
    self.descLabel = descLabel;
    
    UILabel *commentLabel = [[UILabel alloc] init];
    commentLabel.font = [UIFont systemFontOfSize:10];
    commentLabel.textColor = [UIColor darkGrayColor];
    commentLabel.text = @"评论(999+)";
    [self addSubview:commentLabel];
    self.commentLabel = commentLabel;
    
    UILabel *serviceLabel = [[UILabel alloc] init];
    serviceLabel.font = [UIFont systemFontOfSize:10];
    serviceLabel.textColor = [UIColor darkGrayColor];
    serviceLabel.text = @"服务 4.8";
    [self addSubview:serviceLabel];
    self.serviceLabel = serviceLabel;
    
    UILabel *pictureLabel = [[UILabel alloc] init];
    pictureLabel.font = [UIFont systemFontOfSize:10];
    pictureLabel.textColor = [UIColor darkGrayColor];
    pictureLabel.text = @"有图(999+)";
    [self addSubview:pictureLabel];
    self.pictureLabel = pictureLabel;
    
    UILabel *transLabel = [[UILabel alloc] init];
    transLabel.font = [UIFont systemFontOfSize:10];
    transLabel.textColor = [UIColor darkGrayColor];
    transLabel.text = @"物流 4.8";
    [self addSubview:transLabel];
    self.transLabel = transLabel;
    
    UILabel *appendLabel = [[UILabel alloc] init];
    appendLabel.font = [UIFont systemFontOfSize:10];
    appendLabel.textColor = [UIColor darkGrayColor];
    appendLabel.text = @"追加(999+)";
    [self addSubview:appendLabel];
    self.appendLabel = appendLabel;
}

- (void)eqalBtnClick:(UIButton *)btn {
    
    [MBProgressHUD showMessageWithText:@"跳转控制器"];
}

- (void)sameBtnClick:(UIButton *)btn {
    [MBProgressHUD showMessageWithText:@"跳转控制器"];
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    
}

- (void)showInView:(UIView *)view {
    self.fatherView = view;
    
    self.isShow = YES;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (_isListDisplay) {
            self.x = view.width - self.width;
        } else {
            self.x = 0;
        }
    } completion:nil];

}

- (void)dismiss {
    
    [UIView animateWithDuration:0.5 animations:^{
    
        if (_isListDisplay) {
            self.x = self.fatherView.width;
        } else {
            
            self.x = self.fatherView.width;
        }
        
    } completion:^(BOOL finished) {
        self.isShow = NO;
    }];
}


- (void)tap:(UIGestureRecognizer *)gesture {
    [self dismiss];
}

- (void)setIsShow:(BOOL)isShow {
    _isShow = isShow;
    
    if (isShow) {
        self.hidden = NO;
    } else {
        self.hidden = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_isListDisplay) {
        
        self.sameBtn.size = self.eqalBtn.size = CGSizeMake(40, self.height * 0.5);
        self.sameBtn.x = self.eqalBtn.x = self.width - self.eqalBtn.width;
        self.sameBtn.y = self.height * 0.5;
        
        [self.titleLabel sizeToFit];
        self.titleLabel.x = 10.f;
        self.titleLabel.y = 10.f;
        
        CGFloat width = (self.width - 20 - self.sameBtn.width) * 0.5;
        CGFloat height = 20;
        CGFloat marginY = 8;
        
        self.descLabel.size = self.commentLabel.size = self.serviceLabel.size = self.pictureLabel.size = self.transLabel.size = self.appendLabel.size = CGSizeMake(width, height);
        
        self.descLabel.x = self.serviceLabel.x = self.transLabel.x = 10;
        self.commentLabel.x = self.pictureLabel.x = self.appendLabel.x = 10 + width;
        
        self.transLabel.y = self.appendLabel.y = self.height - height - marginY;
        
        self.serviceLabel.y = self.pictureLabel.y = self.transLabel.y - height - marginY;
        
        self.descLabel.y = self.commentLabel.y = self.serviceLabel.y - height - marginY;
        
    } else {
        
        self.eqalBtn.size = self.sameBtn.size = CGSizeMake(self.width * 0.5, 30);
        self.eqalBtn.y = self.sameBtn.y = 0;
        self.eqalBtn.x = 0;
        self.sameBtn.x = self.width * 0.5;
        
        [self.titleLabel sizeToFit];
        self.titleLabel.x = 5;
        self.titleLabel.y = self.eqalBtn.bottom + 10;
        
        CGFloat width = (self.width - 20) * 0.5;
        CGFloat height = 20;
        CGFloat marginY = 2;
        
        self.descLabel.size = self.commentLabel.size = self.serviceLabel.size = self.pictureLabel.size = self.transLabel.size = self.appendLabel.size = CGSizeMake(width, height);
        
        self.descLabel.x = self.serviceLabel.x = self.transLabel.x = 10;
        self.commentLabel.x = self.pictureLabel.x = self.appendLabel.x = 10 + width;
        
        self.transLabel.y = self.appendLabel.y = self.height - height - marginY;
        
        self.serviceLabel.y = self.pictureLabel.y = self.transLabel.y - height - marginY;
        
        self.descLabel.y = self.commentLabel.y = self.serviceLabel.y - height - marginY;
    }
    
}

@end
