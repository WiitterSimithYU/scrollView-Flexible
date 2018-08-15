//
//  KJProductInfo.m
//  Shopping
//
//  Created by apple on 2018/7/6.
//  Copyright © 2018年 CoderYS. All rights reserved.
//

#import "KJProductInfo.h"

@implementation KJProductInfo

+ (NSMutableArray *)getProductInfos {

    KJProductInfo *product1 = [[KJProductInfo alloc] init];
    product1.productName = @"xxxxxxxxxxxxx机器人";
    product1.productPrice = @"980";
    product1.productCount = 1;
    
    KJProductInfo *product2 = [[KJProductInfo alloc] init];
    product2.productName = @"xxxxxxxxxxxxx无人机";
    product2.productPrice = @"1080";
    product2.productCount = 1;
    
    KJProductInfo *product3 = [[KJProductInfo alloc] init];
    product3.productName = @"xxxxxxxxxxxxx电池";
    product3.productPrice = @"47";
    product3.productCount = 1;
    
    KJProductInfo *product4 = [[KJProductInfo alloc] init];
    product4.productName = @"xxxxxxxxxxxxx数码";
    product4.productPrice = @"105";
    product4.productCount = 1;

    KJProductInfo *product5 = [[KJProductInfo alloc] init];
    product5.productName = @"xxxxxxxxxxxxx相机";
    product5.productPrice = @"318";
    product5.productCount = 1;
    
    KJProductInfo *product6 = [[KJProductInfo alloc] init];
    product6.productName = @"xxxxxxxxxxxxx手机";
    product6.productPrice = @"206";
    product6.productCount = 1;
    
    KJProductInfo *product7 = [[KJProductInfo alloc] init];
    product7.productName = @"xxxxxxxxxxxxx飞机";
    product7.productPrice = @"588";
    product7.productCount = 1;
    
    KJProductInfo *product8 = [[KJProductInfo alloc] init];
    product8.productName = @"xxxxxxxxxxxxx坦克";
    product8.productPrice = @"98";
    product8.productCount = 1;
    

    return [NSMutableArray arrayWithObjects:product1, product2, product3, product4, product5, product6,product7, product8, nil];
}

@end
