//
//  FeedbackDetailViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/4.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "FeedbackDetailViewController.h"

@interface FeedbackDetailViewController ()

@end

@implementation FeedbackDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"反馈详情";
    
    self.view = [[UIView alloc] init];
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFont:[UIFont fontWithName:nil size:20]];
    [self.view addSubview:titleLabel];
    
    UILabel *feedbackLabel = [[UILabel alloc] init];
    feedbackLabel.text = @"反馈内容：";
    [self.view addSubview:feedbackLabel];
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.text = @"反馈地址：";
    [self.view addSubview:addressLabel];
    
    UILabel *personLabel = [[UILabel alloc] init];
    personLabel.text = @"反馈人：";
    [self.view addSubview:personLabel];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.text = @"反馈时间：";
    [self.view addSubview:timeLabel];
    
    UILabel *phoneNumberLabel = [[UILabel alloc] init];
    phoneNumberLabel.text = @"联系方式：";
    [self.view addSubview:phoneNumberLabel];
    
    titleLabel.frame = CGRectMake(20, 0, self.view.bounds.size.width - 20, self.view.bounds.size.height * 0.1);
    feedbackLabel.frame = CGRectMake(20, CGRectGetMaxY(titleLabel.frame), self.view.bounds.size.width - 20, self.view.bounds.size.height * 0.1);
    addressLabel.frame = CGRectMake(20, CGRectGetMaxY(feedbackLabel.frame), self.view.bounds.size.width - 20, self.view.bounds.size.height * 0.1);
    personLabel.frame = CGRectMake(20, CGRectGetMaxY(addressLabel.frame), self.view.bounds.size.width - 20, self.view.bounds.size.height * 0.1);
    timeLabel.frame = CGRectMake(20, CGRectGetMaxY(personLabel.frame), self.view.bounds.size.width - 20, self.view.bounds.size.height * 0.1);
    phoneNumberLabel.frame = CGRectMake(20, CGRectGetMaxY(timeLabel.frame), self.view.bounds.size.width - 20, self.view.bounds.size.height * 0.1);
}

@end
