//
//  DropDownMenu.h
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/15.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DropDownMenu;

@protocol DropDownMenuDelegate <NSObject>

- (void)dropDownMenu:(DropDownMenu *)dropDownMenu didSelectRowAtIndex:(NSUInteger)index;

@end

@interface DropDownMenu : UITableView

@property (strong, nonatomic) id <DropDownMenuDelegate> delegate;

@property (assign, nonatomic, getter=isVisible) BOOL visible;

- (void)show;
- (void)hide;

@end
