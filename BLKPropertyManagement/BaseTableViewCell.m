//
//  BaseTableViewCell.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/13.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        _headerContainerView = [[UIView alloc] init];
        [self addSubview:_headerContainerView];
        
        _topDivisionLayer = [[CALayer alloc] init];
        _topDivisionLayer.backgroundColor = [[UIColor lightGrayColor] CGColor];
        [_headerContainerView.layer addSublayer:_topDivisionLayer];
        
        _bottomDivisionLayer = [[CALayer alloc] init];
        _bottomDivisionLayer.backgroundColor = [[UIColor lightGrayColor] CGColor];
        [_headerContainerView.layer addSublayer:_bottomDivisionLayer];
        
        _headerLeftLabel = [[UILabel alloc] init];
        
        _headerLeftLabel.textColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:255/255.f alpha:1];
        [_headerContainerView addSubview:_headerLeftLabel];
        
        _headerRightLabel = [[UILabel alloc] init];
        //        _headerRightLabel.textAlignment = NSTextAlignmentRight;
        _headerRightLabel.textColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:255/255.f alpha:1];
        [_headerContainerView addSubview:_headerRightLabel];
    }
    return self;
}

- (void)layoutSubviews {
    self.headerContainerView.frame = CGRectMake(20, 0, self.bounds.size.width - 40, self.bounds.size.height * 0.2);
    self.topDivisionLayer.frame = CGRectMake(0, CGRectGetMinY(self.headerContainerView.bounds), self.headerContainerView.bounds.size.width, 1);
    self.bottomDivisionLayer.frame = CGRectMake(0, CGRectGetMaxY(self.headerContainerView.bounds), self.headerContainerView.bounds.size.width, 1);
    self.headerLeftLabel.frame = CGRectMake(0, 0, self.headerContainerView.bounds.size.width * 0.7, self.headerContainerView.bounds.size.height);
    self.headerRightLabel.frame = CGRectMake(CGRectGetMaxX(self.headerLeftLabel.frame), 0, self.headerContainerView.bounds.size.width * 0.3, self.headerContainerView.bounds.size.height);
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
