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
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view = [[UIView alloc] init];
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *typeLabel = [[UILabel alloc] init];
    typeLabel.text = @"类型：";
    [self.view addSubview:typeLabel];
    
    UILabel *buildingNumberLabel = [[UILabel alloc] init];
    buildingNumberLabel.text = @"楼栋：";
    [self.view addSubview:buildingNumberLabel];
    
    UILabel *reporterLabel = [[UILabel alloc] init];
    reporterLabel.text = @"报修人：";
    [self.view addSubview:reporterLabel];
    
    UILabel *reportContentLabel = [[UILabel alloc] init];
    reportContentLabel.text = @"报修原因：";
    reportContentLabel.numberOfLines = 0;
    reportContentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.view addSubview:reportContentLabel];
    
    UILabel *reportTimeLabel = [[UILabel alloc] init];
    reportTimeLabel.text = @"报修时间：";
    [self.view addSubview:reportTimeLabel];
    
    UILabel *phoneNumberLabel = [[UILabel alloc] init];
    phoneNumberLabel.text = @"联系电话：";
    [self.view addSubview:phoneNumberLabel];
    
    typeLabel.frame = CGRectMake(20, 20, self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    buildingNumberLabel.frame = CGRectMake(20, CGRectGetMaxY(typeLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    reporterLabel.frame = CGRectMake(20, CGRectGetMaxY(buildingNumberLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    reportTimeLabel.frame = CGRectMake(20, CGRectGetMaxY(reporterLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    phoneNumberLabel.frame = CGRectMake(20, CGRectGetMaxY(reportTimeLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    reportContentLabel.frame = CGRectMake(20, CGRectGetMaxY(phoneNumberLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.1);
    
    typeLabel.text = [typeLabel.text stringByAppendingString:self.message.type];
    buildingNumberLabel.text = [buildingNumberLabel.text stringByAppendingString:self.message.buildingNumber];
    reporterLabel.text = [reporterLabel.text stringByAppendingString:self.message.reporter];
    reportContentLabel.text = [reportContentLabel.text stringByAppendingString:self.message.reportContent];
    reportTimeLabel.text = [reportTimeLabel.text stringByAppendingString:self.message.reportTime];
    phoneNumberLabel.text = [phoneNumberLabel.text stringByAppendingString:self.message.phoneNumber];
    
    CGRect reportContentLabelRect = [reportContentLabel.text boundingRectWithSize:CGSizeMake(reportContentLabel.frame.size.width, 1000)
                                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                                       attributes:[NSDictionary dictionaryWithObjectsAndKeys:reportContentLabel.font, NSFontAttributeName, nil]
                                                                          context:nil];
    reportContentLabel.frame = CGRectMake(20, CGRectGetMaxY(phoneNumberLabel.frame), self.view.bounds.size.width - 40, reportContentLabelRect.size.height + 20);
}

@end
