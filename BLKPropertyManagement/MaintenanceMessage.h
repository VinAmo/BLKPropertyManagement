//
//  MaintenanceMessage.h
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/13.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaintenanceMessage : NSObject

@property (copy, nonatomic) NSString *identifier;
@property (copy, nonatomic) NSString *orderNumber;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *reportContent;
@property (copy, nonatomic) NSString *buildingNumber;
@property (copy, nonatomic) NSString *reporter;
@property (copy, nonatomic) NSString *reportTime;
@property (copy, nonatomic) NSString *phoneNumber;
@property (copy, nonatomic) NSString *repairer;

@end
