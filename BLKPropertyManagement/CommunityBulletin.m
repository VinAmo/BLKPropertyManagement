//
//  CommunityBulletin.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/5.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "AppDelegate.h"
#import "CommunityBulletin.h"

@implementation CommunityBulletin

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *rolePermissionPkno = [userDefaults stringForKey:@"rolePermissionPkno"];
    NSString *permissionsPkno = [userDefaults stringForKey:@"permissionsPkno"];
    NSString *userPkno = [userDefaults stringForKey:@"userPkno"];
    
    NSDictionary *properties_1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"rolePermissionPkno", NSHTTPCookieName,
                                  rolePermissionPkno, NSHTTPCookieValue,
                                  "99b82737.ngrok.io", NSHTTPCookieDomain,
                                  "/community_business", NSHTTPCookiePath,
                                  nil];
    NSDictionary *properties_2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"rolePermission", NSHTTPCookieName,
                                  permissionsPkno, NSHTTPCookieValue,
                                  "99b82737.ngrok.io", NSHTTPCookieDomain,
                                  "/community_business", NSHTTPCookiePath,
                                  nil];
    NSDictionary *properties_3 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"userPkno", NSHTTPCookieName,
                                  userPkno, NSHTTPCookieValue,
                                  "99b82737.ngrok.io", NSHTTPCookieDomain,
                                  "/community_business", NSHTTPCookiePath,
                                  nil];
    
    NSHTTPCookie *cookie_1 = [NSHTTPCookie cookieWithProperties:properties_1];
    NSHTTPCookie *cookie_2 = [NSHTTPCookie cookieWithProperties:properties_2];
    NSHTTPCookie *cookie_3 = [NSHTTPCookie cookieWithProperties:properties_3];
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie_1];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie_2];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie_3];
    
    [[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"New cookie :%@\n", obj);
    }];
    
    NSString *page = @"10";
    NSString *urlStr = [delegate.servicePort stringByAppendingPathComponent:@"AppNotice/findNoticeBySearch.do"];
    NSString *param = [NSString stringWithFormat:@"pagesize=10&page=%@&Category=小区公告&typeCode=1001", page];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue new]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               NSError *error = nil;
                               NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                               if (error) {
                                   NSLog(@"Error parsing JSON: %@", error);
                                }
                               else {
                                   NSLog(@"%@", rootDic);
                               }
                            }];
}

@end
