//
//  RepairReportManagementViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/4.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "HTTPDataFetcher.h"
#import "ProcessData.h"
#import "RepairReportMessage.h"
#import "BaseTableViewCell.h"
#import "RepairReportManagementViewController.h"
#import "RepairReportDetailViewController.h"
#import "RepairReportCompleteViewController.h"
#import "RepairReportConfirmViewController.h"
#import "RepairReportChangePriorityViewController.h"

#pragma mark - Table View Cell

@interface RepairReportManagementTableViewCell : BaseTableViewCell

@property (strong, nonatomic) UILabel *typeLabel;
@property (strong, nonatomic) UILabel *buildingNumberLabel;
@property (strong, nonatomic) UILabel *reportContentLabel;
@property (strong, nonatomic) UILabel *reporterLabel;
@property (strong, nonatomic) UILabel *reportTimeLabel;
@property (strong, nonatomic) UILabel *phoneNumberLabel;

@end

@implementation RepairReportManagementTableViewCell

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
        _reportContentLabel.text = @"报修原因：";
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

@interface RepairReportManagementViewController ()

@end

@implementation RepairReportManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"报修管理";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.page = 1;
    self.size = 10;
    [self loadData];
}

#pragma mark - functions

- (void)loadDataFilter {
    [HTTPDataFetcher setCookies];
    [HTTPDataFetcher fetchRepairReportFilterMessages:^(id messages) {
        if ([messages isKindOfClass:[NSDictionary class]]) {
            [[messages valueForKey:@"state"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                [self.dataFilter setValue:[obj valueForKey:@"short_desc"] forKey:[obj valueForKey:@"type_code"]];
            }];
            [[messages valueForKey:@"type"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                
            }];
            [self.dropDownMenu reloadData];
        }
    }];
    [HTTPDataFetcher deleteCookies];
}

- (void)loadData {
    [self.activityIndicatorView startAnimating];
    [HTTPDataFetcher setCookies];
    [HTTPDataFetcher fetchRepairReportMessages:^(id messages) {
        if ([messages isKindOfClass:[NSDictionary class]]) {
            [[messages valueForKey:@"Rows"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                NSDictionary *result = [ProcessData resultFromSource:obj];
                RepairReportMessage *message = [[RepairReportMessage alloc] init];
                message.identifier = [result valueForKey:@"repairPkno"];
                message.orderNumber = [result valueForKey:@"orderNumber"];
                message.priority = [result valueForKey:@"typeCode"];
                message.state = [result valueForKey:@"state"];
                message.type = [result valueForKey:@"category"];
                message.depiction = [result valueForKey:@"maintenanceDescribe"];
                message.evaluation = [result valueForKey:@"isqualifiedFlag"];
                message.depiction = [result valueForKey:@"completeTime"];
                message.buildingNumber = [result valueForKey:@"houseAdd"];
                message.reporter = [result valueForKey:@"ownerName"];
                message.reportContent = [result valueForKey:@"repairContent"];
                message.repairContent = [result valueForKey:@"repairDescribe"];
                message.reportTime = [result valueForKey:@"repairTime"];
                message.phoneNumber = [result valueForKey:@"phone"];
                message.repairer = [result valueForKey:@"employeeName"];
                message.appointTime = [result valueForKey:@"appointmentTime"];
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
    } withPage:self.page size:self.size category:self.category state:self.state];
    [HTTPDataFetcher deleteCookies];
    self.page++;
}

- (void)completeRepairReport:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    if ([button.superview isKindOfClass:[RepairReportManagementTableViewCell class]]) {
        RepairReportManagementTableViewCell *cell = (RepairReportManagementTableViewCell *)button.superview;
        indexPath = [self.tableView indexPathForCell:cell];
    }
    
    RepairReportCompleteViewController *repairReportCompleteViewController = [[RepairReportCompleteViewController alloc] init];
    repairReportCompleteViewController.message = self.data[indexPath.item];
    [self.navigationController pushViewController:repairReportCompleteViewController animated:YES];
}

- (void)confirmRepairReport:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    if ([button.superview isKindOfClass:[RepairReportManagementTableViewCell class]]) {
        RepairReportManagementTableViewCell *cell = (RepairReportManagementTableViewCell *)button.superview;
        indexPath = [self.tableView indexPathForCell:cell];
    }
    
    RepairReportConfirmViewController *repairReportConfirmViewController = [[RepairReportConfirmViewController alloc] init];
    repairReportConfirmViewController.message = self.data[indexPath.item];
    [self.navigationController pushViewController:repairReportConfirmViewController animated:YES];
}

- (void)changePriority:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    if ([button.superview isKindOfClass:[RepairReportManagementTableViewCell class]]) {
        RepairReportManagementTableViewCell *cell = (RepairReportManagementTableViewCell *)button.superview;
        indexPath = [self.tableView indexPathForCell:cell];
    }
    
    RepairReportChangePriorityViewController *repairReportChangePriorityViewController = [[RepairReportChangePriorityViewController alloc] init];
    repairReportChangePriorityViewController.message = self.data[indexPath.item];
    [self.navigationController pushViewController:repairReportChangePriorityViewController animated:YES];
}

- (void)cancelRepairReport:(id)sender {
    UIAlertView *alertView =  [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:@"是否确定取消报修？"
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:@"确定", nil];
    [alertView show];
    
    UIButton *button = (UIButton *)sender;
    if ([button.superview isKindOfClass:[RepairReportManagementTableViewCell class]]) {
        RepairReportManagementTableViewCell *cell = (RepairReportManagementTableViewCell *)button.superview;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        alertView.tag = indexPath.item;
    }
}

