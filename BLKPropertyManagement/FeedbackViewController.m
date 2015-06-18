//
//  FeedbackViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/4.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "HTTPDataFetcher.h"
#import "ProcessData.h"
#import "FeedBackMessage.h"
#import "BaseTableViewCell.h"
#import "FeedbackViewController.h"
#import "FeedbackDetailViewController.h"

#pragma mark - Table View Cell

@interface FeedbackTableViewCell : BaseTableViewCell

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
    self.feedbackLabel.frame = CGRectMake(20, CGRectGetMaxY(self.headerContainerView.frame) + 10, self.bounds.size.width - 20, self.bounds.size.height * 0.1);
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
    self.navigationItem.title = @"意见反馈";
    
    [HTTPDataFetcher fetchFeedbackFilterMessages:^(id messages) {
        if ([messages isKindOfClass:[NSArray class]]) {
            [messages enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                [self.dataFilter setValue:[obj valueForKey:@"shortDesc"] forKey:[obj valueForKey:@"typeCode"]];
            }];
            [self.dropDownMenu reloadData];
        }
    }];
}

#pragma mark - functions

- (void)loadData {
    NSLog(@"%@", self.type);
    [self.activityIndicatorView startAnimating];
    [HTTPDataFetcher setCookies];
    [HTTPDataFetcher fetchFeedbackMessages:^(id messages) {
        if ([messages isKindOfClass:[NSDictionary class]]) {
            [[messages valueForKey:@"Rows"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                NSDictionary *result = [ProcessData resultFromSource:obj];
                FeedBackMessage *message = [[FeedBackMessage alloc] init];
                message.category = [result valueForKey:@"shortDesc"];
                message.state = [result valueForKey:@"state"];
                message.feedback = [result valueForKey:@"describeContent"];
                message.address = [result valueForKey:@"building"];
                message.address = [message.address stringByAppendingString:[result valueForKey:@"houseNumber"]];
                message.person = [result valueForKey:@"ownerName"];
                message.time = [result valueForKey:@"inputTime"];
                message.phoneNumber = [result valueForKey:@"phone"];
                [self.data addObject:message];
            }];
            [self.activityIndicatorView stopAnimating];
            [self.tableView reloadData];
        }
    } withPage:self.page size:self.size category:self.type person:self.person];
    [HTTPDataFetcher deleteCookies];
    self.page++;
}

- (void)confirmFeedback {
    
}

- (void)cancelFeedback {
    [[[UIAlertView alloc] initWithTitle:@"提示"
                                message:@"是否取消反馈？"
                               delegate:self
                      cancelButtonTitle:@"取消"
                      otherButtonTitles:@"确定", nil] show];
}

#pragma mark - table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    if ([tableView isEqual:self.dropDownMenu]) {
        if (self.dataFilter.count == 0) {
            return cell;
        }
        
        cell.textLabel.text = [self.dataFilter allValues][indexPath.item];
        return cell;
    }
    else if ([tableView isEqual:self.tableView]) {
        FeedbackTableViewCell *subCell = [tableView dequeueReusableCellWithIdentifier:@"SubCell"];
        if (!subCell) {
            subCell = [[FeedbackTableViewCell alloc] init];
        }
        
        if (self.data.count == 0) {
            return subCell;
        }
        
        FeedBackMessage *message = self.data[indexPath.item];
        subCell.headerLeftAssociateLabel.text = message.category;
        subCell.headerRightAssociateLabel.text = message.state;
        subCell.feedbackLabel.text = [subCell.feedbackLabel.text stringByAppendingString:message.feedback];
        subCell.addressLabel.text = [subCell.addressLabel.text stringByAppendingString:message.address];
        subCell.personLabel.text = [subCell.personLabel.text stringByAppendingString:message.person];
        subCell.timeLabel.text = [subCell.timeLabel.text stringByAppendingString:message.time];
        subCell.phoneNumberLabel.text = [subCell.phoneNumberLabel.text stringByAppendingString:message.phoneNumber];
        
        if ([message.state isEqualToString:@"等待处理"]) {
            [subCell.leftButton setHidden:NO];
            [subCell.leftButton setTitle:@"确认处理" forState:UIControlStateNormal];
            [subCell.leftButton addTarget:self action:@selector(confirmFeedback) forControlEvents:UIControlEventTouchUpInside];
            
            [subCell.rightButton setHidden:NO];
            [subCell.rightButton setTitle:@"删除" forState:UIControlStateNormal];
            [subCell.rightButton addTarget:self action:@selector(cancelFeedback) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([message.state isEqualToString:@"处理中"]) {
            [subCell.leftButton setHidden:NO];
            [subCell.leftButton setTitle:@"处理中" forState:UIControlStateNormal];
        }
        else if ([message.state isEqualToString:@"已处理"]) {
            [subCell.leftButton setHidden:NO];
            [subCell.leftButton setTitle:@"已处理" forState:UIControlStateNormal];
        }
        else {
            
        }
        
        return subCell;
    }
    else {
        return cell;
    }
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.dropDownMenu]) {
        [self.data removeAllObjects];
        [self.tableView reloadData];
        
        self.page = 1;
        self.size = 10;
        self.type = [self.dataFilter allKeys][indexPath.item];
        [self loadData];
    }
    else if ([tableView isEqual:self.tableView]) {
        FeedbackDetailViewController *feedbackDetailViewController = [[FeedbackDetailViewController alloc] init];
        feedbackDetailViewController.message = self.data[indexPath.item];
        [self.navigationController pushViewController:feedbackDetailViewController animated:YES];
    }
    else {
        
    }
}

#pragma mark - alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            NSLog(@"取消");
            break;
            
        case 1:
            NSLog(@"确定");
            break;
            
        default:
            break;
    }
}

@end
