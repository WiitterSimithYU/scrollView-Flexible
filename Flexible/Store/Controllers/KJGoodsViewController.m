//
//  KJGoodsViewController.m
//  Shopping
//
//  Created by apple on 2018/7/25.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import "KJGoodsViewController.h"
#import "KJStoreScrollView.h"
#import "KJProductView.h"
#import "KJSelectView.h"
#import "KJRecommendView.h"
#import "KJBuyView.h"

#define KLoopViewH 300
#define KBottomViewH 44

#define KLRMargin 10
#define KMidMargin 10
#define KCellW (ScreenWidth - 2 * KLRMargin - 3 * KMidMargin) * 0.25

@interface KJGoodsViewController () <UIScrollViewDelegate, KJLoopViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) KJLoopView *loopView;
@property (nonatomic, weak) KJStoreScrollView *contentView;

@end

@implementation KJGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}

- (void)setupUI {
    
    UIScrollView *scrollView = [[KJStoreScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.height - KNavigationBarH - KBottomViewH)];
    scrollView.backgroundColor = [UIColor whiteColor];
    // 适配ios11
    if (@available(iOS 11.0, *)) {
        [scrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    KJLoopView *loopView = [[KJLoopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, KLoopViewH)];
    loopView.imageItems = @[@"ad_00", @"ad_01"];
    loopView.delegate = self;
    [self.scrollView addSubview:loopView];
    self.loopView = loopView;
    
    KJStoreScrollView *contentView = [[KJStoreScrollView alloc] initWithFrame:CGRectZero];
    contentView.backgroundColor = [UIColor whiteColor];
    // 适配ios11
    if (@available(iOS 11.0, *)) {
        [contentView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    contentView.delegate = self;
    [self.scrollView addSubview:contentView];
    self.contentView = contentView;
    
    KJProductView *productView = [[KJProductView alloc] init];
    productView.frame = CGRectMake(0, 0, ScreenWidth, 140);
    [productView setLocationBlock:^{
        NSLog(@"位置视图点击");
    }];
    [contentView addSubview:productView];
    
    typeof(self) weakSelf = self;
    KJSelectView *selectView = [[KJSelectView alloc] init];
    selectView.frame = CGRectMake(0, productView.bottom, ScreenWidth, 120);
    [selectView setSelectBlock:^(NSInteger index) {
       
        NSLog(@"%zd",index);
        if (index == 0) {
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            KJBuyView *buyView = [[KJBuyView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
            [buyView showInView:window];
            
        } else if (index == 1) {
            if (weakSelf.commentBlock) {
                weakSelf.commentBlock();
            }
        }
    }];
    [contentView addSubview:selectView];
    
    KJRecommendView *recommendView = [[KJRecommendView alloc] init];
    recommendView.frame = CGRectMake(0, selectView.bottom, ScreenWidth, KCellW * 1.5 * 2 + 40);
    [recommendView setRecommendBlock:^(NSInteger index) {
        if (weakSelf.recommendBlock) {
            weakSelf.recommendBlock(index);
        }
    }];
    [contentView addSubview:recommendView];
    
    self.contentView.frame = CGRectMake(0, KLoopViewH, ScreenWidth, recommendView.bottom);
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.contentView.bottom);
    
}

- (void)loopView:(KJLoopView *)loopView clieckIndex:(NSInteger)index {
    NSLog(@"current = %zd",index);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
    float diff = scrollView.contentOffset.y;
    NSLog(@"----->%f",diff);
    // 向上滑
    if (diff >= 0) {
        self.loopView.y = diff * 0.5;
    } else {
        self.loopView.y = diff;
        self.contentView.y = KLoopViewH - 0.5 * diff;
    }
    
//    NSLog(@"diff = %.f",diff);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
