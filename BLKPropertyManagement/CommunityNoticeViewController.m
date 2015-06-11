//
//  CommunityNoticeViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/10.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "HTTPDataFetcher.h"
#import "UITableView+Associate.h"
#import "CommunityNotice.h"
#import "CommunityNoticeViewController.h"
#import "NoticeDetailViewController.h"
#import "AddNoticeViewController.h"

#pragma mark - Table View Cell

@interface CommunityNoticeTableViewCell : UITableViewCell

@property (strong, nonatomic) UIView *headerContainerView;
@property (strong, nonatomic) UILabel *headerLeftLabel;
@property (strong, nonatomic) UILabel *headerRightLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *contentLabel;

@property (strong, nonatomic) CommunityNotice *notice;

@end

@implementation CommunityNoticeTableViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        _headerContainerView = [[UIView alloc] init];
        [self addSubview:_headerContainerView];
        
        _headerLeftLabel = [[UILabel alloc] init];
        _headerLeftLabel.text = @"失效时间：";
        _headerLeftLabel.textColor = [UIColor blueColor];
        [_headerContainerView addSubview:_headerLeftLabel];
        
        _headerRightLabel = [[UILabel alloc] init];
        _headerRightLabel.textAlignment = NSTextAlignmentRight;
        _headerRightLabel.text = @"是否置顶：";
        _headerRightLabel.textColor = [UIColor blueColor];
        [_headerContainerView addSubview:_headerRightLabel];
        
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont fontWithName:nil size:20]];
        [self addSubview:_titleLabel];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.backgroundColor = [UIColor lightGrayColor];
        _contentLabel.numberOfLines = 0;
        //        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_contentLabel];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    // fix the frame of cells is different with its containers.
    self.headerContainerView.frame = CGRectMake(20, 0, self.bounds.size.width - 20, self.bounds.size.height * 0.2);
    self.headerLeftLabel.frame = CGRectMake(0, 0, self.headerContainerView.bounds.size.width * 0.7, self.headerContainerView.bounds.size.height);
    self.headerRightLabel.frame = CGRectMake(CGRectGetMaxX(self.headerLeftLabel.frame), 0, self.headerContainerView.bounds.size.width * 0.3, self.headerContainerView.bounds.size.height);
    self.titleLabel.frame = CGRectMake(20, CGRectGetMaxY(self.headerContainerView.frame), self.bounds.size.width - 40, self.bounds.size.height * 0.3);
    self.contentLabel.frame = CGRectMake(20, CGRectGetMaxY(self.titleLabel.frame), self.bounds.size.width - 40, self.bounds.size.height * 0.5);
    
    self.titleLabel.text = self.notice.title;
    self.contentLabel.text = self.notice.content;
}

@end

#pragma mark - View Controller

@interface CommunityNoticeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation CommunityNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"社区公告";
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAddNoticeViewController)];
    self.navigationItem.rightBarButtonItem = addBarButtonItem;
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = self.view.bounds;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [self loadData];
}

#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableView.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommunityNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[CommunityNoticeTableViewCell alloc] init];
    }
    cell.notice = [self.tableView.data objectAtIndex:indexPath.item];
    
    return cell;
}

#pragma mark - table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self.navigationController pushViewController:[[NoticeDetailViewController alloc] init] animated:YES];
//}

#pragma mark - functions

- (void)loadData {
    [HTTPDataFetcher fetchCommunityNoticeMessages:^(id messages) {
        if ([messages isKindOfClass:[NSArray class]]) {
            [messages enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                CommunityNotice *notice = [[CommunityNotice alloc] init];
                notice.title = [obj valueForKey:@"title"];
                notice.content = [obj valueForKey:@"content"];
                notice.dueDate = [obj valueForKey:@"timeliness"];
                notice.top = [[obj valueForKey:@"isTop"] boolValue];
                [self.tableView.data addObject:notice];
            }];
            [self.tableView reloadData];
        }
    } AtPage:1 WithSize:10];
    
}

- (void)showAddNoticeViewController {
    [self.navigationController pushViewController:[[AddNoticeViewController alloc] init] animated:YES];
}

@end
