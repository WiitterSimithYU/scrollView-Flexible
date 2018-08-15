//
//  KJRequestManger.m
//  HealthStation
//
//  Created by apple on 2017/2/27.
//  Copyright © 2017年 jiankangzhan. All rights reserved.
//

#import "KJRequestManger.h"

@interface KJRequestManger ()

@property (nonatomic, strong) AFHTTPSessionManager * manager;

@end

@implementation KJRequestManger

static KJRequestManger * gThis = nil;

+ (KJRequestManger *)instance {
    if ( gThis == nil ){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            gThis = [[KJRequestManger alloc] init];
        });
    }
    return gThis;
}

- (instancetype)init {
    
    if(self = [super init]) {
        
        _manager = [AFHTTPSessionManager manager];
    
        //设置请求类型
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.requestSerializer.timeoutInterval = 10.f;
        
        //设置响应类型
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
    }
    return self;
}

// 取消所有请求
- (void)cancelAllRequest {
    [_manager.operationQueue cancelAllOperations];
}

// get请求
- (void)requestGetWithUrl:(NSString *)url paramenters:(NSArray *)params success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    for (int i = 0; i < params.count; i++) {
        
        NSString *path = params[i];
        url = [url stringByAppendingPathComponent:path];
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [_manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 统一成功处理
        [self handleRequestSuccess:responseObject];
        
        // 成功回调
        if (success) success(task, responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 统一失败处理
        [self handleRequestError:error];
        
        // 失败回调
        if (failure) failure(task, error);
    }];
}

// post请求
- (void)requestPostWithUrl:(NSString *)url paramenters:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure {

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [_manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        // 统一处理请求成功
        [self handleRequestSuccess:responseObject];

        // 成功
        if (success) success(task, responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        // 统一失败处理
        [self handleRequestError:error];
        
        // 失败回调
        if (failure) failure(task, error);
    }];
}


// 上传单张图片
- (void)uploadWithUrl:(NSString *)url imageData:(NSData *)imageData paramenters:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [_manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
        // 要解决此问题，
        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";   // 设置时间格式
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        //将得到的二进制图片拼接到表单中 /** data,指定上传的二进制流;name,服务器端所需参数名*/
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:nil success:success failure:failure];
}

// 上传多张图片
- (void)uploadWithUrl:(NSString *)url imageDataArray:(NSArray *)imageDataArray paramenters:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [_manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i<imageDataArray.count; i++){
            
            NSData *imageData = imageDataArray[i];
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            NSString *name = [NSString stringWithFormat:@"image_%d.png",i ];
            
            //将得到的二进制图片拼接到表单中 /** data,指定上传的二进制流;name,服务器端所需参数名*/
            [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/png"];
        }
    } progress:nil success:success failure:failure];
}

// 上传文件
- (void)uploadWithUrl:(NSString *)url fileData:(NSData *)fileData paramenters:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [_manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //将得到的二进制数据拼接到表单中 /** data,指定上传的二进制流;name,服务器端所需参数名*/
        [formData appendPartWithFileData :fileData name:@"file" fileName:@"audio.MP3" mimeType:@"audio/MP3"];
    } progress:nil success:success failure:failure];
    
}

// JSON转换成字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) return nil;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) return nil;
    
    return dic;
}

/*******************统一处理htttp请求成功/失败************************/
- (void) handleRequestSuccess:(id)responseObject {
    
    [[KJProgressHUD instance] hideHUD];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    // 服务异常界面
    sendNotification(kServiceErrorNotify);
}

- (void)handleRequestError:(NSError *)error {
    
    NSLog(@"KJError:%@",error);
    
    [[KJProgressHUD instance] hideHUD];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    // 服务异常界面
    sendNotification(kServiceErrorNotify);
}
/*******************统一处理htttp请求成功/失败************************/


@end
