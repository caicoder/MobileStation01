//
//  MBNetWorkTool.h
//  MobileStation
//
//  Created by DS365 on 16/5/23.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "AFNetworking.h"

@interface MBNetWorkTool : AFHTTPSessionManager
+ (instancetype)sharedNetworkTools;

-(NSURLSessionDataTask *)makeGetRequestwithParameters:(NSMutableDictionary *)dictionary success:(void (^)(NSDictionary *results))success fail:(void (^)(NSDictionary *results))fail error:(void (^)(NSError *results))errorfail;
@end
