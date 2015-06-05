//
//  FeedbackViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/4.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "FeedbackViewController.h"
#import "FeedbackDetailViewController.h"

@interface FeedbackTVC : UITableViewCell

@property (strong, nonatomic) UIView *headerContainerView;
@property (strong, nonatomic) UILabel *headerLeftLabel;
@property (strong, nonatomic) UILabel *headerRightLabel;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *feedbackLabel;
@property (strong, nonatomic) UILabel *addressLabel;
@property (strong, nonatomic) UILabel *personLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *phoneNumberLabel;

@end

@implementation FeedbackTVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        _headerContainerView = [[UIView alloc] init];
        [self addSubview:_headerContainerView];
        
        _headerLeftLabel = [[UILabel alloc] init];
        _headerLeftLabel.text = @"类型：";
        _headerLeftLabel.textColor = [UIColor blueColor];
        [_headerContainerView addSubview:_headerLeftLabel];
        
        _headerRightLabel = [[UILabel alloc] init];
        _headerRightLabel.textAlignment = NSTextAlignmentRight;
        _headerRightLabel.text = @"状态：";
        _headerRightLabel.textColor = [UIColor blueColor];
        [_headerContainerView addSubview:_headerRightLabel];
        
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont fontWithName:nil size:20]];
        [self addSubview:_titleLabel];
        
        _feedbackLabel = [[UILabel alloc] init];
        _feedbackLabel.text = @"反馈内容：";
        [self addSubview:_feedbackLabel];
        
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.text = @"反馈地址：";
        [self addSubview:_addressLabel];
        
        _personLabel = [[UILabel alloc] init];
        _personLabel.text = @"反馈人：";
        [self addSubview:_personLabel];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"反馈时间：";
        [self addSubview:_timeLabel];
        
        _phoneNumberLabel = [[UILabel alloc] init];
        _phoneNumberLabel.text = @"联系方式：";
        [self addSubview:_phoneNumberLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // fix the frame of cells is different with its containers.
    self.headerContainerView.frame = CGRectMake(20, 0, self.bounds.size.width - 20, self.bounds.size.height * 0.1);
    self.headerLeftLabel.frame = CGRectMake(0, 0, self.headerContainerView.bounds.size.width * 0.7, self.headerContainerView.bounds.size.height);
    self.headerRightLabel.frame = CGRectMake(CGRectGetMaxX(self.headerLeftLabel.frame), 0, self.headerContainerView.bounds.size.width * 0.3, self.headerContainerView.bounds.size.height);
    
    self.titleLabel.frame = CGRectMake(20, CGRectGetMaxY(self.headerContainerView.frame), self.bounds.size.width - 20, self.bounds.size.height * 0.1);
    self.feedbackLabel.frame = CGRectMake(20, CGRectGetMaxY(self.titleLabel.frame), self.bounds.size.width - 20, self.bounds.size.height * 0.1);
    self.addressLabel.frame = CGRectMake(20, CGRectGetMaxY(self.feedbackLabel.frame), self.bounds.size.width - 20, self.bounds.size.height * 0.1);
    self.personLabel.frame = CGRectMake(20, CGRectGetMaxY(self.addressLabel.frame), self.bounds.size.width - 20, self.bounds.size.height * 0.1);
    self.timeLabel.frame = CGRectMake(20, CGRectGetMaxY(self.personLabel.frame), self.bounds.size.width - 20, self.bounds.size.height * 0.1);
    self.phoneNumberLabel.frame = CGRectMake(20, CGRectGetMaxY(self.timeLabel.frame), self.bounds.size.width - 20, self.bounds.size.height * 0.1);
}

@end

@interface FeedbackViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"反馈信息";
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedbackTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[FeedbackTVC alloc] init];
    }
    return cell;
}

#pragma mark - table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[FeedbackDetailViewController alloc] init] animated:YES];
}

@end
