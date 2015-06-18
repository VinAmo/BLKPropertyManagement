//
//  SignInViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/6.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "AppDelegate.h"
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *usernameLabel = [[UILabel alloc] init];
    usernameLabel.frame = CGRectMake(20, 100, 80, 40);
    usernameLabel.backgroundColor = [UIColor grayColor];
    usernameLabel.layer.masksToBounds = YES;
    usernameLabel.layer.cornerRadius = 5.f;
    usernameLabel.textAlignment = NSTextAlignmentCenter;
    usernameLabel.textColor = [UIColor whiteColor];
    usernameLabel.text = @"Account:";
    [self.view addSubview:usernameLabel];
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.frame = CGRectMake(20, CGRectGetMaxY(usernameLabel.frame) + 10, 80, 40);
    passwordLabel.backgroundColor = [UIColor grayColor];
    passwordLabel.layer.masksToBounds = YES;
    passwordLabel.layer.cornerRadius = 5.f;
    passwordLabel.textAlignment = NSTextAlignmentCenter;
    passwordLabel.textColor = [UIColor whiteColor];
    passwordLabel.text = @"Password:";
    [self.view addSubview:passwordLabel];
    
    _usernameTF = [[UITextField alloc] init];
    _usernameTF.frame = CGRectMake(CGRectGetMaxX(usernameLabel.frame) + 20, CGRectGetMinY(usernameLabel.frame), self.view.bounds.size.width - usernameLabel.frame.size.width - 60, 40);
    _usernameTF.layer.masksToBounds = YES;
    _usernameTF.layer.cornerRadius = 5.f;
    _usernameTF.layer.borderWidth = 1.5f;
    _usernameTF.layer.borderColor = [[UIColor grayColor] CGColor];
    _usernameTF.returnKeyType = UIReturnKeyNext;
    _usernameTF.autocorrectionType = UITextAutocorrectionTypeNo;
    _usernameTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _usernameTF.delegate = self;
    [self.view addSubview:_usernameTF];
    
    _passwordTF = [[UITextField alloc] init];
    _passwordTF.frame = CGRectMake(CGRectGetMaxX(passwordLabel.frame) + 20, CGRectGetMinY(passwordLabel.frame), self.view.bounds.size.width - passwordLabel.frame.size.width - 60, 40);
    _passwordTF.layer.masksToBounds = YES;
    _passwordTF.layer.cornerRadius = 5.f;
    _passwordTF.layer.borderWidth = 1.5f;
    _passwordTF.layer.borderColor = [[UIColor grayColor] CGColor];
    _passwordTF.secureTextEntry = YES;
    _passwordTF.returnKeyType = UIReturnKeyDone;
    _passwordTF.autocorrectionType = UITextAutocorrectionTypeNo;
    _passwordTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _passwordTF.delegate = self;
    [self.view addSubview:_passwordTF];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    loginButton.frame = CGRectMake(0, 0, 100, 40);
    loginButton.center = CGPointMake(self.view.center.x - 80, CGRectGetMaxY(passwordLabel.frame) + 50);
    loginButton.backgroundColor = [UIColor grayColor];
    loginButton.tintColor = [UIColor whiteColor];
    loginButton.layer.masksToBounds = YES;
    loginButton.layer.cornerRadius = 5.f;
    [loginButton setTitle:@"Sign in" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.frame = CGRectMake(0, 0, 100, 40);
    cancelButton.center = CGPointMake(self.view.center.x + 80, CGRectGetMaxY(passwordLabel.frame) + 50);
    cancelButton.backgroundColor = [UIColor grayColor];
    cancelButton.tintColor = [UIColor whiteColor];
    cancelButton.layer.masksToBounds = YES;
    cancelButton.layer.cornerRadius = 5.f;
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
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
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *urlStr = [delegate.servicePort stringByAppendingPathComponent:@"AppLogin/login.do"];
    NSString *param = [NSString stringWithFormat:@"loginName=%@&loginPwd=%@", encodedUsername, encodedPassword];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
    
    __weak typeof(self) weakSelf = self;
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue new]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               NSError *error = nil;
                               NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                               if (error) {
                                   NSLog(@"Error parsing JSON: %@", error);
                               }
                               else {
//                                   NSLog(@"%@", rootDic);
                               }
                               
                               if ([[rootDic objectForKey:@"message"] isEqualToString:@"success"]) {
                                   [[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies] enumerateObjectsUsingBlock:^(NSHTTPCookie *obj, NSUInteger idx, BOOL *stop) {
//                                       NSLog(@"Cookies :%@\n", obj);
                                       if ([[obj valueForKey:@"name"] isEqualToString:@"token"]) {
                                           [userDefaults setObject:[obj valueForKey:@"value"] forKey:@"token"];
                                       }
                                   }];
                                   
                                   NSDictionary *rolePermission = [rootDic objectForKey:@"rolePermission"];
                                   NSString *rolePermissionPkno = [rolePermission objectForKey:@"rolePermissionPkno"];
                                   NSString *permissionsPkno = [rolePermission objectForKey:@"permissionsPkno"];
                                   NSString *userPkno = [[rootDic objectForKey:@"userinfo"] objectForKey:@"userPkno"];
                                   
                                   [userDefaults setObject:rolePermissionPkno forKey:@"rolePermissionPkno"];
                                   [userDefaults setObject:permissionsPkno forKey:@"permissionsPkno"];
                                   [userDefaults setObject:userPkno forKey:@"userPkno"];
                                   [userDefaults synchronize];
                                   
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       // back to main thread
                                       [weakSelf.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
                                       [weakSelf.navigationController setNavigationBarHidden:NO];
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
                           }];
}

- (void)cancel{
    
}

@end
