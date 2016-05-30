//
//  MBNetWorkTool.m
//  MobileStation
//
//  Created by DS365 on 16/5/23.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import "MBNetWorkTool.h"

@implementation MBNetWorkTool

+ (instancetype)sharedNetworkTools {
    static MBNetWorkTool *Networktools;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Networktools=[[MBNetWorkTool alloc]init];
        Networktools.responseSerializer=[AFJSONResponseSerializer serializer];
            });
    return Networktools;
}

-(NSURLSessionDataTask *)makeGetRequestwithParameters:(NSMutableDictionary *)dictionary success:(void (^)(NSDictionary *results))success fail:(void (^)(NSDictionary *results))fail error:(void (^)(NSError *results))errorfail
{
//    [self.requestSerializer  setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionDataTask * task=[self GET:@"http://106.120.74.204:6688/ios/msg.aspx" parameters:dictionary success:^(NSURLSessionDataTask *task, NSDictionary * responseObject) {
        NSLog(@"%@",responseObject);
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        if (httpResponse.statusCode == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([responseObject[@"resultcode"] intValue]==200) {
                    success(responseObject);
                }else{
                    fail(responseObject);
                }
                
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                errorfail(nil);
            });
            NSLog(@"Received: %@", responseObject);
            NSLog(@"Received HTTP %tu", httpResponse.statusCode);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            errorfail(error);
        });
    }];
    return task;
}
@end
