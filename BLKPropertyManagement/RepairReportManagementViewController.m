//
//  RepairReportManagementViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/4.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "HTTPDataFetcher.h"
#import "RepairReportMessage.h"
#import "BaseTableViewCell.h"
#import "RepairReportManagementViewController.h"
#import "RepairReportDetailViewController.h"

#pragma mark - Table View Cell

@interface RepairReportManagementTableViewCell : BaseTableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *housingTypeLabel;
@property (strong, nonatomic) UILabel *buildingNumberLabel;
@property (strong, nonatomic) UILabel *reporterLabel;
@property (strong, nonatomic) UILabel *scheduleTimeLabel;
@property (strong, nonatomic) UILabel *phoneNumberLabel;

@end

@implementation RepairReportManagementTableViewCell

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

@interface RepairReportManagementViewController ()

@end

@implementation RepairReportManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"报修管理";
}

#pragma mark - functions

- (void)fetch {
    [HTTPDataFetcher fetchRepairReportFilterMessages:^(id messages) {
        if ([messages isKindOfClass:[NSDictionary class]]) {
            [[messages valueForKey:@"state"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                [self.dataFilter addObject:[obj valueForKey:@"type_code"]];
            }];
            [[messages valueForKey:@"type"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                [self.dataFilter addObject:[obj valueForKey:@"type_code"]];
            }];
            [self.dropDownMenu reloadData];
        }
    }];
    
    [HTTPDataFetcher fetchRepairReportMessages:^(id messages) {
        if ([messages isKindOfClass:[NSDictionary class]]) {
            [[messages valueForKey:@"Rows"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                RepairReportMessage *message = [[RepairReportMessage alloc] init];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    if ([tableView isEqual:self.dropDownMenu]) {
        if (self.dataFilter.count == 0) {
            return cell;
        }

        cell.textLabel.text = self.dataFilter[indexPath.item];
        return cell;
    }
    else if ([tableView isEqual:self.tableView]) {
        RepairReportManagementTableViewCell *subCell = [tableView dequeueReusableCellWithIdentifier:@"SubCell"];
        if (!subCell) {
            subCell = [[RepairReportManagementTableViewCell alloc] init];
        }
        
        if (self.data.count == 0) {
            return subCell;
        }
        
//        RepairReportMessage *message = self.data[indexPath.item];
//        subCell.housingTypeLabel.text = [subCell.housingTypeLabel.text stringByAppendingString:message.housingType];
//        subCell.buildingNumberLabel.text = [subCell.buildingNumberLabel.text stringByAppendingString:message.buildingNumber];
//        subCell.reporterLabel.text = [subCell.reporterLabel.text stringByAppendingString:message.reporter];
//        subCell.scheduleTimeLabel.text = [subCell.scheduleTimeLabel.text stringByAppendingString:message.scheduleTime];
//        subCell.phoneNumberLabel.text = [subCell.phoneNumberLabel.text stringByAppendingString:message.phoneNumber];
        return subCell;
    }
    else {
        return cell;
    }
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.dropDownMenu]) {
        
    }
    else if ([tableView isEqual:self.tableView]) {
        [self.navigationController pushViewController:[[RepairReportDetailViewController alloc] init] animated:YES];
    }
    else {
        
    }
}

@end
