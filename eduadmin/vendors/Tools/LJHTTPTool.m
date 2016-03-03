//
//  LJHTTPTool.m
//
//  Created by Li Jie on 14-9-17.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "LJHTTPTool.h"
#import "Common.h"
#import "LJDeviceTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+LJ.h"

AFHTTPSessionManager *_mgr;

@implementation LJHTTPTool

+ (void)postJSONWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    // 1.创建请求管理对象
    if (!_mgr) {
        
        _mgr = [AFHTTPSessionManager manager];
    }
    
    if (TOKENFORNET) {
        
        [_mgr.requestSerializer setValue:TOKENFORNET forHTTPHeaderField:@"Authorization"];
    }
    
    [_mgr.requestSerializer setValue:[NSString stringWithFormat:@"eduadmin/%@ (%@; iOS%@)", [LJDeviceTool getCurrentAppVersion], [LJDeviceTool getCurrentDeviceModel], [LJDeviceTool getCurrentSystemVersion]] forHTTPHeaderField:@"User-Agent"];
    
    [_mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        if (failure) {
            
            failure(error);
            if ([(NSHTTPURLResponse *)task.response statusCode] == 401) {
                
                [MBProgressHUD showError:@"授权已经过期，重新登陆可以解决"];
            }
            if ([(NSHTTPURLResponse *)task.response statusCode] == 400) {
                
                [MBProgressHUD showError:@"用户名密码错误"];
                
            } else {
                
                [MBProgressHUD showError:ERRORSTR];
            }
        }
    }];
}

+ (void)postHTTPWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    // 1.创建请求管理对象
    if (!_mgr) {
        
        _mgr = [AFHTTPSessionManager manager];
    }
    
    if (TOKENFORNET) {
        
        [_mgr.requestSerializer setValue:TOKENFORNET forHTTPHeaderField:@"Authorization"];
    }
    
    [_mgr.requestSerializer setValue:[NSString stringWithFormat:@"eduadmin/%@ (%@; iOS%@)", [LJDeviceTool getCurrentAppVersion], [LJDeviceTool getCurrentDeviceModel], [LJDeviceTool getCurrentSystemVersion]] forHTTPHeaderField:@"User-Agent"];
    
    _mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [_mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
            if ([(NSHTTPURLResponse *)task.response statusCode] == 401) {
                
                [MBProgressHUD showError:@"授权已经过期，重新登陆可以解决"];
                
            } else {
                
                [MBProgressHUD showError:ERRORSTR];
            }
        }
    }];
}


+ (void)getJSONWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSURLSessionDataTask *task, NSError *))failure {
    
    // 1.创建请求管理对象
    if (!_mgr) {
        
        _mgr = [AFHTTPSessionManager manager];
    }
    
    if (TOKENFORNET) {
        
        [_mgr.requestSerializer setValue:TOKENFORNET forHTTPHeaderField:@"Authorization"];
    }
    
    [_mgr.requestSerializer setValue:[NSString stringWithFormat:@"eduadmin/%@ (%@; iOS%@)", [LJDeviceTool getCurrentAppVersion], [LJDeviceTool getCurrentDeviceModel], [LJDeviceTool getCurrentSystemVersion]] forHTTPHeaderField:@"User-Agent"];
    
    [_mgr GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(task, error);
            
            if ([(NSHTTPURLResponse *)task.response statusCode] == 401) {
                
                [MBProgressHUD showError:@"授权已经过期，重新登陆可以解决"];
                
            } else {
                
                [MBProgressHUD showError:ERRORSTR];
            }
        }
    }];
}

+ (void)getHTTPWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    // 1.创建请求管理对象
    if (!_mgr) {
        
        _mgr = [AFHTTPSessionManager manager];
    }
    
    if (TOKENFORNET) {
        
        [_mgr.requestSerializer setValue:TOKENFORNET forHTTPHeaderField:@"Authorization"];
    }
    
    [_mgr.requestSerializer setValue:[NSString stringWithFormat:@"eduadmin/%@ (%@; iOS%@)", [LJDeviceTool getCurrentAppVersion], [LJDeviceTool getCurrentDeviceModel], [LJDeviceTool getCurrentSystemVersion]] forHTTPHeaderField:@"User-Agent"];
    
    _mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [_mgr GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
            
            if ([(NSHTTPURLResponse *)task.response statusCode] == 401) {
                
                [MBProgressHUD showError:@"授权已经过期，重新登陆可以解决"];
                
            } else {
                
                [MBProgressHUD showError:ERRORSTR];
            }
        }
    }];
}

@end
