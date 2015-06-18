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
        _headerLeftLabel.textAlignment = NSTextAlignmentCenter;
        _headerLeftLabel.adjustsFontSizeToFitWidth = YES;
        [_headerContainerView addSubview:_headerLeftLabel];
        
        _headerLeftAssociateLabel = [[UILabel alloc] init];
        [_headerContainerView addSubview:_headerLeftAssociateLabel];
        
        _headerRightLabel = [[UILabel alloc] init];
        _headerRightLabel.textColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:255/255.f alpha:1];
        _headerRightLabel.textAlignment = NSTextAlignmentCenter;
        _headerRightLabel.adjustsFontSizeToFitWidth = YES;
        [_headerContainerView addSubview:_headerRightLabel];
        
        _headerRightAssociateLabel = [[UILabel alloc] init];
        [_headerContainerView addSubview:_headerRightAssociateLabel];
        
        _leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _leftButton.backgroundColor = [UIColor colorWithRed:30/255.f green:144/255.f blue:255/255.f alpha:1];
        _leftButton.tintColor = [UIColor whiteColor];
        _leftButton.layer.masksToBounds = YES;
        _leftButton.layer.cornerRadius = 5.f;
        _leftButton.hidden = YES;
        [self addSubview:_leftButton];
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _rightButton.backgroundColor = [UIColor redColor];
        _rightButton.tintColor = [UIColor whiteColor];
        _rightButton.layer.masksToBounds = YES;
        _rightButton.layer.cornerRadius = 5.f;
        _rightButton.hidden = YES;
        [self addSubview:_rightButton];
    }
    return self;
}

- (void)layoutSubviews {
    self.headerContainerView.frame = CGRectMake(20, 0, self.bounds.size.width - 40, self.bounds.size.height * 0.16);
    self.topDivisionLayer.frame = CGRectMake(0, CGRectGetMinY(self.headerContainerView.bounds), self.headerContainerView.bounds.size.width, 1);
    self.bottomDivisionLayer.frame = CGRectMake(0, CGRectGetMaxY(self.headerContainerView.bounds), self.headerContainerView.bounds.size.width, 1);
    self.headerLeftLabel.frame = CGRectMake(0, 0, self.headerContainerView.bounds.size.width * 0.16, self.headerContainerView.bounds.size.height);
    self.headerLeftAssociateLabel.frame = CGRectMake(CGRectGetMaxX(self.headerLeftLabel.frame), 0, self.headerContainerView.bounds.size.width * 0.45, self.headerContainerView.bounds.size.height);
    self.headerRightLabel.frame = CGRectMake(CGRectGetMaxX(self.headerLeftAssociateLabel.frame), 0, self.headerContainerView.bounds.size.width * 0.16, self.headerContainerView.bounds.size.height);
    self.headerRightAssociateLabel.frame = CGRectMake(CGRectGetMaxX(self.headerRightLabel.frame), 0, self.headerContainerView.bounds.size.width * 0.23, self.headerContainerView.bounds.size.height);
    self.leftButton.frame = CGRectMake(20, self.bounds.size.height * 0.88 - 10, 100, self.bounds.size.height * 0.12);
    self.rightButton.frame = CGRectMake(CGRectGetMaxX(self.leftButton.frame) + 20, CGRectGetMinY(self.leftButton.frame), 100, self.bounds.size.height * 0.12);
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
