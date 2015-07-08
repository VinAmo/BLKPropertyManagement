//
//  RepairReportConfirmViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/23.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "HTTPDataFetcher.h"
#import "RepairReportConfirmViewController.h"

@interface RepairReportConfirmViewController () <UITextFieldDelegate>

@end

@implementation RepairReportConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"确认申请";
    
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
    
    UILabel *repairContentLabel = [[UILabel alloc] init];
    repairContentLabel.textColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:255/255.f alpha:1];
    repairContentLabel.text = @"报修内容";
    repairContentLabel.font = [UIFont systemFontOfSize:18.0f];
    [self.view addSubview:repairContentLabel];
    
    UITextField *repairContentTextField = [[UITextField alloc] init];
    repairContentTextField.borderStyle = UITextBorderStyleRoundedRect;
    repairContentTextField.delegate = self;
    [self.view addSubview:repairContentTextField];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
    confirmButton.backgroundColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:255/255.f alpha:1];
    confirmButton.layer.cornerRadius = 5.0f;
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmButton];
    
    typeLabel.text = [typeLabel.text stringByAppendingString:self.message.type];
    buildingNumberLabel.text = [buildingNumberLabel.text stringByAppendingString:self.message.buildingNumber];
    reporterLabel.text = [reporterLabel.text stringByAppendingString:self.message.reporter];
    phoneNumberLabel.text = [phoneNumberLabel.text stringByAppendingString:self.message.phoneNumber];
    appointTimeLabel.text = [appointTimeLabel.text stringByAppendingString:self.message.appointTime];
    reportTimeLabel.text = [reportTimeLabel.text stringByAppendingString:self.message.reportTime];
    reportContentAssociateLabel.text = self.message.reportContent;
    
    CGRect reportContentLabelRect = [reportContentAssociateLabel.text boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 40, 1000)
                                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                                       attributes:[NSDictionary dictionaryWithObjectsAndKeys:reportContentAssociateLabel.font, NSFontAttributeName, nil]
                                                                          context:nil];
    
    typeLabel.frame = CGRectMake(20, 20, self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    buildingNumberLabel.frame = CGRectMake(20, CGRectGetMaxY(typeLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    reporterLabel.frame = CGRectMake(20, CGRectGetMaxY(buildingNumberLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    phoneNumberLabel.frame = CGRectMake(20, CGRectGetMaxY(reporterLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    appointTimeLabel.frame = CGRectMake(20, CGRectGetMaxY(phoneNumberLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    reportTimeLabel.frame = CGRectMake(20, CGRectGetMaxY(appointTimeLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    reportContentLabel.frame = CGRectMake(20, CGRectGetMaxY(reportTimeLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.07);
    reportContentAssociateLabel.frame = CGRectMake(20, CGRectGetMaxY(reportContentLabel.frame), self.view.bounds.size.width - 40, reportContentLabelRect.size.height);
    priorityLabel.frame = CGRectMake(20, CGRectGetMaxY(reportContentAssociateLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.07);
    lowPriorityButton.frame = CGRectMake(20, CGRectGetMaxY(priorityLabel.frame), 100, self.view.bounds.size.height * 0.05);
    normalPriorityButton.frame = CGRectMake(CGRectGetMaxX(lowPriorityButton.frame) + 20, CGRectGetMinY(lowPriorityButton.frame), 100, self.view.bounds.size.height * 0.05);
    highPriorityButton.frame = CGRectMake(CGRectGetMaxX(normalPriorityButton.frame) + 20, CGRectGetMinY(normalPriorityButton.frame), 100, self.view.bounds.size.height * 0.05);
    repairContentLabel.frame = CGRectMake(20, CGRectGetMaxY(lowPriorityButton.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.07);
    repairContentTextField.frame = CGRectMake(20, CGRectGetMaxY(repairContentLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    confirmButton.frame = CGRectMake(20, self.view.bounds.size.height * 0.8, self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.06);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
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
    
- (void)confirm {
    [HTTPDataFetcher setCookies];
    [HTTPDataFetcher fetchRepairReportConfirmMessages:^(id messages) {
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
    } withReportIdentifier:self.message.identifier priority:self.message.priority content:self.message.reportContent];
    [HTTPDataFetcher deleteCookies];
}

#pragma mark - text field delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.message.reportContent = textField.text;
}

@end
