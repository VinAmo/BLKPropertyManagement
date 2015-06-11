//
//  RepairReportManagementViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/4.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "HTTPDataFetcher.h"
#import "RepairReportManagementViewController.h"
#import "RepairReportDetailViewController.h"

@interface RepairReportManagementTableViewCell : UITableViewCell

@property (strong, nonatomic) UIView *headerContainerView;
@property (strong, nonatomic) UILabel *headerLeftLabel;
@property (strong, nonatomic) UILabel *headerRightLabel;

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
        _headerContainerView = [[UIView alloc] init];
        [self addSubview:_headerContainerView];
        
        _headerLeftLabel = [[UILabel alloc] init];
        _headerLeftLabel.text = @"编号：";
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
    self.headerContainerView.frame = CGRectMake(20, 0, self.bounds.size.width - 20, self.bounds.size.height * 0.1);
    self.headerLeftLabel.frame = CGRectMake(0, 0, self.headerContainerView.bounds.size.width * 0.7, self.headerContainerView.bounds.size.height);
    self.headerRightLabel.frame = CGRectMake(CGRectGetMaxX(self.headerLeftLabel.frame), 0, self.headerContainerView.bounds.size.width * 0.3, self.headerContainerView.bounds.size.height);
    
    self.titleLabel.frame = CGRectMake(20, CGRectGetMaxY(self.headerContainerView.frame), self.bounds.size.width - 20, self.bounds.size.height * 0.1);
    self.housingTypeLabel.frame = CGRectMake(20, CGRectGetMaxY(self.titleLabel.frame), self.bounds.size.width - 20, self.bounds.size.height * 0.1);
    self.buildingNumberLabel.frame = CGRectMake(20, CGRectGetMaxY(self.housingTypeLabel.frame), self.bounds.size.width - 20, self.bounds.size.height * 0.1);
    self.reporterLabel.frame = CGRectMake(20, CGRectGetMaxY(self.buildingNumberLabel.frame), self.bounds.size.width - 20, self.bounds.size.height * 0.1);
    self.scheduleTimeLabel.frame = CGRectMake(20, CGRectGetMaxY(self.reporterLabel.frame), self.bounds.size.width - 20, self.bounds.size.height * 0.1);
    self.phoneNumberLabel.frame = CGRectMake(20, CGRectGetMaxY(self.scheduleTimeLabel.frame), self.bounds.size.width - 20, self.bounds.size.height * 0.1);
}

@end

@interface RepairReportManagementViewController () <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) NSUInteger page;
@property (assign, nonatomic) NSUInteger size;

@end

@implementation RepairReportManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"报修管理";
    
    self.page = 0; // default
    self.size = 10; // default
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RepairReportManagementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[RepairReportManagementTableViewCell alloc] init];
        
        if (indexPath.item > self.page * self.size) {
            __weak typeof(cell) weakCell = cell;
            [HTTPDataFetcher fetchRepairReportMessages:^(id messages) {
                if ([messages isKindOfClass:[NSDictionary class]]) {
                    NSArray *messagesArr = [messages valueForKey:@"Rows"];
                    NSDictionary *message = messagesArr[indexPath.item];
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        weakCell.housingTypeLabel.text = [weakCell.housingTypeLabel.text stringByAppendingString:[message valueForKey:@"category"]];
                        weakCell.buildingNumberLabel.text = [weakCell.buildingNumberLabel.text stringByAppendingString:[message valueForKey:@"houseAdd"]];
                        weakCell.reporterLabel.text = [weakCell.reporterLabel.text stringByAppendingString:[message valueForKey:@"employeeName"]];
                        weakCell.scheduleTimeLabel.text = [weakCell.scheduleTimeLabel.text stringByAppendingString:[message valueForKey:@"appointmentTime"]];
                        weakCell.phoneNumberLabel.text = [weakCell.phoneNumberLabel.text stringByAppendingString:[message valueForKey:@"employeePhone"]];
//                        [tableView reloadData];
                    }];
                }
            } AtPage:++self.page WithSize:self.size];
            NSAssert(self.page > 1, @"%lu %lu" , self.page, self.size);
        }
    }
    return cell;
}

#pragma mark - table view delegate

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.item > self.page * self.size) {
//        RepairReportManagementTableViewCell *subCell = (RepairReportManagementTableViewCell *)cell;
//        
//        __weak typeof(subCell) weakCell = subCell;
//        [HTTPDataFetcher fetchRepairReportMessages:^(id messages) {
//            if ([messages isKindOfClass:[NSDictionary class]]) {
//                NSArray *messagesArr = [messages valueForKey:@"Rows"];
//                NSDictionary *message = messagesArr[indexPath.item];
//                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                    weakCell.housingTypeLabel.text = [weakCell.housingTypeLabel.text stringByAppendingString:[message valueForKey:@"category"]];
//                    weakCell.buildingNumberLabel.text = [weakCell.buildingNumberLabel.text stringByAppendingString:[message valueForKey:@"houseAdd"]];
//                    weakCell.reporterLabel.text = [weakCell.reporterLabel.text stringByAppendingString:[message valueForKey:@"employeeName"]];
//                    weakCell.scheduleTimeLabel.text = [weakCell.scheduleTimeLabel.text stringByAppendingString:[message valueForKey:@"appointmentTime"]];
//                    weakCell.phoneNumberLabel.text = [weakCell.phoneNumberLabel.text stringByAppendingString:[message valueForKey:@"employeePhone"]];
//                }];
//            }
//        } AtPage:++self.page WithSize:self.size];
//        NSLog(@"%lu %lu", self.page, self.size);
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[RepairReportDetailViewController alloc] init] animated:YES];
}

@end
