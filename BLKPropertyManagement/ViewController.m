//
//  ViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/4.
//  Copyright (c) 2015年 BLK. All rights reserved.
//
#import <AFNetworking.h>
#import "AppDelegate.h"
#import "ViewController.h"
#import "CommunityBulletinViewController.h"
#import "RepairReportManagementViewController.h"
#import "MaintenanceManagementViewController.h"
#import "FeedbackViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"物业管理";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *communityBulletinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    communityBulletinButton.frame = CGRectMake(0, 0, 40, 40);
    communityBulletinButton.center = CGPointMake(self.view.center.x - 60, 300);
    [communityBulletinButton setBackgroundImage:[UIImage imageNamed:@"icon_bulletin"] forState:UIControlStateNormal];
    [communityBulletinButton addTarget:self action:@selector(showCommunityBulletinViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:communityBulletinButton];
    
    UIButton *repairReportManagementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    repairReportManagementButton.frame = CGRectMake(0, 0, 40, 40);
    repairReportManagementButton.center = CGPointMake(self.view.center.x + 60, 300);
    [repairReportManagementButton setBackgroundImage:[UIImage imageNamed:@"icon_repair"] forState:UIControlStateNormal];
    [repairReportManagementButton addTarget:self action:@selector(showRepairManagementViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:repairReportManagementButton];
    
    UIButton *maintenanceManagementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    maintenanceManagementButton.frame = CGRectMake(0, 0, 40, 40);
    maintenanceManagementButton.center = CGPointMake(self.view.center.x - 60, 400);
    [maintenanceManagementButton setBackgroundImage:[UIImage imageNamed:@"icon_maintain"] forState:UIControlStateNormal];
    [maintenanceManagementButton addTarget:self action:@selector(showMaintenanceManagementViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:maintenanceManagementButton];
    
    UIButton *feedbackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    feedbackButton.frame = CGRectMake(0, 0, 40, 40);
    feedbackButton.center = CGPointMake(self.view.center.x + 60, 400);
    [feedbackButton setBackgroundImage:[UIImage imageNamed:@"icon_feedback"] forState:UIControlStateNormal];
    [feedbackButton addTarget:self action:@selector(showFeedbackViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:feedbackButton];
    
    [self signIn];
}

- (void)showCommunityBulletinViewController {
    [self.navigationController pushViewController:[[CommunityBulletinViewController alloc] init] animated:YES];
}

- (void)showRepairManagementViewController {
    [self.navigationController pushViewController:[[RepairReportManagementViewController alloc] init] animated:YES];
}

- (void)showMaintenanceManagementViewController {
    [self.navigationController pushViewController:[[MaintenanceManagementViewController alloc] init] animated:YES];
}

- (void)showFeedbackViewController {
    [self.navigationController pushViewController:[[FeedbackViewController alloc] init] animated:YES];
}

- (void)signIn {
    NSData *userName = [@"super" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encodedUserName = [userName base64EncodedStringWithOptions:0];
    
    NSData *userPassword = [@"888888" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encodedUserPassord = [userPassword base64EncodedStringWithOptions:0];
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *urlStr = [delegate.servicePort stringByAppendingPathComponent:@"AppLogin/login.do"];
    NSString *param = [NSString stringWithFormat:@"loginName=%@&loginPwd=%@", encodedUserName, encodedUserPassord];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *params = @{ @"loginName": encodedUserName, @"loginPwd": encodedUserPassord};
//    [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
    
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
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
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            // back to main thread
            
        });
    }];
}

@end