- (void)showRepairReportDetail:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    if ([button.superview isKindOfClass:[RepairReportManagementTableViewCell class]]) {
        RepairReportManagementTableViewCell *cell = (RepairReportManagementTableViewCell *)button.superview;
        indexPath = [self.tableView indexPathForCell:cell];
    }
    RepairReportDetailViewController *repairReportDetailViewController = [[RepairReportDetailViewController alloc] init];
    repairReportDetailViewController.message = self.data[indexPath.item];
    [self.navigationController pushViewController:repairReportDetailViewController animated:YES];
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
        RepairReportManagementTableViewCell *subCell = [tableView dequeueReusableCellWithIdentifier:@"SubCell"];
        if (!subCell) {
            subCell = [[RepairReportManagementTableViewCell alloc] init];
        }
        
        if (self.data.count == 0) {
            return subCell;
        }
        
        RepairReportMessage *message = self.data[indexPath.item];
        subCell.headerLeftAssociateLabel.text = message.orderNumber;
        subCell.headerRightAssociateLabel.text = message.state;
        subCell.typeLabel.text = [subCell.typeLabel.text stringByAppendingString:message.type];
        subCell.buildingNumberLabel.text = [subCell.buildingNumberLabel.text stringByAppendingString:message.buildingNumber];
        subCell.reporterLabel.text = [subCell.reporterLabel.text stringByAppendingString:message.reporter];
        subCell.reportContentLabel.text = [subCell.reportContentLabel.text stringByAppendingString:message.reportContent];
        subCell.reportTimeLabel.text = [subCell.reportTimeLabel.text stringByAppendingString:message.reportTime];
        subCell.phoneNumberLabel.text = [subCell.phoneNumberLabel.text stringByAppendingString:message.phoneNumber];
        
        if ([message.state isEqualToString:@"待确认"]) {
            [subCell.leftButton setHidden:NO];
            [subCell.leftButton setTitle:@"确认申请" forState:UIControlStateNormal];
            [subCell.leftButton addTarget:self action:@selector(confirmRepairReport:) forControlEvents:UIControlEventTouchUpInside];
            [subCell.rightButton setHidden:NO];
            [subCell.rightButton setTitle:@"取消维修" forState:UIControlStateNormal];
            [subCell.rightButton addTarget:self action:@selector(cancelRepairReport:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([message.state isEqualToString:@"返回物管"]) {
            [subCell.leftButton setHidden:NO];
            [subCell.leftButton setBackgroundColor:[UIColor redColor]];
            [subCell.leftButton setTitle:@"不修原因" forState:UIControlStateNormal];
            [subCell.leftButton addTarget:self action:@selector(showRepairReportDetail:) forControlEvents:UIControlEventTouchUpInside];
            [subCell.rightButton setHidden:NO];
            [subCell.rightButton setTitle:@"取消维修" forState:UIControlStateNormal];
            [subCell.rightButton addTarget:self action:@selector(cancelRepairReport:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([message.state isEqualToString:@"已提交"]) {
            [subCell.leftButton setHidden:NO];
            [subCell.leftButton setBackgroundColor:[UIColor yellowColor]];
            [subCell.leftButton setTitle:@"修改等级" forState:UIControlStateNormal];
            [subCell.leftButton addTarget:self action:@selector(changePriority:) forControlEvents:UIControlEventTouchUpInside];
            [subCell.rightButton setHidden:NO];
            [subCell.rightButton setTitle:@"取消维修" forState:UIControlStateNormal];
            [subCell.rightButton addTarget:self action:@selector(cancelRepairReport:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([message.state isEqualToString:@"维修中"] || [message.state isEqualToString:@"等待配件"]) {
            [subCell.leftButton setHidden:NO];
            [subCell.leftButton setTitle:@"确认完成" forState:UIControlStateNormal];
            [subCell.leftButton addTarget:self action:@selector(completeRepairReport:) forControlEvents:UIControlEventTouchUpInside];
            [subCell.rightButton setHidden:NO];
            [subCell.rightButton setTitle:@"取消维修" forState:UIControlStateNormal];
            [subCell.rightButton addTarget:self action:@selector(cancelRepairReport:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([message.state isEqualToString:@"已完成"] || [message.state isEqualToString:@"已取消"]) {
            [subCell.leftButton setHidden:NO];
            [subCell.leftButton setTitle:@"维修单" forState:UIControlStateNormal];
            [subCell.leftButton addTarget:self action:@selector(showRepairReportDetail:) forControlEvents:UIControlEventTouchUpInside];
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
        RepairReportDetailViewController *repairReportDetailViewController = [[RepairReportDetailViewController alloc] init];
        repairReportDetailViewController.message = self.data[indexPath.item];
        [self.navigationController pushViewController:repairReportDetailViewController animated:YES];
    }
    else {
        
    }
}

#pragma mark - alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    RepairReportMessage *message = self.data[alertView.tag];
    switch (buttonIndex) {
        case 0:
            NSLog(@"取消");
            break;
            
        case 1:
            [HTTPDataFetcher setCookies];
            [HTTPDataFetcher fetchRepairReportCancelMessages:^(id messages) {
                NSLog(@"%@", messages);
            } withReportIdentifier:message.identifier];
            [HTTPDataFetcher deleteCookies];
            [self loadData];
            break;
            
        default:
            break;
    }
}

@end
