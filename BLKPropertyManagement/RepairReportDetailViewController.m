//
//  RepairReportDetailViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/4.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "RepairReportDetailViewController.h"

@interface RepairReportDetailViewController ()

@end

@implementation RepairReportDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"报修详情";
    
    self.view = [[UIView alloc] init];
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFont:[UIFont fontWithName:nil size:20]];
    [self.view addSubview:titleLabel];
    
    UILabel *housingTypeLabel = [[UILabel alloc] init];
    housingTypeLabel.text = @"房屋类型：";
    [self.view addSubview:housingTypeLabel];
    
    UILabel *buildingNumberLabel = [[UILabel alloc] init];
    buildingNumberLabel.text = @"楼栋：";
    [self.view addSubview:buildingNumberLabel];
    
    UILabel *reporterLabel = [[UILabel alloc] init];
    reporterLabel.text = @"报修人：";
    [self.view addSubview:reporterLabel];
    
    UILabel *scheduleTimeLabel = [[UILabel alloc] init];
    scheduleTimeLabel.text = @"预约时间：";
    [self.view addSubview:scheduleTimeLabel];
    
    UILabel *phoneNumberLabel = [[UILabel alloc] init];
    phoneNumberLabel.text = @"联系电话：";
    [self.view addSubview:phoneNumberLabel];
    
    titleLabel.frame = CGRectMake(20, 0, self.view.bounds.size.width - 20, self.view.bounds.size.height * 0.1);
    housingTypeLabel.frame = CGRectMake(20, CGRectGetMaxY(titleLabel.frame), self.view.bounds.size.width - 20, self.view.bounds.size.height * 0.1);
    buildingNumberLabel.frame = CGRectMake(20, CGRectGetMaxY(housingTypeLabel.frame), self.view.bounds.size.width - 20, self.view.bounds.size.height * 0.1);
    reporterLabel.frame = CGRectMake(20, CGRectGetMaxY(buildingNumberLabel.frame), self.view.bounds.size.width - 20, self.view.bounds.size.height * 0.1);
    scheduleTimeLabel.frame = CGRectMake(20, CGRectGetMaxY(reporterLabel.frame), self.view.bounds.size.width - 20, self.view.bounds.size.height * 0.1);
    phoneNumberLabel.frame = CGRectMake(20, CGRectGetMaxY(scheduleTimeLabel.frame), self.view.bounds.size.width - 20, self.view.bounds.size.height * 0.1);
}

@end
