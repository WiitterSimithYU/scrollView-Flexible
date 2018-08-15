//
//  KJRequestManger.h
//  HealthStation
//
//  Created by apple on 2017/2/27.
//  Copyright © 2017年 jiankangzhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

// 请求类型
typedef NS_ENUM(NSInteger,HttpRequestType) {
    HttpRequestGet,
    HttpRequestPost,
    HttpRequestPut,
    HttpRequestDelete
};

// 成功回调
typedef void(^SuccessBlock)(NSURLSessionDataTask * task, id responseObject);

// 失败回调
typedef void(^FailureBlock)(NSURLSessionDataTask * task, NSError * error);


@interface KJRequestManger : NSObject

// 单例
+ (KJRequestManger *)instance;

/*******************htttp请求方法************************/
// 取消所有请求
- (void)cancelAllRequest;

// GET
- (void)requestGetWithUrl:(NSString *)url paramenters:(NSArray *)params success:(SuccessBlock)success failure:(FailureBlock)failure;

// POST
- (void)requestPostWithUrl:(NSString *)url paramenters:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure;

// 上传单张图片
- (void)uploadWithUrl:(NSString *)url imageData:(NSData *)imageData paramenters:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure;

// 上传多张图片
- (void)uploadWithUrl:(NSString *)url imageDataArray:(NSArray *)imageDataArray paramenters:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure;

// 上传文件
- (void)uploadWithUrl:(NSString *)url fileData:(NSData *)fileData paramenters:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure;

/*******************htttp请求状态************************/

+ (BOOL)responseOK:(NSDictionary *)dict;

+ (BOOL)requestNoMoreData:(NSDictionary *)dict;

/*******************处理htttp请求错误************************/
+ (void)handleResponseError:(NSDictionary *)dict;

// JSON转换成字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
