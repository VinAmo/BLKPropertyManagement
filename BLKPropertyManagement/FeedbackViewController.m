//
//  FeedbackViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/4.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "HTTPDataFetcher.h"
#import "FeedBackMessage.h"
#import "BaseTableViewCell.h"
#import "FeedbackViewController.h"
#import "FeedbackDetailViewController.h"

#pragma mark - Table View Cell

@interface FeedbackTableViewCell : BaseTableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *feedbackLabel;
@property (strong, nonatomic) UILabel *addressLabel;
@property (strong, nonatomic) UILabel *personLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *phoneNumberLabel;

@end

@implementation FeedbackTableViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headerLeftLabel.text = @"类型：";
        self.headerRightLabel.text = @"状态：";
        
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
    self.titleLabel.frame = CGRectMake(20, CGRectGetMaxY(self.headerContainerView.frame), self.bounds.size.width - 20, self.bounds.size.height * 0.1);
    self.feedbackLabel.frame = CGRectMake(20, CGRectGetMaxY(self.titleLabel.frame), self.bounds.size.width - 20, self.bounds.size.height * 0.1);
    self.addressLabel.frame = CGRectMake(20, CGRectGetMaxY(self.feedbackLabel.frame), self.bounds.size.width - 20, self.bounds.size.height * 0.1);
    self.personLabel.frame = CGRectMake(20, CGRectGetMaxY(self.addressLabel.frame), self.bounds.size.width - 20, self.bounds.size.height * 0.1);
    self.timeLabel.frame = CGRectMake(20, CGRectGetMaxY(self.personLabel.frame), self.bounds.size.width - 20, self.bounds.size.height * 0.1);
    self.phoneNumberLabel.frame = CGRectMake(20, CGRectGetMaxY(self.timeLabel.frame), self.bounds.size.width - 20, self.bounds.size.height * 0.1);
}

@end

#pragma mark - View Controller

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"反馈信息";
}

#pragma mark - functions

- (void)fetch {
    [HTTPDataFetcher fetchFeedbackMessages:^(id messages) {
        if ([messages isKindOfClass:[NSDictionary class]]) {
            [[messages valueForKey:@"Rows"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                FeedBackMessage *message = [[FeedBackMessage alloc] init];
                message.feedback = [obj valueForKey:@"describeContent"];
                message.address = [obj valueForKey:@"building"];
                message.address = [message.address stringByAppendingString:[obj valueForKey:@"houseNumber"]];
                message.person = [obj valueForKey:@"ownerName"];
                message.time = [obj valueForKey:@"inputTime"];
                message.phoneNumber = [obj valueForKey:@"phone"];
                [self.data addObject:message];
            }];
            [self.tableView reloadData];
            [self.activityIndicatorView stopAnimating];
        }
    } AtPage:self.page WithSize:self.size];
}

#pragma mark - table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedbackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[FeedbackTableViewCell alloc] init];
    }
    
    if (self.data.count == 0) {
        return cell;
    }
    FeedBackMessage *message = [self.data objectAtIndex:indexPath.item];
    cell.feedbackLabel.text = [cell.feedbackLabel.text stringByAppendingString:message.feedback];
    cell.addressLabel.text = [cell.addressLabel.text stringByAppendingString:message.address];
    cell.personLabel.text = [cell.personLabel.text stringByAppendingString:message.person];
    cell.timeLabel.text = [cell.timeLabel.text stringByAppendingString:message.time];
    cell.phoneNumberLabel.text = [cell.phoneNumberLabel.text stringByAppendingString:message.phoneNumber];
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[FeedbackDetailViewController alloc] init] animated:YES];
}

@end
