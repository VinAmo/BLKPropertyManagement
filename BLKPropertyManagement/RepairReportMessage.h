//
//  RepairReportMessage.h
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/12.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepairReportMessage : NSObject

@property (copy, nonatomic) NSString *housingType;
@property (copy, nonatomic) NSString *buildingNumber;
@property (copy, nonatomic) NSString *reporter;
@property (copy, nonatomic) NSString *scheduleTime;
@property (copy, nonatomic) NSString *phoneNumber;

@end
