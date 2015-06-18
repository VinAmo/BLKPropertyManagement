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

+ (void)setCookies {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults stringForKey:@"token"];
    NSString *rolePermissionPkno = [userDefaults stringForKey:@"rolePermissionPkno"];
    NSString *permissionsPkno = [userDefaults stringForKey:@"permissionsPkno"];
    NSString *userPkno = [userDefaults stringForKey:@"userPkno"];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *cookieDomain = delegate.servicePort;
    NSString *cookiePath = @"/";
    
    NSDictionary *properties_1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"token", NSHTTPCookieName,
                                  token, NSHTTPCookieValue,
                                  cookieDomain, NSHTTPCookieDomain,
                                  cookiePath, NSHTTPCookiePath,
                                  nil];
    NSDictionary *properties_2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"rolePermissionPkno", NSHTTPCookieName,
                                  rolePermissionPkno, NSHTTPCookieValue,
                                  cookieDomain, NSHTTPCookieDomain,
                                  cookiePath, NSHTTPCookiePath,
                                  nil];
    NSDictionary *properties_3 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"rolePermission", NSHTTPCookieName,
                                  permissionsPkno, NSHTTPCookieValue,
                                  cookieDomain, NSHTTPCookieDomain,
                                  cookiePath, NSHTTPCookiePath,
                                  nil];
    NSDictionary *properties_4 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"userPkno", NSHTTPCookieName,
                                  userPkno, NSHTTPCookieValue,
                                  cookieDomain, NSHTTPCookieDomain,
                                  cookiePath, NSHTTPCookiePath,
                                  nil];
    
    NSHTTPCookie *cookie_1 = [NSHTTPCookie cookieWithProperties:properties_1];
    NSHTTPCookie *cookie_2 = [NSHTTPCookie cookieWithProperties:properties_2];
    NSHTTPCookie *cookie_3 = [NSHTTPCookie cookieWithProperties:properties_3];
    NSHTTPCookie *cookie_4 = [NSHTTPCookie cookieWithProperties:properties_4];
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie_1];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie_2];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie_3];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie_4];
    
    //    [[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    //        NSLog(@"Cookie :%@\n", obj);
    //    }];
}

+ (void)deleteCookies {
    [[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:obj];
    }];
    
}

+ (void)fetchRepairReportFilterMessages:(void (^)(id))callback {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *urlStr = [delegate.servicePort stringByAppendingPathComponent:@"APPRepair/repairState.do"];
    NSDictionary *parameters = @{  };
    [[AFHTTPSessionManager manager] POST:urlStr parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        callback(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

+ (void)fetchFeedbackFilterMessages:(void (^)(id))callback {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *urlStr = [delegate.servicePort stringByAppendingPathComponent:@"AppFeedBack/findFeedBackCategory.do"];
    NSDictionary *parameters = @{  };
    [[AFHTTPSessionManager manager] POST:urlStr parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        callback(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

+ (void)fetchCommunityNoticeMessages:(void (^)(id))callback withPage:(NSUInteger)page size:(NSUInteger)size {
//    [[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSLog(@"Cookie :%@\n", obj);
//    }];
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *urlStr = [delegate.servicePort stringByAppendingPathComponent:@"AppNotice/findNoticeBySearch.do"];
    NSDictionary *parameters = @{ @"page": @(page), @"pagesize": @(size), @"Category": @"小区公告", @"typeCode": @"1001" };
    [[AFHTTPSessionManager manager] POST:urlStr parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        callback(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
    
//    NSString *parameters = [NSString stringWithFormat:@"Category=小区公告&typeCode=1001&page=%lu&pagesize=%lu", page, size];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[parameters dataUsingEncoding:NSUTF8StringEncoding]];
//
//    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        if (error) {
//            NSLog(@"Session failed: %@", error);
//        }
//        else {
//            NSError *parseError;
//            id root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
//            if (parseError) {
//                NSLog(@"Error parsing JSON: %@", parseError);
//            }
//            else {
//                callback(root);
//            }
//        }
//    }];
//    [task resume];
}

+ (void)fetchRepairReportMessages:(void (^)(id))callback withPage:(NSUInteger)page size:(NSUInteger)size category:(NSString *)category state:(NSString *)state {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *urlStr = [delegate.servicePort stringByAppendingPathComponent:@"APPRepair/findRepairBySearch.do"];
    NSDictionary *parameters = @{ @"page": @(page), @"pagesize": @(size), @"category": category, @"state": state };
    [[AFHTTPSessionManager manager] POST:urlStr parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        callback(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

+ (void)fetchMaintenanceMessages:(void (^)(id))callback withPage:(NSUInteger)page size:(NSUInteger)size category:(NSString *)category state:(NSString *)state {
    [HTTPDataFetcher fetchRepairReportMessages:callback withPage:page size:size category:category state:@"PROCESS"];
}

+ (void)fetchFeedbackMessages:(void (^)(id))callback withPage:(NSUInteger)page size:(NSUInteger)size category:(NSString *)category person:(NSString *)person {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *urlStr = [delegate.servicePort stringByAppendingPathComponent:@"AppFeedBack/findFeedbackBySearch.do"];
    NSDictionary *parameters = @{ @"page": @(page), @"pagesize": @(size), @"typeCode": category, @"ownerName": person };
    [[AFHTTPSessionManager manager] POST:urlStr parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        callback(responseObject);NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

+ (void)fetchRepairReportConfirmMessages:(void (^)(id))callback withReportIdentifier:(NSString *)identifier content:(NSString *)content time:(NSString *)time {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *urlStr = [delegate.servicePort stringByAppendingPathComponent:@"APPRepair/completeRepairByPkno.do"];
    NSDictionary *parameters = @{ @"repairPkno": identifier, @"maintenanceDescribe": content, @"completeTime": time };
    [[AFHTTPSessionManager manager] POST:urlStr parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        callback(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

+ (void)fetchRepairReportCancelMessages:(void (^)(id))callback withReportIdentifier:(NSString *)identifier {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *urlStr = [delegate.servicePort stringByAppendingPathComponent:@"APPRepair/findRepairBySearch.do"];
    NSDictionary *parameters = @{ @"repairPkno": identifier };
    [[AFHTTPSessionManager manager] POST:urlStr parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        callback(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
