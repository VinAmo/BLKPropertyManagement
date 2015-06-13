//
//  MaintenanceManagementViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/4.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "HTTPDataFetcher.h"
#import "MaintenanceMessage.h"
#import "BaseTableViewCell.h"
#import "MaintenanceManagementViewController.h"
#import "MaintenanceDetailViewController.h"

#pragma mark - Table View Cell

@interface MaintenanceManagementTableViewCell : BaseTableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *housingTypeLabel;
@property (strong, nonatomic) UILabel *buildingNumberLabel;
@property (strong, nonatomic) UILabel *reporterLabel;
@property (strong, nonatomic) UILabel *scheduleTimeLabel;
@property (strong, nonatomic) UILabel *phoneNumberLabel;

@end

@implementation MaintenanceManagementTableViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headerLeftLabel.text = @"编号：";
        self.headerRightLabel.text = @"状态：";
        
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont fontWithName:nil size:20]];
        [self addSubview:_titleLabel];
        
        _housingTypeLabel = [[UILabel alloc] init];
        _housingTypeLabel.text = @"房屋类型：";
        [self addSubview:_housingTypeLabel];
        
        _buildingNumberLabel = [[UILabel alloc] init];
        _buildingNumberLabel.text = @"楼栋：";
        [self addSubview:_buildingNumberLabel];
        
        _reporterLabel = [[UILabel alloc] init];
        _reporterLabel.text = @"报修人：";
        [self addSubview:_reporterLabel];
        
        _scheduleTimeLabel = [[UILabel alloc] init];
        _scheduleTimeLabel.text = @"预约时间：";
        [self addSubview:_scheduleTimeLabel];
        
        _phoneNumberLabel = [[UILabel alloc] init];
        _phoneNumberLabel.text = @"联系电话：";
        [self addSubview:_phoneNumberLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // fix the frame of cells is different with its containers.
    self.titleLabel.frame = CGRectMake(20, CGRectGetMaxY(self.headerContainerView.frame), self.bounds.size.width - 40, self.bounds.size.height * 0.1);
    self.housingTypeLabel.frame = CGRectMake(20, CGRectGetMaxY(self.titleLabel.frame), self.bounds.size.width - 40, self.bounds.size.height * 0.1);
    self.buildingNumberLabel.frame = CGRectMake(20, CGRectGetMaxY(self.housingTypeLabel.frame), self.bounds.size.width - 40, self.bounds.size.height * 0.1);
    self.reporterLabel.frame = CGRectMake(20, CGRectGetMaxY(self.buildingNumberLabel.frame), self.bounds.size.width - 40, self.bounds.size.height * 0.1);
    self.scheduleTimeLabel.frame = CGRectMake(20, CGRectGetMaxY(self.reporterLabel.frame), self.bounds.size.width - 40, self.bounds.size.height * 0.1);
    self.phoneNumberLabel.frame = CGRectMake(20, CGRectGetMaxY(self.scheduleTimeLabel.frame), self.bounds.size.width - 40, self.bounds.size.height * 0.1);
}

@end

#pragma mark - View Controller

@interface MaintenanceManagementViewController ()

@end

@implementation MaintenanceManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"报修管理";
}

#pragma mark - functions

- (void)fetch {
    [HTTPDataFetcher fetchMaintenanceMessages:^(id messages) {
        if ([messages isKindOfClass:[NSDictionary class]]) {
            [[messages valueForKey:@"Rows"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                MaintenanceMessage *message = [[MaintenanceMessage alloc] init];
                message.housingType = [obj valueForKey:@"category"];
                message.buildingNumber = [obj valueForKey:@"houseAdd"];
                message.reporter = [obj valueForKey:@"employeeName"];
                message.scheduleTime = [obj valueForKey:@"appointmentTime"];
                message.phoneNumber = [obj valueForKey:@"employeePhone"];
                [self.data  addObject:message];
            }];
            [self.tableView reloadData];
            [self.activityIndicatorView stopAnimating];
        }
    } AtPage:self.page WithSize:self.size];
}

#pragma mark - table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MaintenanceManagementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[MaintenanceManagementTableViewCell alloc] init];
    }
    
    if (self.data.count == 0) {
        return cell;
    }
    MaintenanceMessage *message = self.data[indexPath.item];
    cell.housingTypeLabel.text = [cell.housingTypeLabel.text stringByAppendingString:message.housingType];
    cell.buildingNumberLabel.text = [cell.buildingNumberLabel.text stringByAppendingString:message.buildingNumber];
    cell.reporterLabel.text = [cell.reporterLabel.text stringByAppendingString:message.reporter];
    cell.scheduleTimeLabel.text = [cell.scheduleTimeLabel.text stringByAppendingString:message.scheduleTime];
    cell.phoneNumberLabel.text = [cell.phoneNumberLabel.text stringByAppendingString:message.phoneNumber];
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[MaintenanceDetailViewController alloc] init] animated:YES];
}

@end