//
//  AddNoticeViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/4.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "AddNoticeViewController.h"

@interface AddNoticeViewController () <UITextFieldDelegate>

@end

@implementation AddNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"发布公告";
    UIBarButtonItem *publishBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_notice_publish"] style:UIBarButtonItemStyleDone target:self action:@selector(publish)];
    self.navigationItem.rightBarButtonItem = publishBarButtonItem;
    
    self.view = [[UIView alloc] init];
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *titleTextField = [[UITextField alloc] init];
    titleTextField.frame = CGRectMake(20, 20, self.view.bounds.size.width - 20, 30);
    titleTextField.placeholder = @"Input title";
    [self.view addSubview:titleTextField];
    
    UITextView *contentTextView = [[UITextView alloc] init];
    contentTextView.frame = CGRectMake(20, CGRectGetMaxY(titleTextField.frame) + 20, self.view.bounds.size.width - 20, 80);
    [self.view addSubview:contentTextView];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (void)publish {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
