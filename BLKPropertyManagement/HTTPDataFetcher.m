//
//  HTTPDataFetcher.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/10.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "AppDelegate.h"
#import "HTTPDataFetcher.h"

@implementation HTTPDataFetcher

- (void)fetchCommunityNoticeMessages:(void (^)(id))callback AtPage:(NSUInteger)page WithSize:(NSUInteger)size {
    //    [[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    //        NSLog(@"Cookie :%@\n", obj);
    //    }];
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *urlStr = [delegate.servicePort stringByAppendingPathComponent:@"AppNotice/findNoticeBySearch.do"];
    NSString *param = [NSString stringWithFormat:@"Category=小区公告&typeCode=1001&page=%lu&pagesize=%lu", page, size];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Session failed: %@", error);
        }
        else {
            NSError *parseError;
            id root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
            if (parseError) {
                NSLog(@"Error parsing JSON: %@", parseError);
            }
            else {
                callback(root);
            }
        }
    }];
    [task resume];
}

- (void)fetchRepairRoportMessages:(void (^)(id))callback AtPage:(NSUInteger)page withSize:(NSUInteger)size {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *urlStr = [delegate.servicePort stringByAppendingPathComponent:@"APPRepair/findRepairBySearch.do"];
    NSDictionary *param = @{ @"state" : @"PROCESS", @"page" : @(page), @"pagesize": @(size) };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:urlStr parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        callback(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)fetchMaintenanceMessages:(void (^)(id))callback AtPage:(NSUInteger)page withSize:(NSUInteger)size {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *urlStr = [delegate.servicePort stringByAppendingPathComponent:@"APPRepair/findRepairBySearch.do"];
    NSDictionary *param = @{ @"page" : @(page), @"pagesize": @(size) };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:urlStr parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        callback(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];}

- (void)fetchFeedbackMessages:(void (^)(id))callback AtPage:(NSUInteger)page WithSize:(NSUInteger)size {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *urlStr = [delegate.servicePort stringByAppendingPathComponent:@"AppFeedBack/findFeedbackBySearch.do"];
    NSDictionary *param = @{ @"page" : @(page), @"pagesize": @(size) };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:urlStr parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        callback(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
