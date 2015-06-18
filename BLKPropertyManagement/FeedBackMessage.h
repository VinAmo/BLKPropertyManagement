//
//  FeedBackMessage.h
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/12.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedBackMessage : NSObject

@property (copy, nonatomic) NSString *category;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *feedback;
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *person;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *phoneNumber;

@end
