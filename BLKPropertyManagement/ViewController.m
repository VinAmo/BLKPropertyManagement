//
//  ViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/4.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "ViewController.h"
#import "AccountViewController.h"
#import "CommunityNoticeViewController.h"
#import "RepairReportManagementViewController.h"
#import "MaintenanceManagementViewController.h"
#import "FeedbackViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"物业管理";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"账户" style:UIBarButtonItemStylePlain target:self action:@selector(showAccountViewController)];
    
    UIButton *communityNoticeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    communityNoticeButton.frame = CGRectMake(0, 0, 40, 40);
    communityNoticeButton.center = CGPointMake(self.view.center.x - 60, 300);
    [communityNoticeButton setBackgroundImage:[UIImage imageNamed:@"icon_notice"] forState:UIControlStateNormal];
    [communityNoticeButton addTarget:self action:@selector(showCommunityNoticeViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:communityNoticeButton];
    
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
    
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"access"];
}

- (void)showAccountViewController {
    [self.navigationController pushViewController:[[AccountViewController alloc] init] animated:YES];
}

- (void)showCommunityNoticeViewController {
    [self.navigationController pushViewController:[[CommunityNoticeViewController alloc] init] animated:YES];
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

@end
