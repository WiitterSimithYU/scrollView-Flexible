//
//  KJSelectView.m
//  Shopping
//
//  Created by apple on 2018/7/26.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import "KJSelectView.h"

@interface KJSelectView ()

@property (nonatomic, weak) UIView *selectView;
@property (nonatomic, weak) UILabel *selectTitle;
@property (nonatomic, weak) UILabel *selectDesc;
@property (nonatomic, weak) UIImageView *selectArrow;

@property (nonatomic, weak) UIView *commentView;
@property (nonatomic, weak) UILabel *commentTitle;
@property (nonatomic, weak) UILabel *commentDesc;
@property (nonatomic, weak) UILabel *commentsub;
@property (nonatomic, weak) UIImageView *commentArrow;

@end

@implementation KJSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = Color(246, 246, 246);
        [self initView];
    }
    return self;
}

- (void)initView {
    
    UIView *selectView = [[UIView alloc] init];
    selectView.tag = 0;
    selectView.backgroundColor = [UIColor whiteColor];
    [self addSubview:selectView];
    self.selectView = selectView;
    
    UILabel *selectTitle = [[UILabel alloc] init];
    selectTitle.font = [UIFont systemFontOfSize:12];
    selectTitle.textColor = [UIColor darkGrayColor];
    selectTitle.text = @"已选";
    [selectView addSubview:selectTitle];
    self.selectTitle = selectTitle;
    
    UILabel *selectDesc = [[UILabel alloc] init];
    selectDesc.font = [UIFont systemFontOfSize:12];
    selectDesc.textColor = [UIColor darkGrayColor];
    selectDesc.text = @"默认";
    [selectView addSubview:selectDesc];
    self.selectDesc = selectDesc;
    
    UIImageView *selectArrow = [[UIImageView alloc] init];
    selectArrow.image = [UIImage imageNamed:@"icon_store_rightarrow"];
    [selectView addSubview:selectArrow];
    self.selectArrow = selectArrow;
    
    UIView *commentView = [[UIView alloc] init];
    commentView.tag = 1;
    commentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:commentView];
    self.commentView = commentView;
    
    UILabel *commentTitle = [[UILabel alloc] init];
    commentTitle.font = [UIFont systemFontOfSize:12];
    commentTitle.textColor = [UIColor darkGrayColor];
    commentTitle.text = @"商品评价";
    [commentView addSubview:commentTitle];
    self.commentTitle = commentTitle;
    
    UILabel *commentDesc = [[UILabel alloc] init];
    commentDesc.font = [UIFont systemFontOfSize:12];
    commentDesc.textColor = [UIColor redColor];
    commentDesc.text = @"好评率100%";
    [commentView addSubview:commentDesc];
    self.commentDesc = commentDesc;
    
    UILabel *commentsub = [[UILabel alloc] init];
    commentsub.font = [UIFont systemFontOfSize:12];
    commentsub.textColor = [UIColor darkGrayColor];
    commentsub.text = @"1人评价";
    [commentView addSubview:commentsub];
    self.commentsub = commentsub;
    
    UIImageView *commentArrow = [[UIImageView alloc] init];
    commentArrow.image = [UIImage imageNamed:@"icon_store_rightarrow"];
    [commentView addSubview:commentArrow];
    self.commentArrow = commentArrow;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [selectView addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1Gesture:)];
    [commentView addGestureRecognizer:tap1];
    
}

- (void)tapGesture:(UIGestureRecognizer *)gesture {
    UIView *view = gesture.view;
    if (self.selectBlock) {
        self.selectBlock(view.tag);
    }
}
- (void)tap1Gesture:(UIGestureRecognizer *)gesture {
    UIView *view = gesture.view;
    if (self.selectBlock) {
        self.selectBlock(view.tag);
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.selectView.frame = CGRectMake(0, 0, self.width, 50);
    [self.selectTitle sizeToFit];
    self.selectTitle.x = 10;
    self.selectTitle.centerY = 25;
    
    [self.selectDesc sizeToFit];
    self.selectDesc.centerY = self.selectTitle.centerY;
    self.selectDesc.x = self.selectTitle.right + 10;
    
    self.selectArrow.size = CGSizeMake(20, 20);
    self.selectArrow.centerY = self.selectTitle.centerY;
    self.selectArrow.x = self.width - self.selectArrow.width - 10;
    
    
    self.commentView.frame = CGRectMake(0, self.selectView.bottom + 10, self.width, 50);
    [self.commentTitle sizeToFit];
    self.commentTitle.x = 10;
    self.commentTitle.centerY = 25;
    
    [self.commentDesc sizeToFit];
    self.commentDesc.centerY = self.commentTitle.centerY;
    self.commentDesc.x = self.commentTitle.right + 10;
    
    self.commentArrow.size = CGSizeMake(20, 20);
    self.commentArrow.centerY = self.commentTitle.centerY;
    self.commentArrow.x = self.width - self.commentArrow.width - 10;
    
    [self.commentsub sizeToFit];
    self.commentsub.centerY = self.commentTitle.centerY;
    self.commentsub.x = self.commentArrow.x - self.commentsub.width - 10;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
