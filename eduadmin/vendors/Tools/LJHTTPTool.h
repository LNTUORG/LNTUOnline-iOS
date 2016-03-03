//
//  LJHTTPTool.h
//
//  Created by Li Jie on 14-9-17.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPRequestOperation;
@class AFHTTPSessionManager;

@interface LJHTTPTool : NSObject

/**
 *  发送一个POST JSON请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postJSONWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseJSON))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST HTTP请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postHTTPWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseHTTP))success failure:(void (^)(NSError *error))failure;


/**
 *  发送一个GETJSON请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getJSONWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseJSON))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  发送一个GET HTTP请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getHTTPWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseHTTP))success failure:(void (^)(NSError *error))failure;

@end
