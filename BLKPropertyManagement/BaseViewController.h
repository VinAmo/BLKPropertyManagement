//
//  BaseViewController.h
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/13.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownMenu.h"

@interface BaseViewController : UIViewController

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) DropDownMenu *dropDownMenu;

@property (strong, nonatomic) NSMutableArray *dataFilter;
@property (strong, nonatomic) NSMutableArray *data;
@property (assign, nonatomic) NSUInteger page;
@property (assign, nonatomic) NSUInteger size;

- (void)fetch; // subclass need realize

@end
