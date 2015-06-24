//
//  RepairReportCompleteViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/23.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "HTTPDataFetcher.h"
#import "RepairReportCompleteViewController.h"

@interface RepairReportCompleteViewController () <UITextViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) UILabel *placeholder;
@property (strong, nonatomic) UITextField *completeTimeTextField;

@end

@implementation RepairReportCompleteViewController

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
    
    UILabel *repairContentLabel = [[UILabel alloc] init];
    repairContentLabel.textColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:255/255.f alpha:1];
    repairContentLabel.text = @"维修内容";
    repairContentLabel.font = [UIFont systemFontOfSize:18.0f];
    [self.view addSubview:repairContentLabel];
    
    UILabel *repairContentAssociateLabel = [[UILabel alloc] init];
    repairContentAssociateLabel.numberOfLines = 0;
//    repairContentAssociateLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.view addSubview:repairContentAssociateLabel];
    
    UITextView *depictionTextView = [[UITextView alloc] init];
    depictionTextView.layer.borderWidth = 1.0f;
    depictionTextView.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    depictionTextView.layer.cornerRadius = 5.0f;
    depictionTextView.font = [UIFont systemFontOfSize:16.0f];
    depictionTextView.delegate = self;
    [self.view addSubview:depictionTextView];
    
    self.placeholder = [[UILabel alloc] init];
    self.placeholder.backgroundColor = [UIColor clearColor];
    self.placeholder.textColor = [UIColor lightGrayColor];
    self.placeholder.text = @"请根据维修单上的报修材料据实填写：";
    self.placeholder.font = [UIFont systemFontOfSize:15.0f];
    [depictionTextView addSubview:self.placeholder];
    
    UILabel *completeTimeLabel = [[UILabel alloc] init];
    completeTimeLabel.textColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:255/255.f alpha:1];
    completeTimeLabel.text = @"维修完成时间";
    completeTimeLabel.font = [UIFont systemFontOfSize:18.0f];
    [self.view addSubview:completeTimeLabel];
    
    UIDatePicker *completeTimeDatePicker = [[UIDatePicker alloc] init];
    completeTimeDatePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_TW"];
    completeTimeDatePicker.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    completeTimeDatePicker.datePickerMode = UIDatePickerModeDate;
    [completeTimeDatePicker addTarget:self action:@selector(pickCompleteTime:) forControlEvents:UIControlEventValueChanged];
    
    self.completeTimeTextField = [[UITextField alloc] init];
    self.completeTimeTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.completeTimeTextField.inputView = completeTimeDatePicker;
    self.completeTimeTextField.delegate = self;
    [self.view addSubview:self.completeTimeTextField];
    
    UILabel *evaluationLabel = [[UILabel alloc] init];
    evaluationLabel.textColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:255/255.f alpha:1];
    evaluationLabel.text = @"维修结果";
    evaluationLabel.font = [UIFont systemFontOfSize:18.0f];
    [self.view addSubview:evaluationLabel];
    
    UIButton *satisfiedButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [satisfiedButton setTitle:@"满意" forState:UIControlStateNormal];
    [satisfiedButton addTarget:self action:@selector(satisfiedEvaluation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:satisfiedButton];
    
    UIButton *dissatisfiedButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [dissatisfiedButton setTitle:@"不满意" forState:UIControlStateNormal];
    [dissatisfiedButton addTarget:self action:@selector(dissatisfiedEvaluation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dissatisfiedButton];
    
    UIButton *completeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    completeButton.backgroundColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:255/255.f alpha:1];
    completeButton.layer.cornerRadius = 5.0f;
    [completeButton setTitle:@"确认" forState:UIControlStateNormal];
    [completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [completeButton addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:completeButton];
    
    typeLabel.text = [typeLabel.text stringByAppendingString:self.message.type];
    buildingNumberLabel.text = [buildingNumberLabel.text stringByAppendingString:self.message.buildingNumber];
    reporterLabel.text = [reporterLabel.text stringByAppendingString:self.message.reporter];
    phoneNumberLabel.text = [phoneNumberLabel.text stringByAppendingString:self.message.phoneNumber];
    appointTimeLabel.text = [appointTimeLabel.text stringByAppendingString:self.message.appointTime];
    reportTimeLabel.text = [reportTimeLabel.text stringByAppendingString:self.message.reportTime];
    repairContentAssociateLabel.text = self.message.repairContent;
    
    CGRect repairContentAssociateLabelRect = [repairContentAssociateLabel.text boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 40, 1000)
                                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                                       attributes:[NSDictionary dictionaryWithObjectsAndKeys:repairContentAssociateLabel.font, NSFontAttributeName, nil]
                                                                          context:nil];
    
    typeLabel.frame = CGRectMake(20, 20, self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    buildingNumberLabel.frame = CGRectMake(20, CGRectGetMaxY(typeLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    reporterLabel.frame = CGRectMake(20, CGRectGetMaxY(buildingNumberLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    phoneNumberLabel.frame = CGRectMake(20, CGRectGetMaxY(reporterLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    appointTimeLabel.frame = CGRectMake(20, CGRectGetMaxY(phoneNumberLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    reportTimeLabel.frame = CGRectMake(20, CGRectGetMaxY(appointTimeLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    repairContentLabel.frame = CGRectMake(20, CGRectGetMaxY(reportTimeLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.07);
    repairContentAssociateLabel.frame = CGRectMake(20, CGRectGetMaxY(repairContentLabel.frame), self.view.bounds.size.width - 40, repairContentAssociateLabelRect.size.height);
    depictionTextView.frame = CGRectMake(20, CGRectGetMaxY(repairContentAssociateLabel.frame) + 10, self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.17);
    self.placeholder.frame = CGRectMake(5, 5, CGRectGetWidth(depictionTextView.bounds) - 10, 20);
    completeTimeLabel.frame = CGRectMake(20, CGRectGetMaxY(depictionTextView.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.07);
    self.completeTimeTextField.frame = CGRectMake(20, CGRectGetMaxY(completeTimeLabel.frame), self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.05);
    evaluationLabel.frame = CGRectMake(20, CGRectGetMaxY(self.completeTimeTextField.frame) + 5, 100, self.view.bounds.size.height * 0.07);
    satisfiedButton.frame = CGRectMake(CGRectGetMaxX(evaluationLabel.frame), CGRectGetMinY(evaluationLabel.frame) + 6, 100, self.view.bounds.size.height * 0.05);
    dissatisfiedButton.frame = CGRectMake(CGRectGetMaxX(satisfiedButton.frame) + 20, CGRectGetMinY(satisfiedButton.frame), 100, self.view.bounds.size.height * 0.05);
    completeButton.frame = CGRectMake(20, CGRectGetMaxY(evaluationLabel.frame) + 10, self.view.bounds.size.width - 40, self.view.bounds.size.height * 0.06);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

#pragma mark - actions

- (void)pickCompleteTime:(UIDatePicker *)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    self.completeTimeTextField.text = [formatter stringFromDate:sender.date];
}

- (void)satisfiedEvaluation:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.message.evaluation = @"Y";
    }
    else {
        self.message.evaluation = @"";
    }
}

- (void)dissatisfiedEvaluation:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.message.evaluation = @"N";
    }
    else {
        self.message.evaluation = @"";
    }
}

- (void)complete {
    NSLog(@"%@ %@ %@", self.message.depiction, self.message.completeTime, self.message.evaluation);
    [HTTPDataFetcher setCookies];
    [HTTPDataFetcher fetchRepairReportCompleteMessages:^(id messages) {
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
    } withReportIdentifier:self.message.identifier depiction:self.message.depiction time:self.message.completeTime evaluation:self.message.evaluation];
    [HTTPDataFetcher deleteCookies];
}

#pragma mark - text view delegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placeholder.text = @"";
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        self.placeholder.text = @"请根据维修单上的报修材料据实填写：";
    }
    else {
        self.placeholder.text = @"";
    }
    self.message.depiction = textView.text;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - text field delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.message.completeTime = textField.text;
}

@end
