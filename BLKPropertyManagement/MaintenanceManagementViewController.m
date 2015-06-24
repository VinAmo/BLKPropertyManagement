//
//  MaintenanceManagementViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/4.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "HTTPDataFetcher.h"
#import "ProcessData.h"
#import "MaintenanceMessage.h"
#import "BaseTableViewCell.h"
#import "MaintenanceManagementViewController.h"
#import "MaintenanceDetailViewController.h"

#pragma mark - Table View Cell

@interface MaintenanceManagementTableViewCell : BaseTableViewCell

@property (strong, nonatomic) UILabel *typeLabel;
@property (strong, nonatomic) UILabel *buildingNumberLabel;
@property (strong, nonatomic) UILabel *reportContentLabel;
@property (strong, nonatomic) UILabel *reporterLabel;
@property (strong, nonatomic) UILabel *reportTimeLabel;
@property (strong, nonatomic) UILabel *phoneNumberLabel;

@end

@implementation MaintenanceManagementTableViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headerLeftLabel.text = @"编号：";
        self.headerRightLabel.text = @"状态：";
        
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.text = @"类型：";
        [self addSubview:_typeLabel];
        
        _buildingNumberLabel = [[UILabel alloc] init];
        _buildingNumberLabel.text = @"楼栋：";
        [self addSubview:_buildingNumberLabel];
        
        _reporterLabel = [[UILabel alloc] init];
        _reporterLabel.text = @"报修人：";
        [self addSubview:_reporterLabel];
        
        _reportContentLabel = [[UILabel alloc] init];
        _reportContentLabel.text = @"维修内容：";
        [self addSubview:_reportContentLabel];
        
        _reportTimeLabel = [[UILabel alloc] init];
        _reportTimeLabel.text = @"报修时间：";
        [self addSubview:_reportTimeLabel];
        
        _phoneNumberLabel = [[UILabel alloc] init];
        _phoneNumberLabel.text = @"联系电话：";
        [self addSubview:_phoneNumberLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // fix the frame of cells is different with its containers.
    self.typeLabel.frame = CGRectMake(20, CGRectGetMaxY(self.headerContainerView.frame) + 10, self.bounds.size.width - 40, self.bounds.size.height * 0.1);
    self.buildingNumberLabel.frame = CGRectMake(20, CGRectGetMaxY(self.typeLabel.frame), self.bounds.size.width - 40, self.bounds.size.height * 0.1);
    self.reporterLabel.frame = CGRectMake(20, CGRectGetMaxY(self.buildingNumberLabel.frame), self.bounds.size.width - 40, self.bounds.size.height * 0.1);
    self.reportContentLabel.frame = CGRectMake(20, CGRectGetMaxY(self.reporterLabel.frame), self.bounds.size.width - 40, self.bounds.size.height * 0.1);
    self.reportTimeLabel.frame = CGRectMake(20, CGRectGetMaxY(self.reportContentLabel.frame), self.bounds.size.width - 40, self.bounds.size.height * 0.1);
    self.phoneNumberLabel.frame = CGRectMake(20, CGRectGetMaxY(self.reportTimeLabel.frame), self.bounds.size.width - 40, self.bounds.size.height * 0.1);
}

@end

#pragma mark - View Controller

@interface MaintenanceManagementViewController ()

@end

@implementation MaintenanceManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"维修管理";
}

#pragma mark - functions

- (void)loadDataFilter {
    [HTTPDataFetcher fetchMaintenanceFilterMessages:^(id messages) {
        if ([messages isKindOfClass:[NSArray class]]) {NSLog(@"%@", messages);
            [messages enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                [self.dataFilter setValue:[obj valueForKey:@"employeeName"] forKey:[obj valueForKey:@"employeePkno"]];
            }];
            [self.dropDownMenu reloadData];
        }
    }];
}

- (void)loadData {
    [self.activityIndicatorView startAnimating];
    [HTTPDataFetcher setCookies];
    [HTTPDataFetcher fetchMaintenanceMessages:^(id messages) {
        if ([messages isKindOfClass:[NSDictionary class]]) {
            [[messages valueForKey:@"Rows"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                NSDictionary *result = [ProcessData resultFromSource:obj];
                MaintenanceMessage *message = [[MaintenanceMessage alloc] init];
                message.identifier = [result valueForKey:@"repairPkno"];
                message.orderNumber = [result valueForKey:@"orderNumber"];
                message.state = [result valueForKey:@"state"];
                message.type = [result valueForKey:@"category"];
                message.buildingNumber = [result valueForKey:@"houseAdd"];
                message.reporter = [result valueForKey:@"ownerName"];
                message.reportContent = [result valueForKey:@"repairContent"];
                message.reportTime = [result valueForKey:@"repairTime"];
                message.phoneNumber = [result valueForKey:@"phone"];
                message.repairer = [result valueForKey:@"employeeName"];
                [self.data  addObject:message];
            }];
            [self.activityIndicatorView stopAnimating];
            [self.tableView reloadData];
            
            if (self.data.count == 0) {
                [[[UIAlertView alloc] initWithTitle:@"提示"
                                            message:@"服务器提了一个问题！"
                                           delegate:self
                                  cancelButtonTitle:@"呵呵"
                                  otherButtonTitles:nil] show];
            }
        }
    } withPage:self.page size:self.size category:self.category];
    [HTTPDataFetcher deleteCookies];
    self.page++;
}

