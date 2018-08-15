//
//  KJStoreDetailViewController.m
//  Shopping
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import "KJStoreDetailViewController.h"
#import "KJGoodsViewController.h"
#import "KJInformationViewController.h"
#import "KJCommentViewController.h"
#import "KJStoreNavView.h"
#import "KJScrollView.h"
#import "KJStoreBottomView.h"
#import "KJBuyView.h"

#define KBottomViewH 44

@interface KJStoreDetailViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *childControllers;
@property (nonatomic, weak) KJStoreNavView *navView;
@property (nonatomic, assign) CGFloat lastOffsetX;

@end

@implementation KJStoreDetailViewController

- (NSMutableArray *)childControllers {
    if (!_childControllers) {
        KJGoodsViewController *goodsVc = [KJGoodsViewController new];
        [goodsVc setCommentBlock:^{
            [self.navView contenntSelectButtonIndex:2];
        }];
        [goodsVc setRecommendBlock:^(NSInteger index) {
            KJStoreDetailViewController *storeVc = [[KJStoreDetailViewController alloc] init];
            [self pushViewController:storeVc];
        }];
        KJInformationViewController *inforVc = [KJInformationViewController new];
        KJCommentViewController *commnetVc = [KJCommentViewController new];
        _childControllers = [NSMutableArray arrayWithObjects:goodsVc, inforVc, commnetVc, nil];
    }
    return _childControllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];

}


- (void)setupUI {
    
    UIScrollView *scrollView = [[KJScrollView alloc] initWithFrame:CGRectMake(0, KNavigationBarH, ScreenWidth, ScreenHeight - KNavigationBarH - KBottomViewH)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    [self addChildControllers];
    
    KJStoreNavView *navView = [[KJStoreNavView alloc] init];
    typeof(self) weakSelf = self;
    [navView setLeftBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    [navView setTitleBlock:^(KJStoreNavView *navView, NSInteger index) {
        [weakSelf titleClick:navView index:index];
    }];
    [self.view addSubview:navView];
    [self.view bringSubviewToFront:navView];
    self.navView = navView;
    
    KJStoreBottomView *bottomView = [[KJStoreBottomView alloc] initWithFrame:CGRectMake(0, self.view.height - KBottomViewH, ScreenWidth, KBottomViewH)];
    [bottomView setBottomBlock:^(KJStoreBottomView *bottomView, NSInteger index) {
       
        NSLog(@"%zd",index);
        if (index == 2 || index == 3) {
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            KJBuyView *buyView = [[KJBuyView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
            [buyView showInView:window];
        }
    }];
    [self.view addSubview:bottomView];
}


- (void)addChildControllers {
    
    self.scrollView.contentSize = CGSizeMake(self.view.width * self.childControllers.count, 0);
    
    for (int i = 0; i < self.childControllers.count; i++) {
        
        UIViewController *controller = self.childControllers[i];
        controller.view.frame = CGRectMake(i * self.scrollView.width, 0, self.scrollView.width, self.scrollView.height);
        
        [self addChildViewController:controller];
        [self.scrollView addSubview:controller.view];
    }
}

/*******************************关联逻辑******************************/
// 点击按钮选中
- (void)titleClick:(KJStoreNavView *)navView index:(NSInteger)index {

    [self.scrollView setContentOffset:CGPointMake(index * self.scrollView.width, 0) animated:NO];
}

// 滚动界面选中按钮
#pragma mark - UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    _lastOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / self.view.width;
    CGFloat scrollX = scrollView.contentOffset.x - self.view.width * index;
    CGFloat pacentage = scrollX / self.view.width;

    // 向后滑动
    if (scrollView.contentOffset.x > _lastOffsetX) {
        [self.navView contenntViewScroll:pacentage index:index direction:1];
    } else if (scrollView.contentOffset.x < _lastOffsetX) {
        [self.navView contenntViewScroll:pacentage index:index + 1 direction:0];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"----->%f",self.scrollView.contentOffset.x);
    NSInteger index = (self.scrollView.contentOffset.x + self.view.width * 0.5) / self.view.width;
    [self.navView contenntViewScrollToIndex:index];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"%s",__func__);
}
/*******************************关联逻辑******************************/

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
