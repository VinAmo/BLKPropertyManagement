//
//  AppDelegate.h
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/4.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFHTTPSessionManager.h>
#import <AFNetworkActivityIndicatorManager.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;

@property NSString *servicePort;

@end

