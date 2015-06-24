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
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel *usernameLabel = [[UILabel alloc] init];
    usernameLabel.frame = CGRectMake(30, 50, 60, 40);
    usernameLabel.backgroundColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:255/255.f alpha:1];
    usernameLabel.layer.masksToBounds = YES;
    usernameLabel.layer.cornerRadius = 3.f;
    usernameLabel.shadowColor = [UIColor blackColor];
    usernameLabel.shadowOffset = CGSizeMake(0, 0);
    usernameLabel.textAlignment = NSTextAlignmentCenter;
    usernameLabel.textColor = [UIColor whiteColor];
    usernameLabel.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    [self.view addSubview:usernameLabel];
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeSystem];
    logoutButton.frame = CGRectMake(CGRectGetMaxX(usernameLabel.frame), CGRectGetMinY(usernameLabel.frame), self.view.bounds.size.width - usernameLabel.frame.size.width - 60, 40);
    logoutButton.backgroundColor = [UIColor whiteColor];
    logoutButton.layer.cornerRadius = 3.f;
    [logoutButton setTitle:@"Sign out" forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor colorWithRed:30/255.f green:144/255.f blue:255/255.f alpha:1] forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];
}

- (void)logout {
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
}

@end
