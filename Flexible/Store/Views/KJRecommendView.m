//
//  KJRecommendView.m
//  Shopping
//
//  Created by apple on 2018/7/26.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import "KJRecommendView.h"
#import "KJRecommendCell.h"

#define KLRMargin 10
#define KMidMargin 10
#define KCellW (ScreenWidth - 2 * KLRMargin - 3 * KMidMargin) * 0.25
#define KCellH KCellW * 1.5

@interface KJRecommendView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation KJRecommendView

static NSString *reuseId = @"KJRecommendCell";

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.font = [UIFont systemFontOfSize:12];
    titleLable.textColor = [UIColor darkGrayColor];
    titleLable.text = @"店铺推荐";
    [self addSubview:titleLable];
    self.titleLabel = titleLable;
    
    // 添加collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collection.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    collection.backgroundColor = [UIColor whiteColor];
    collection.delegate = self;
    collection.dataSource = self;
    if (@available(iOS 11.0, *)) {
        [collection setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [collection registerClass:[KJRecommendCell class] forCellWithReuseIdentifier:reuseId];
    [self addSubview:collection];
    self.collectionView = collection;
}

// 返回组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 返回cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KJRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    
    return cell;
}

//定义每个Cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(KCellW, KCellH);
}

//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

//定义每个Section的四边间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, KLRMargin, 0, KLRMargin);
}

// 点击cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.recommendBlock) {
        self.recommendBlock(indexPath.item);
        
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.size = CGSizeMake(self.width, 30);
    self.titleLabel.centerY = 15;
    self.titleLabel.x = 10;
    
    self.collectionView.frame = CGRectMake(0, self.titleLabel.bottom, self.width, self.height - self.titleLabel.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
