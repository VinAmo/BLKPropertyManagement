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

@property (strong, nonatomic) NSMutableArray *data;
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
    
    
    self.data = [NSMutableArray array];
    [HTTPDataFetcher fetchRepairReportMessages:^(id messages) {
        if ([messages isKindOfClass:[NSArray class]]) {
            [self.data  addObjectsFromArray:messages];
            NSLog(@"%@", messages);
            [tableView reloadData];
        }
    } AtPage:1 WithSize:10];
    
}

#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RepairReportManagementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[RepairReportManagementTableViewCell alloc] init];
        if (self.data.count == 0) {
            return cell;
        }
        NSDictionary *message = self.data[indexPath.item];
        cell.housingTypeLabel.text = [cell.housingTypeLabel.text stringByAppendingString:[message valueForKey:@"category"]];
        cell.buildingNumberLabel.text = [cell.buildingNumberLabel.text stringByAppendingString:[message valueForKey:@"houseAdd"]];
        cell.reporterLabel.text = [cell.reporterLabel.text stringByAppendingString:[message valueForKey:@"employeeName"]];
        cell.scheduleTimeLabel.text = [cell.scheduleTimeLabel.text stringByAppendingString:[message valueForKey:@"appointmentTime"]];
        cell.phoneNumberLabel.text = [cell.phoneNumberLabel.text stringByAppendingString:[message valueForKey:@"employeePhone"]];
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
    [self.navigationController pushViewController:[[RepairReportDetailViewController alloc] init] animated:YES];
}

- (void)loadData {
    
}


@end
