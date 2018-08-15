//
//  KJLoopView.m
//  MyChat
//
//  Created by apple on 2017/6/29.
//  Copyright © 2017年 jiankangzhan. All rights reserved.
//

#import "KJLoopView.h"

@interface KJLoopView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger totalPage;
@property (nonatomic, strong) NSTimer *loopTimer;

@end

@implementation KJLoopView

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate         = self;
        _scrollView.pagingEnabled    = YES;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.centerX = self.width * 0.5;
        _pageControl.y = self.height - 20.f;
    }
    return _pageControl;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        
    }
    return self;
}

- (void)setImageItems:(NSArray *)imageItems {
    _imageItems = imageItems;
    _totalPage = imageItems.count;
    self.pageControl.numberOfPages = _totalPage;
    
    // 添加第一张
    UIImageView *firstImage = [[UIImageView alloc] init];
    //    firstImage.userInteractionEnabled = YES;
//    firstImage.image = [UIImage imageNamed:[KJAppData instance].bigImage];
//    NSURL *firstUrl = [NSURL URLWithString:_imageItems.lastObject];
//    [firstImage sd_setImageWithURL:firstUrl placeholderImage:[UIImage imageNamed:@""]];
    firstImage.image = [UIImage imageNamed:_imageItems.lastObject];
    firstImage.frame = CGRectMake(0, 0, self.width, self.height);
    [self.scrollView addSubview:firstImage];
    
    // 滚动第一张显示的位置
    _scrollView.contentOffset = CGPointMake(self.width, 0);
    
    // 添加中间的图片
    for (int i = 0; i < _totalPage; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        imageView.backgroundColor = RandomColor;
        imageView.image = [UIImage imageNamed:_imageItems[i]];
//        NSURL *url = [NSURL URLWithString:_imageItems[i]];
//        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""]];
        CGFloat imageX = self.width * (i + 1);
        imageView.frame = CGRectMake(imageX, 0, self.width, self.height);
        [self.scrollView addSubview:imageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [imageView addGestureRecognizer:tapGesture];
    }
    
    // 添加最后一张
    UIImageView *lastImage = [[UIImageView alloc] init];
    //    lastImage.userInteractionEnabled = YES;

//    NSURL *lastUrl = [NSURL URLWithString:_imageItems.firstObject];
//    [lastImage sd_setImageWithURL:lastUrl placeholderImage:[UIImage imageNamed:[KJAppData instance].bigImage]];
    lastImage.image = [UIImage imageNamed:_imageItems.firstObject];
    lastImage.frame = CGRectMake((_totalPage + 1) * self.width, 0, self.width, self.height);
    [self.scrollView addSubview:lastImage];
    self.scrollView.contentSize = CGSizeMake((_totalPage + 2) * self.width, 0);
    
    // 添加定时器
    [self addLoopTimer];
    
}

#pragma mark - ACTION
- (void)tapGesture:(UIGestureRecognizer *)tap {
    UIImageView *view = (UIImageView *)tap.view;
    
    if ([self.delegate respondsToSelector:@selector(loopView:clieckIndex:)]) {
        
        [self.delegate loopView:self clieckIndex:view.tag];
    }
}

- (void)autoScrollToNext {
    
    //    NSLog(@"****************自动滚动****************");
    
    NSInteger index = self.pageControl.currentPage;
    if (index == _totalPage + 1) {
        index = 0;
    } else {
        index++;
    }
    [self.scrollView setContentOffset:CGPointMake((index + 1) * self.width, 0)animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self invalidateTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addLoopTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //    NSLog(@"正在滚动");
    
    NSInteger index = (self.scrollView.contentOffset.x + self.width * 0.5) / self.width;
    
    if (index == _totalPage + 1) {
        index = 1;
    } else if(index == 0) {
        index = _totalPage;
    }
    self.pageControl.currentPage = index - 1;
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    //    NSLog(@"设置contentoffset");
    
    [self scrollViewDidEndDecelerating:scrollView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = (self.scrollView.contentOffset.x + self.width * 0.5) / self.width;
    
    if (index == _totalPage + 1) {
        [self.scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
    } else if (index == 0) {
        [self.scrollView setContentOffset:CGPointMake(_totalPage * self.width, 0) animated:NO];
    }
}

#pragma mark - Timer
- (void)addLoopTimer {
    if (!_loopTimer) {
        
        _loopTimer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(autoScrollToNext) userInfo:nil repeats:YES];
    }
}

- (void)invalidateTimer {
    if (self.loopTimer) {
        [self.loopTimer invalidate];
        self.loopTimer = nil;
    }
}

@end