- (void)confirmMaintenance:(id)sender {
    UIButton *button = (UIButton *)sender;
    if ([button.superview isKindOfClass:[MaintenanceManagementTableViewCell class]]) {
        MaintenanceManagementTableViewCell *cell = (MaintenanceManagementTableViewCell *)button.superview;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSLog(@"%lu", indexPath.item);
    }
}

- (void)cancelMaintenance:(id)sender {
    UIAlertView *alertView =  [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:@"是否确定取消报修？"
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:@"确定", nil];
    [alertView show];
    
    UIButton *button = (UIButton *)sender;
    if ([button.superview isKindOfClass:[MaintenanceManagementTableViewCell class]]) {
        MaintenanceManagementTableViewCell *cell = (MaintenanceManagementTableViewCell *)button.superview;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        alertView.tag = indexPath.item;
    }
}

- (void)showMaintenanceDetail {
    
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
        MaintenanceManagementTableViewCell *subCell = [tableView dequeueReusableCellWithIdentifier:@"SubCell"];
        if (!subCell) {
            subCell = [[MaintenanceManagementTableViewCell alloc] init];
        }
        
        if (self.data.count == 0) {
            return subCell;
        }
        
        MaintenanceMessage *message = self.data[indexPath.item];
        subCell.headerLeftAssociateLabel.text = message.orderNumber;
        subCell.headerRightAssociateLabel.text = message.state;
        subCell.typeLabel.text = [subCell.typeLabel.text stringByAppendingString:message.type];
        subCell.buildingNumberLabel.text = [subCell.buildingNumberLabel.text stringByAppendingString:message.buildingNumber];
        subCell.reporterLabel.text = [subCell.reporterLabel.text stringByAppendingString:message.reporter];
        subCell.reportContentLabel.text = [subCell.reportContentLabel.text stringByAppendingString:message.reportContent];
        subCell.reportTimeLabel.text = [subCell.reportTimeLabel.text stringByAppendingString:message.reportTime];
        subCell.phoneNumberLabel.text = [subCell.phoneNumberLabel.text stringByAppendingString:message.phoneNumber];
        
        if ([message.state isEqualToString:@"等待审核"]) {
            
        }
        else if ([message.state isEqualToString:@"等待配件"]) {
            
        }
        else if ([message.state isEqualToString:@"返回物管"]) {
            [subCell.leftButton setHidden:NO];
            [subCell.leftButton setBackgroundColor:[UIColor redColor]];
            [subCell.leftButton setTitle:@"取消维修" forState:UIControlStateNormal];
            [subCell.leftButton addTarget:self action:@selector(cancelMaintenance:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([message.state isEqualToString:@"已提交工程部"]) {
            [subCell.leftButton setHidden:NO];
            [subCell.leftButton setTitle:@"确认维修单" forState:UIControlStateNormal];
            [subCell.leftButton addTarget:self action:@selector(confirmMaintenance:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([message.state isEqualToString:@"已安排维修"]) {
            
        }
        else if ([message.state isEqualToString:@"已完成"]) {
            [subCell.leftButton setHidden:NO];
            [subCell.leftButton setTitle:@"维修单" forState:UIControlStateNormal];
            [subCell.leftButton addTarget:self action:@selector(showMaintenanceDetail) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([message.state isEqualToString:@"已关闭"]) {
            [subCell.leftButton setHidden:NO];
            [subCell.leftButton setTitle:@"维修单" forState:UIControlStateNormal];
            [subCell.leftButton addTarget:self action:@selector(showMaintenanceDetail) forControlEvents:UIControlEventTouchUpInside];
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
        self.state = [self.dataFilter allKeys][indexPath.item];
        [self loadData];
    }
    else if ([tableView isEqual:self.tableView]) {
        MaintenanceDetailViewController *maintenanceDetailViewController = [[MaintenanceDetailViewController alloc] init];
        maintenanceDetailViewController.message = self.data[indexPath.item];
        [self.navigationController pushViewController:maintenanceDetailViewController animated:YES];
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