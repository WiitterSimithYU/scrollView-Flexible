//
//  ViewController.m
//  Shopping
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import "KJStoreViewController.h"
#import "KJStoreDetailViewController.h"
#import "KJStoreMoveView.h"
#import "KJStoreCell.h"

#define KLRMargin 15
#define KMIDMargin 10

#define KListW ScreenWidth
#define KListH ScreenHeight / 5

#define KFlowW (ScreenWidth - 2 *KLRMargin - KMIDMargin) * 0.5
#define KFlowH KFlowW * 1.5

#define KLoopViewH 200

@interface KJStoreViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *productInfos;
@property (nonatomic, assign) BOOL isListDisplay;

@property (nonatomic, strong) NSMutableDictionary *cellDic;

@property (nonatomic, weak) UIImageView *sobotImage;

@end

@implementation KJStoreViewController

static NSString *resueId = @"KJStoreCell";

- (NSMutableArray *)productInfos {
    if (!_productInfos) {
        _productInfos = [KJProductInfo getProductInfos];
    }
    return _productInfos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 默认列表显示
    _isListDisplay = YES;
    _cellDic = [[NSMutableDictionary alloc] init];

    self.titleName = @"商城";
    
    [self setupUI];
}

- (void)changeBtnBtnClcik:(UIButton *)btn {
    
    _isListDisplay = btn.selected;
    btn.selected = !btn.selected;
    
    // 刷新布局
    [self.collectionView reloadData];
}

- (void)setupUI {
    
    UIButton *changeBtn = [[UIButton alloc] init];
    [changeBtn setImage:[UIImage imageNamed:@"icon_product_flow"] forState:UIControlStateNormal];
    [changeBtn setImage:[UIImage imageNamed:@"icon_product_list"] forState:UIControlStateSelected];
    [changeBtn addTarget:self action:@selector(changeBtnBtnClcik:) forControlEvents:UIControlEventTouchUpInside];
    [changeBtn sizeToFit];
    changeBtn.x = ScreenWidth - changeBtn.width - 10;
    changeBtn.centerY = KStatusBarH + (KNavigationBarH - KStatusBarH) * 0.5;
    [self.navView addSubview:changeBtn];
    
    // 添加collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //    layout.itemSize = CGSizeMake(cellW, cellH);
    //    layout.minimumLineSpacing = 0;
    //    layout.minimumInteritemSpacing = 0;
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:layout];
    collection.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    collection.backgroundColor = Color(246, 246, 246);
    collection.delegate = self;
    collection.dataSource = self;
    collection.contentInset = UIEdgeInsetsMake(KLoopViewH, 0, 0, 0);
    [collection registerClass:[KJStoreCell class] forCellWithReuseIdentifier:resueId];
    if (@available(iOS 11.0, *)) {
        [collection setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    } 
    [self.view addSubview:collection];
    self.collectionView = collection;
    
    KJLoopView *loopView = [[KJLoopView alloc] initWithFrame:CGRectMake(0, -KLoopViewH, ScreenWidth, KLoopViewH)];
    loopView.imageItems = @[@"ad_00", @"ad_01"];
    [collection addSubview:loopView];
    
    // 下拉刷新
    YSRefreshHeader *header = [YSRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullToReloadData)];
    header.lastUpdatedTimeLabel.hidden = YES;// 隐藏时间
    //    header.automaticallyChangeAlpha = YES;
    header.ignoredScrollViewContentInsetTop = KLoopViewH;
    header.stateLabel.textColor = Color(153, 153, 153);
    self.collectionView.mj_header = header;
    

    self.navView.alpha = 0;
    [self.view bringSubviewToFront:self.navView];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat alpha = (scrollView.contentOffset.y + KLoopViewH) / (KLoopViewH - KNavigationBarH);
    if (alpha >= 1) alpha = 1;
    self.navView.alpha = alpha;
}

- (void)pullToReloadData {
    
    [self.collectionView.mj_header endRefreshing];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.productInfos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KJStoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:resueId forIndexPath:indexPath];

    cell.indexPath = indexPath;
    cell.isListDisplay = _isListDisplay;
    KJProductInfo *productInfo = self.productInfos[indexPath.item];
    cell.productInfo = productInfo;
    
    return cell;
}

//定义每个Cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isListDisplay) {
        return CGSizeMake(KListW, KListH);
    } else {
        return CGSizeMake(KFlowW, KFlowH);
    }
}

//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (_isListDisplay) {
        return 0;
    } else {
        return KMIDMargin;
    }
    
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    if (_isListDisplay) {
        return 0;
    } else {
        return KMIDMargin;
    }
}

//定义每个Section的四边间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (_isListDisplay) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    } else {
        return UIEdgeInsetsMake(KMIDMargin, KLRMargin, KMIDMargin, KLRMargin);
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    KJStoreDetailViewController *detailVc = [[KJStoreDetailViewController alloc] init];
    [self pushViewController:detailVc];
}

//创建头视图
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader" forIndexPath:indexPath];
//    headView.backgroundColor = [UIColor whiteColor];
//
//
//    return headView;
//}


//// 设置section头视图的参考大小，与tableheaderview类似
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//
//    return CGSizeMake(ScreenWidth, 40);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
