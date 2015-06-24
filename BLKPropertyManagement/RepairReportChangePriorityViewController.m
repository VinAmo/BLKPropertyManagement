//
//  RepairReportChangePriorityViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/23.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "HTTPDataFetcher.h"
#import "RepairReportChangePriorityViewController.h"

@interface RepairReportChangePriorityViewController ()

@end

@implementation RepairReportChangePriorityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"确认完成";
    
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
    
    UILabel *phoneNumberLabel = [[UILabel alloc] init];
    phoneNumberLabel.text = @"联系电话：";
    [self.view addSubview:phoneNumberLabel];
    
    UILabel *appointTimeLabel = [[UILabel alloc] init];
    appointTimeLabel.text = @"预约时间：";
    [self.view addSubview:appointTimeLabel];
    
    UILabel *reportTimeLabel = [[UILabel alloc] init];
    reportTimeLabel.text = @"报修时间：";
    [self.view addSubview:reportTimeLabel];
    
    UILabel *reportContentLabel = [[UILabel alloc] init];
    reportContentLabel.textColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:255/255.f alpha:1];
    reportContentLabel.text = @"报修原因";
    reportContentLabel.font = [UIFont systemFontOfSize:18.0f];
    [self.view addSubview:reportContentLabel];
    
    UILabel *reportContentAssociateLabel = [[UILabel alloc] init];
    reportContentAssociateLabel.numberOfLines = 0;
    reportContentAssociateLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.view addSubview:reportContentAssociateLabel];
    
    UILabel *repairContentLabel = [[UILabel alloc] init];
    repairContentLabel.textColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:255/255.f alpha:1];
    repairContentLabel.text = @"维修内容";
    repairContentLabel.font = [UIFont systemFontOfSize:18.0f];
    [self.view addSubview:repairContentLabel];
    
    UILabel *repairContentAssociateLabel = [[UILabel alloc] init];
    repairContentAssociateLabel.numberOfLines = 0;
    //    repairContentAssociateLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.view addSubview:repairContentAssociateLabel];
    
    UILabel *priorityLabel = [[UILabel alloc] init];
    priorityLabel.textColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:255/255.f alpha:1];
    priorityLabel.text = @"报修级别";
    priorityLabel.font = [UIFont systemFontOfSize:18.0f];
    [self.view addSubview:priorityLabel];
    
    UIButton *lowPriorityButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [lowPriorityButton setTitle:@"普通" forState:UIControlStateNormal];
    [lowPriorityButton addTarget:self action:@selector(chooseLowPriority:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lowPriorityButton];
    
    UIButton *normalPriorityButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [normalPriorityButton setTitle:@"优先" forState:UIControlStateNormal];
    [normalPriorityButton addTarget:self action:@selector(chooseNormalPriority:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:normalPriorityButton];
    
    UIButton *highPriorityButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [highPriorityButton setTitle:@"紧急" forState:UIControlStateNormal];
    [highPriorityButton addTarget:self action:@selector(chooseHighPriority:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:highPriorityButton];
    
    UIButton *changePriorityButton = [UIButton buttonWithType:UIButtonTypeSystem];
    changePriorityButton.backgroundColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:255/255.f alpha:1];
    changePriorityButton.layer.cornerRadius = 5.0f;
    [changePriorityButton setTitle:@"确认" forState:UIControlStateNormal];
    [changePriorityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changePriorityButton addTarget:self action:@selector(changePriority:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changePriorityButton];
    
    typeLabel.text = [typeLabel.text stringByAppendingString:self.message.type];
    buildingNumberLabel.text = [buildingNumberLabel.text stringByAppendingString:self.message.buildingNumber];
    reporterLabel.text = [reporterLabel.text stringByAppendingString:self.message.reporter];
    phoneNumberLabel.text = [phoneNumberLabel.text stringByAppendingString:self.message.phoneNumber];
    appointTimeLabel.text = [appointTimeLabel.text stringByAppendingString:self.message.appointTime];
    reportTimeLabel.text = [reportTimeLabel.text stringByAppendingString:self.message.reportTime];
    reportContentAssociateLabel.text = self.message.reportContent;
    repairContentAssociateLabel.text = self.message.repairContent;
    
    CGRect reportContentLabelRect = [reportContentAssociateLabel.text boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 40, 1000)
                                                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                                                attributes:[NSDictionary dictionaryWithObjectsAndKeys:reportContentAssociateLabel.font, NSFontAttributeName, nil]
                                                                                   context:nil];
    CGRect repairContentLabelRect = [repairContentAssociateLabel.text boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 40, 1000)
                                                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                                                attributes:[NSDictionary dictionaryWithObjectsAndKeys:repairContentAssociateLabel.font, NSFontAttributeName, nil]
                                                                                   context:nil];
    
    typeLabel.frame = CGRectMake(20, 20, self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    buildingNumberLabel.frame = CGRectMake(20, CGRectGetMaxY(typeLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    reporterLabel.frame = CGRectMake(20, CGRectGetMaxY(buildingNumberLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    phoneNumberLabel.frame = CGRectMake(20, CGRectGetMaxY(reporterLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    appointTimeLabel.frame = CGRectMake(20, CGRectGetMaxY(phoneNumberLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    reportTimeLabel.frame = CGRectMake(20, CGRectGetMaxY(appointTimeLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    reportContentLabel.frame = CGRectMake(20, CGRectGetMaxY(reportTimeLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.07);
    reportContentAssociateLabel.frame = CGRectMake(20, CGRectGetMaxY(reportContentLabel.frame), self.view.bounds.size.width - 40, reportContentLabelRect.size.height);
    repairContentLabel.frame = CGRectMake(20, CGRectGetMaxY(reportContentAssociateLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.07);
    repairContentAssociateLabel.frame = CGRectMake(20, CGRectGetMaxY(repairContentLabel.frame), self.view.bounds.size.width - 40, repairContentLabelRect.size.height);
    priorityLabel.frame = CGRectMake(20, CGRectGetMaxY(repairContentAssociateLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.07);
    lowPriorityButton.frame = CGRectMake(20, CGRectGetMaxY(priorityLabel.frame), 100, self.view.bounds.size.height * 0.05);
    normalPriorityButton.frame = CGRectMake(CGRectGetMaxX(lowPriorityButton.frame) + 20, CGRectGetMinY(lowPriorityButton.frame), 100, self.view.bounds.size.height * 0.05);
    highPriorityButton.frame = CGRectMake(CGRectGetMaxX(normalPriorityButton.frame) + 20, CGRectGetMinY(normalPriorityButton.frame), 100, self.view.bounds.size.height * 0.05);
    changePriorityButton.frame = CGRectMake(20, self.view.bounds.size.height * 0.8, self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.06);
}

#pragma mark - actions

- (void)chooseLowPriority:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.message.priority = @"level003";
    }
    else {
        self.message.priority = @"";
    }
}

- (void)chooseNormalPriority:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.message.priority = @"level002";
    }
    else {
        self.message.priority = @"";
    }
}

- (void)chooseHighPriority:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.message.priority = @"level001";
    }
    else {
        self.message.priority = @"";
    }
}

- (void)changePriority:(UIButton *)sender {
    [HTTPDataFetcher setCookies];
    [HTTPDataFetcher fetchRepairReportChangePriorityMessages:^(id messages) {
        NSLog(@"%@", messages);
        if ([messages isKindOfClass:[NSDictionary class]]) {
            if ([[messages valueForKey:@"message"] isEqualToString:@"success"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else {
                [[[UIAlertView alloc] initWithTitle:@"提示"
                                            message:@"提交失败"
                                           delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil] show];
            }
        }
    } withReportIdentifier:self.message.identifier priority:self.message.priority];
    [HTTPDataFetcher deleteCookies];
}

@end
