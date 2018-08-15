//
//  KJStoreCell.h
//  Shopping
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJProductInfo.h"
@class KJStoreMoveView;

@interface KJStoreCell : UICollectionViewCell

@property (nonatomic, assign) BOOL isListDisplay;
@property (nonatomic, strong) KJProductInfo *productInfo;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) KJStoreMoveView *moveView;

@end
