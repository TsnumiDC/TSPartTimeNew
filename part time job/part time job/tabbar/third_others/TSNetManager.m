//
//  TSNewManager.m
//  part time job
//
//  Created by 晨 on 16/2/20.
//  Copyright (c) 2016年 TS. All rights reserved.
//

#import "TSNetManager.h"

@implementation TSNetManager

+(AFHTTPSessionManager *)sharedSessionMagager
{
    static AFHTTPSessionManager * sharedSessionManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL * mainUrl=[NSURL URLWithString:MainAPI];
        sharedSessionManager=[[super allocWithZone:NULL]initWithBaseURL:mainUrl];
        
        sharedSessionManager.requestSerializer=[AFHTTPRequestSerializer serializer];
        sharedSessionManager.requestSerializer.timeoutInterval=30;
        
        sharedSessionManager.responseSerializer=[AFHTTPResponseSerializer serializer];
        sharedSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    });
    return sharedSessionManager;
}

+(void)postWithParam:(NSDictionary *)params andPath:(NSString *)path andComplete:(void(^)(BOOL success,id result))complete
{
    [[self sharedSessionMagager]POST:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject)
    {
        BOOL success=YES;
        id result;
        
        NSString * resultString=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        if ([resultString isEqual:@"0"]) {
            success=NO;
            result=@"链接服务器成功，登录失败";
        }
        else
        {
            result=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        complete(success,result);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        BOOL success=NO;
        id result=error.localizedDescription;
        complete(success,result);
    }];
}
+(void)getWithParam:(NSDictionary *)params andPath:(NSString *)path andComplete:(void(^)(BOOL success,id result))complete
{
    [[self sharedSessionMagager]GET:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject)
    {
        complete(YES,responseObject);
        
    }
      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        BOOL success=NO;
        id result=error.localizedDescription;
        complete(success,result);
    }];
}
//当没有网络的时候，必须给出提示
-(void)isReachToWeb
{
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"为知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WLAN网络");
                break;
                
            default:
                break;
        }
        
    }];
}
@end
