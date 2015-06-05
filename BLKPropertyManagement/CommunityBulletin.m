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
        [self fetchData];
    }
    return self;
}

- (void)fetchData {
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *urlStr = [delegate.servicePort stringByAppendingPathComponent:@"AppNotice/findNoticeBySearch.do"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue new]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *error = nil;
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (!rootDic) {
           NSLog(@"Error parsing JSON: %@", error);
        }
        else {
           NSLog(@"%@", rootDic);
           self.content = @"停水通知";
        }
    }];
}

@end
