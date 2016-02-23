//
//  TSNewManager.h
//  part time job
//
//  Created by 晨 on 16/2/20.
//  Copyright (c) 2016年 TS. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import <AFNetworkReachabilityManager.h>
@interface TSNetManager : AFHTTPSessionManager

+(void)postWithParam:(NSDictionary *)params andPath:(NSString *)path andComplete:(void(^)(BOOL success,id result))complete;
+(void)getWithParam:(NSDictionary *)params andPath:(NSString *)path andComplete:(void(^)(BOOL success,id result))complete;

@end
