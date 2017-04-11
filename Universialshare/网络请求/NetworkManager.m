//
//  NetworkManager.m
//  PovertyAlleviation
//
//  Created by 四川三君科技有限公司 on 2017/2/27.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetworking.h"


@implementation NetworkManager
// 参数urlStr表示网络请求url,paramDic表示请求参数,finish回调指网络请求成功回调,enError表示回调失败.

+ (void)requestGETWithURLStr:(NSString *)urlStr paramDic:(NSDictionary *)paramDic finish:(void(^)(id responseObject)) finish enError:(void(^)(NSError *error))enError {
    // 创建一个SessionManager管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 指定我们能够解析的数据类型包含html.支持返回类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    // AFNetworking请求结果回调时,failure方法会在两种情况下回调:1.请求服务器失败,服务器返回失败信息;2.服务器返回数据成功,AFN解析返回的数据失败.
    [manager GET:urlStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        enError(error);
    }];
    
}

+ (void)requestPOSTWithURLStr:(NSString *)urlStr paramDic:(NSDictionary *)paramDic finish:(void(^)(id responseObject)) finish enError:(void(^)(NSError *error))enError {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"application/json",nil];
    
    manager.requestSerializer.timeoutInterval=10;
    
    
    NSString *urlStr1 = [NSString stringWithFormat:@"%@%@",URL_Base,urlStr];
    
    [manager POST:urlStr1 parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        enError(error);
    }];
    
}
//没有延迟时间
+ (void)requestPOSTWithURLStrundelay:(NSString *)urlStr paramDic:(NSDictionary *)paramDic finish:(void(^)(id responseObject)) finish enError:(void(^)(NSError *error))enError {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer.timeoutInterval=10;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"application/json",nil];
    
    NSString *urlStr1 = [NSString stringWithFormat:@"%@%@",URL_Base,urlStr];
    
    
    [manager POST:urlStr1 parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        enError(error);
    }];
    
}

+ (NSURLSessionDataTask*)requestGETWithURLStrReture:(NSString *)urlStr paramDic:(NSDictionary *)paramDic finish:(void(^)(id responseObject)) finish enError:(void(^)(NSError *error))enError {
    // 创建一个SessionManager管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 指定我们能够解析的数据类型包含html.支持返回类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    // AFNetworking请求结果回调时,failure方法会在两种情况下回调:1.请求服务器失败,服务器返回失败信息;2.服务器返回数据成功,AFN解析返回的数据失败.
    NSURLSessionDataTask *task= [manager GET:urlStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        enError(error);
    }];
    return task;
}

+ (NSURLSessionDataTask*)requestPOSTWithURLStrReture:(NSString *)urlStr paramDic:(NSDictionary *)paramDic finish:(void(^)(id responseObject)) finish enError:(void(^)(NSError *error))enError {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"application/json",nil];
    
    manager.requestSerializer.timeoutInterval=10;
    
    
    NSString *urlStr1 = [NSString stringWithFormat:@"%@%@",URL_Base,urlStr];
    
    
    NSURLSessionDataTask *task= [manager POST:urlStr1 parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        enError(error);
    }];
    
    return task;
}

@end

