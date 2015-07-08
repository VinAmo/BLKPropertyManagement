//
//  MaintenanceChangeProgressViewController.h
//  BLKPropertyManagement
//
//  Created by blk01 on 15/7/2.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

/**
 *  @author V, 15-07-07 11:07:40
 *
 *  修改维修进度，接单事件按钮触发事件
 */

#import <UIKit/UIKit.h>
#import "MaintenanceMessage.h"

@interface MaintenanceChangeProgressViewController : UIViewController

@property (strong, nonatomic) MaintenanceMessage *message;

@end
