//
//  UIButton+KJIndexPath.m
//  HealthStation
//
//  Created by apple on 2017/3/22.
//  Copyright © 2017年 jiankangzhan. All rights reserved.
//

#import "UIButton+KJIndexPath.h"
#import <objc/runtime.h>

@implementation UIButton (KJIndexPath)

static char indexPathKey;
- (NSIndexPath *)indexPath{// get方法
    return objc_getAssociatedObject(self, &indexPathKey);
}

- (void)setIndexPath:(NSIndexPath *)indexPath{// set方法
    // OBJC_ASSOCIATION_RETAIN_NONATOMIC  这个参数主要看单词的第三个，OC对象是retain或者copy，跟属性一个道理，
    // OBJC_ASSOCIATION_ASSIGN  这是基本数据；类型需要的
    objc_setAssociatedObject(self, &indexPathKey, indexPath,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
