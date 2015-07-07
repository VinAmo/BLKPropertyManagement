//
//  DropDownMenu.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/15.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "DropDownMenu.h"

@implementation DropDownMenu

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.f;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 5.f;
    self.layer.shadowOpacity = 0.5f;
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.separatorColor = [UIColor grayColor];
    self.hidden = YES;
    self.visible = NO;
}

- (void)show {
//    [UIView animateWithDuration:0.5f animations:^{
//        self.hidden = NO;
//    } completion:^(BOOL finished) {
//        self.visible = YES;
//    }];
    [UIView transitionWithView:self
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^{
                        self.hidden = NO;
                    } completion:^(BOOL finished) {
                        self.visible = YES;
                    }];
}

- (void)hide {
    [UIView transitionWithView:self
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^{
                        self.hidden = YES;
                    } completion:^(BOOL finished) {
                        self.visible = NO;
                    }];
}

@end
