//
//  AccountViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/8.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "AccountViewController.h"

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view = [[UIView alloc] init];
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *usernameLabel = [[UILabel alloc] init];
    usernameLabel.frame = CGRectMake(20, 50, 100, 40);
    usernameLabel.backgroundColor = [UIColor grayColor];
    usernameLabel.layer.masksToBounds = YES;
    usernameLabel.layer.cornerRadius = 5.f;
    usernameLabel.textAlignment = NSTextAlignmentCenter;
    usernameLabel.textColor = [UIColor whiteColor];
    usernameLabel.text = [NSString stringWithFormat:@"账户:%@", [[NSUserDefaults standardUserDefaults] stringForKey:@"username"]];
    [self.view addSubview:usernameLabel];
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeSystem];
    logoutButton.frame = CGRectMake(20, 100, 100, 40);
    logoutButton.backgroundColor = [UIColor grayColor];
    logoutButton.tintColor = [UIColor whiteColor];
    logoutButton.layer.masksToBounds = YES;
    logoutButton.layer.cornerRadius = 5.f;
    [logoutButton setTitle:@"Sign out" forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];
}

- (void)logout {
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
}

@end
