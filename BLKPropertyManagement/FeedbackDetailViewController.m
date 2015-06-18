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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"反馈详情";
    
    self.view = [[UIView alloc] init];
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *feedbackLabel = [[UILabel alloc] init];
//    feedbackLabel.backgroundColor = [UIColor grayColor];
    feedbackLabel.numberOfLines = 0;
    feedbackLabel.lineBreakMode = NSLineBreakByCharWrapping;
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
    
    feedbackLabel.text = [feedbackLabel.text stringByAppendingString:self.message.feedback];
    addressLabel.text = [addressLabel.text stringByAppendingString:self.message.address];
    personLabel.text = [personLabel.text stringByAppendingString:self.message.person];
    timeLabel.text = [timeLabel.text stringByAppendingString:self.message.time];
    phoneNumberLabel.text = [phoneNumberLabel.text stringByAppendingString:self.message.phoneNumber];
    
    CGRect feedbackLabelRect = [feedbackLabel.text boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 40 , 500)
                                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                                              attributes:[NSDictionary dictionaryWithObjectsAndKeys:feedbackLabel.font, NSFontAttributeName, nil] context:nil];
    
    feedbackLabel.frame = CGRectMake(20, 20, self.view.bounds.size.width - 40, feedbackLabelRect.size.height + 10);
    addressLabel.frame = CGRectMake(20, CGRectGetMaxY(feedbackLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    personLabel.frame = CGRectMake(20, CGRectGetMaxY(addressLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    timeLabel.frame = CGRectMake(20, CGRectGetMaxY(personLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    phoneNumberLabel.frame = CGRectMake(20, CGRectGetMaxY(timeLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
}

@end
