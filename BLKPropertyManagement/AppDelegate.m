//
//  AppDelegate.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/4.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SignInViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _window = [[UIWindow alloc] init];
    _window.frame = [[UIScreen mainScreen] bounds];
    
    ViewController *mainViewController = [[ViewController alloc] init];
    SignInViewController *signInViewController = [[SignInViewController alloc] init];
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"access"]) {
        _navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    }
    else {
        _navigationController = [[UINavigationController alloc] initWithRootViewController:signInViewController];
        [_navigationController setNavigationBarHidden:YES];
    }
    _window.rootViewController = _navigationController;
    [_window makeKeyAndVisible];
    
    _servicePort = @"http://99b82737.ngrok.io/community_business";
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES]; // try
    [self setCookies];
    
    return YES;
}

- (void)setCookies {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *rolePermissionPkno = [userDefaults stringForKey:@"rolePermissionPkno"];
    NSString *permissionsPkno = [userDefaults stringForKey:@"permissionsPkno"];
    NSString *userPkno = [userDefaults stringForKey:@"userPkno"];
    NSString *cookieDomain = self.servicePort;
    NSString *cookiePath = @"AppNotice/findNoticeBySearch.do";
    
    NSDictionary *properties_1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"rolePermissionPkno", NSHTTPCookieName,
                                  rolePermissionPkno, NSHTTPCookieValue,
                                  cookieDomain, NSHTTPCookieDomain,
                                  cookiePath, NSHTTPCookiePath,
                                  nil];
    NSDictionary *properties_2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"rolePermission", NSHTTPCookieName,
                                  permissionsPkno, NSHTTPCookieValue,
                                  cookieDomain, NSHTTPCookieDomain,
                                  cookiePath, NSHTTPCookiePath,
                                  nil];
    NSDictionary *properties_3 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"userPkno", NSHTTPCookieName,
                                  userPkno, NSHTTPCookieValue,
                                  cookieDomain, NSHTTPCookieDomain,
                                  cookiePath, NSHTTPCookiePath,
                                  nil];
    
    NSHTTPCookie *cookie_1 = [NSHTTPCookie cookieWithProperties:properties_1];
    NSHTTPCookie *cookie_2 = [NSHTTPCookie cookieWithProperties:properties_2];
    NSHTTPCookie *cookie_3 = [NSHTTPCookie cookieWithProperties:properties_3];
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie_1];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie_2];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie_3];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
