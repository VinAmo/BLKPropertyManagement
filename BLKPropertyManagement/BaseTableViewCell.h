//
//  BaseTableViewCell.h
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/13.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@property (strong, nonatomic) UIView *headerContainerView;
@property (strong, nonatomic) CALayer *topDivisionLayer;
@property (strong, nonatomic) CALayer *bottomDivisionLayer;
@property (strong, nonatomic) UILabel *headerLeftLabel;
@property (strong, nonatomic) UILabel *headerLeftAssociateLabel;
@property (strong, nonatomic) UILabel *headerRightLabel;
@property (strong, nonatomic) UILabel *headerRightAssociateLabel;
@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *rightButton;

@end
