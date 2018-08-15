//
//  KJProductInfo.h
//  Shopping
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KJProductInfo : NSObject

// 商品名
@property (nonatomic, copy) NSString *productName;

// 商品图片
@property (nonatomic, copy) NSString *imageUrl;

// 商品价格
@property (nonatomic, copy) NSString *productPrice;

// 商品数量
@property (nonatomic, assign) int productCount;

// 是否选中商品
@property (nonatomic, assign) BOOL isSelect;

// 是否显示详情
@property (nonatomic, assign) BOOL isShow;

+ (NSMutableArray *)getProductInfos;

@end
