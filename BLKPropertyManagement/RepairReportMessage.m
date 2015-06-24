//
//  RepairReportMessage.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/12.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "RepairReportMessage.h"

@implementation RepairReportMessage

- (void)setState:(NSString *)state {
    if (_state != state) {
        _state = state;
    }
    
    if ([_state isEqualToString:@"WAITFORAUDIT"]) {
        _state = @"待确认";
    }
    else if ([_state isEqualToString:@"WAITP"]) {
        _state = @"等待配件";
    }
    else if ([_state isEqualToString:@"RETURN"]) {
        _state = @"返回物管";
    }
    else if ([_state isEqualToString:@"WAITPROCESS"]) {
        _state = @"已提交";
    }
    else if ([_state isEqualToString:@"PROCESSING"]) {
        _state = @"维修中";
    }
    else if ([_state isEqualToString:@"PROCESSED"]) {
        _state = @"已完成";
    }
    else if ([_state isEqualToString:@"PROSTOP"]) {
        _state = @"已取消";
    }
    else {
        _state = @"未知";
    }
}

@end
