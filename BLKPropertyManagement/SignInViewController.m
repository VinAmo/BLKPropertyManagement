//
//  SignInViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/6.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "AppDelegate.h"
#import "HTTPDataFetcher.h"
#import "SignInViewController.h"
#import "ViewController.h"

@interface SignInViewController () <UITextFieldDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UITextField *usernameTF;
@property (strong, nonatomic) UITextField *passwordTF;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = [[UIView alloc] init];
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView *usernameLeftView = [[UIView alloc] init];
    usernameLeftView.frame = CGRectMake(0, 0, 10, 40);
    
    UIView *passwordLeftView = [[UIView alloc] init];
    passwordLeftView.frame = CGRectMake(0, 0, 10, 40);
    
    _usernameTF = [[UITextField alloc] init];
    _usernameTF.frame = CGRectMake(30, 100, self.view.bounds.size.width - 60, 40);
    _usernameTF.leftViewMode = UITextFieldViewModeAlways;
    _usernameTF.leftView = usernameLeftView;
    _usernameTF.borderStyle = UITextBorderStyleRoundedRect;
    _usernameTF.returnKeyType = UIReturnKeyNext;
    _usernameTF.autocorrectionType = UITextAutocorrectionTypeNo;
    _usernameTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _usernameTF.placeholder = @"Username";
    _usernameTF.delegate = self;
    [self.view addSubview:_usernameTF];
    
    _passwordTF = [[UITextField alloc] init];
    _passwordTF.frame = CGRectMake(CGRectGetMinX(_usernameTF.frame), CGRectGetMaxY(_usernameTF.frame) + 10, self.view.bounds.size.width - 60, 40);
    _passwordTF.leftViewMode = UITextFieldViewModeAlways;
    _passwordTF.leftView = passwordLeftView;
    _passwordTF.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTF.secureTextEntry = YES;
    _passwordTF.returnKeyType = UIReturnKeyDone;
    _passwordTF.autocorrectionType = UITextAutocorrectionTypeNo;
    _passwordTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _passwordTF.placeholder = @"Password";
    _passwordTF.delegate = self;
    [self.view addSubview:_passwordTF];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    loginButton.frame = CGRectMake(CGRectGetMinX(_passwordTF.frame), CGRectGetMaxY(_passwordTF.frame) + 30, self.view.bounds.size.width - 60, 40);
    loginButton.backgroundColor = [UIColor lightGrayColor];
    loginButton.tintColor = [UIColor whiteColor];
    loginButton.layer.cornerRadius = 3.f;
    loginButton.layer.shadowOpacity = 0.8f;
    loginButton.layer.shadowRadius = 3.f;
    loginButton.layer.shadowOffset = CGSizeMake(0, 0);
    [loginButton setTitle:@"Sign in" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

#pragma mark - text field delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.usernameTF.text = @"super";
    self.passwordTF.text = @"888888";
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([textField isEqual:self.usernameTF]) {
        [userDefaults setObject:self.usernameTF.text forKey:@"username"];
    }
    if ([textField isEqual:self.passwordTF]) {
        [userDefaults setObject:self.passwordTF.text forKey:@"password"];
    }
    if ([userDefaults objectForKey:@"username"] && [userDefaults objectForKey:@"password"]) {
        [userDefaults setBool:YES forKey:@"access"];
    }
    
    [userDefaults synchronize];
}

#pragma mark - actions

- (void)login {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefaults stringForKey:@"username"];
    NSString *password = [userDefaults stringForKey:@"password"];
    NSString *encodedUsername = [[username dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    NSString *encodedPassword = [[password dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    
    [HTTPDataFetcher fetchLoginMessages:^(id messages) {
        if ([[messages objectForKey:@"message"] isEqualToString:@"success"]) {
            [[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies] enumerateObjectsUsingBlock:^(NSHTTPCookie *obj, NSUInteger idx, BOOL *stop) {
//                NSLog(@"Cookies :%@\n", obj);
                if ([[obj valueForKey:@"name"] isEqualToString:@"token"]) {
                    [userDefaults setObject:[obj valueForKey:@"value"] forKey:@"token"];
                }
            }];
            
            NSDictionary *rolePermission = [messages objectForKey:@"rolePermission"];
            NSString *rolePermissionPkno = [rolePermission objectForKey:@"rolePermissionPkno"];
            NSString *permissionsPkno = [rolePermission objectForKey:@"permissionsPkno"];
            NSString *userPkno = [[messages objectForKey:@"userinfo"] objectForKey:@"userPkno"];
            
            [userDefaults setObject:rolePermissionPkno forKey:@"rolePermissionPkno"];
            [userDefaults setObject:permissionsPkno forKey:@"permissionsPkno"];
            [userDefaults setObject:userPkno forKey:@"userPkno"];
            [userDefaults synchronize];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // back to main thread
                [self.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
                [self.navigationController setNavigationBarHidden:NO];
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [userDefaults removeObjectForKey:@"username"];
                [userDefaults removeObjectForKey:@"password"];
                [userDefaults setBool:NO forKey:@"access"];
                
                UIAlertView *alertView =  [[UIAlertView alloc] initWithTitle:@"登录失败"
                                                                     message:@"服务器已关闭或者您输入的帐号密码有误"
                                                                    delegate:self cancelButtonTitle:@"确认"
                                                           otherButtonTitles:nil];
                [alertView show];
            });
        }
    } withUsername:encodedUsername password:encodedPassword];
}

@end
