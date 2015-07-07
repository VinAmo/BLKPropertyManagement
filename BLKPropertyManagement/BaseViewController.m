//
//  BaseViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/13.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "HTTPDataFetcher.h"
#import "BaseViewController.h"

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, self.view.bounds.origin.y, self.view.bounds.size.width, 50);
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = CGRectMake(0, 0, 200, headerView.bounds.size.height);
    menuButton.layer.masksToBounds = YES;
    menuButton.layer.cornerRadius = 5.f;
    menuButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    menuButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [menuButton setTitle:@"筛选" forState:UIControlStateNormal];
    [menuButton setTitleColor:[UIColor colorWithRed:30/255.f green:144/255.f blue:255/255.f alpha:1] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(handleDropDownMenu) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:menuButton];
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, CGRectGetMaxY(headerView.frame), self.view.bounds.size.width, self.view.bounds.size.height - self.navigationController.navigationBar.frame.size.height - headerView.frame.size.height - 20); // find the right height.
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] init];
    _activityIndicatorView.frame = CGRectMake(0, 0, 100, 100);
    _activityIndicatorView.center = _tableView.center;
    [_activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:_activityIndicatorView];
    
    _dropDownMenu = [[DropDownMenu alloc] init];
    _dropDownMenu.frame = CGRectMake(CGRectGetMinX(menuButton.frame), CGRectGetMaxY(menuButton.frame), menuButton.bounds.size.width, 200);
    _dropDownMenu.dataSource = self;
    _dropDownMenu.delegate = self;
    [self.view addSubview:_dropDownMenu];
    
    // defalut parameters
    _page = 1;
    _size = 10;
    _category = @"ALL";
    _type = @"FEEDBACK";
    _state = @"";
    _person = @"";
    
    [self loadDataFilter];
    [self loadData];
}

#pragma mark - properties

//@synthesize data = _data;
//
//- (void)setData:(NSMutableArray *)data {
//    if (_data != data) {
//        _data = data;
//        [self.tableView reloadData];
//    }
//}

- (NSMutableArray *)data {
    if (!_data) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

- (NSMutableDictionary *)dataFilter {
    if (!_dataFilter) {
        _dataFilter = [[NSMutableDictionary alloc] init];
    }
    return _dataFilter;
}

- (NSString *)category {
    if (!_category) {
        _category = [NSString string];
    }
    return _category;
}

- (NSString *)state {
    if (!_state) {
        _state = [NSString string];
    }
    return _state;
}

- (NSString *)person {
    if (!_person) {
        _person = [NSString string];
    }
    return _person;
}

#pragma mark - functions

- (void)loadDataFilter {
    // coveted in subclass
}

- (void)loadData{
    // covered in subclass
}

- (void)handleDropDownMenu {
    if (self.dropDownMenu.isVisible) {
        [self.dropDownMenu hide];
    }
    else {
        [self.dropDownMenu show];
    }
}

#pragma mark - scroll view delegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%f", scrollView.contentOffset.y);
//}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height) {
        if ([scrollView isEqual:self.tableView]) {
            [self loadData];
        }
    }
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.size.height) {
//        if ([scrollView isEqual:self.tableView]) {
//            NSLog(@"Dragging finished.");
//        }
//    }
//}

#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.dropDownMenu]) {
        return self.dataFilter.count;
    }
    else if ([tableView isEqual:self.tableView]) {
        return self.data.count;
    }
    else {
        return 5; // default
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    return cell;
}

#pragma mark - table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.dropDownMenu]) {
        return 40;
    }
    else if ([tableView isEqual:self.tableView]) {
        return 280;
    }
    else {
        return 30; // default
    }
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//}

@end
