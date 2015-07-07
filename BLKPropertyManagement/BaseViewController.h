//
//  BaseViewController.h
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/13.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownMenu.h"

@interface BaseViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) DropDownMenu *dropDownMenu;

@property (strong, nonatomic) NSMutableDictionary *dataFilter;
@property (strong, nonatomic) NSMutableArray *data;
@property (assign, nonatomic) NSUInteger page;
@property (assign, nonatomic) NSUInteger size;
@property (copy, nonatomic) NSString *category;
@property (copy, nonatomic) NSString *type; // for feedback category
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *person;

- (void)loadDataFilter;
- (void)loadData; // required to implement in subclass

@end
