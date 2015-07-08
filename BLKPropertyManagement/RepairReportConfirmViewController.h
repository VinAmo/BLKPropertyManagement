//
//  RepairReportConfirmViewController.h
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/23.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

/**
 *  @author V, 15-07-07 11:07:34
 *
 *  报修申请，确认申请按钮触发事件
 *
 *  @param strong    <#strong description#>
 *  @param nonatomic <#nonatomic description#>
 *
 *  @return <#return value description#>
 */

#import <UIKit/UIKit.h>
#import "RepairReportMessage.h"

@interface RepairReportConfirmViewController : UIViewController

@property (strong, nonatomic) RepairReportMessage *message;

@end
