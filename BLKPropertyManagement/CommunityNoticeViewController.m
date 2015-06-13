//
//  CommunityNoticeViewController.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/10.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "HTTPDataFetcher.h"
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
        _headerLeftLabel.textColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:255/255.f alpha:1];
        [_headerContainerView addSubview:_headerLeftLabel];
        
        _headerRightLabel = [[UILabel alloc] init];
        _headerRightLabel.textAlignment = NSTextAlignmentRight;
        _headerRightLabel.text = @"是否置顶：";
        _headerRightLabel.textColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:255/255.f alpha:1];
        [_headerContainerView addSubview:_headerRightLabel];
        
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont fontWithName:nil size:20]];
        [self addSubview:_titleLabel];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
//        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_contentLabel];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    // fix the frame of cells is different with its containers.
    self.headerContainerView.frame = CGRectMake(20, 0, self.bounds.size.width - 40, self.bounds.size.height * 0.2);
    self.headerLeftLabel.frame = CGRectMake(0, 0, self.headerContainerView.bounds.size.width * 0.7, self.headerContainerView.bounds.size.height);
    self.headerRightLabel.frame = CGRectMake(CGRectGetMaxX(self.headerLeftLabel.frame), 0, self.headerContainerView.bounds.size.width * 0.3, self.headerContainerView.bounds.size.height);
    self.titleLabel.frame = CGRectMake(20, CGRectGetMaxY(self.headerContainerView.frame), self.bounds.size.width - 40, self.bounds.size.height * 0.3);
    self.contentLabel.frame = CGRectMake(20, CGRectGetMaxY(self.titleLabel.frame), self.bounds.size.width - 40, self.bounds.size.height * 0.5);
}

@end

#pragma mark - View Controller

@interface CommunityNoticeViewController ()

@end

@implementation CommunityNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"社区公告";
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAddNoticeViewController)];
    self.navigationItem.rightBarButtonItem = addBarButtonItem;
}

#pragma mark - functions

- (void)fetch {
    [HTTPDataFetcher fetchCommunityNoticeMessages:^(id messages) {
        if ([messages isKindOfClass:[NSArray class]]) {
            [messages enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                CommunityNotice *notice = [[CommunityNotice alloc] init];
                notice.title = [obj valueForKey:@"title"];
                notice.content = [obj valueForKey:@"content"];
                notice.dueDate = [obj valueForKey:@"timeliness"];
                notice.top = [[obj valueForKey:@"isTop"] boolValue];
                [self.data addObject:notice];
            }];
            [self.tableView reloadData];
            [self.activityIndicatorView stopAnimating];
        }
    } AtPage:self.page WithSize:self.size];
}

- (void)showAddNoticeViewController {
    [self.navigationController pushViewController:[[AddNoticeViewController alloc] init] animated:YES];
}

#pragma mark - table view data source


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommunityNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[CommunityNoticeTableViewCell alloc] init];
    }
    
    if (self.data.count == 0) {
        return cell;
    }
    CommunityNotice *notice = [self.data objectAtIndex:indexPath.item];
    cell.headerLeftLabel.text = [cell.headerLeftLabel.text stringByAppendingString:[notice.dueDate isEqual:[NSNull null]] ? @"" : notice.dueDate];
    cell.headerRightLabel.text = [cell.headerRightLabel.text stringByAppendingString:notice.isTop ? @"是" : @"否"];
    cell.titleLabel.text = notice.title;
    cell.contentLabel.text = notice.content;
    
    return cell;
}

#pragma mark - table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[NoticeDetailViewController alloc] init] animated:YES];
}

@end