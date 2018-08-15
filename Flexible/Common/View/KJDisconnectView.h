//
//  KJDisconnectView.h
//  HealthStation
//
//  Created by apple on 2017/4/7.
//  Copyright © 2017年 jiankangzhan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^KJRetryToConnectBlock)(void);

@interface KJDisconnectView : UIView

@property (nonatomic, copy) KJRetryToConnectBlock retryConnectBlock;

@end
