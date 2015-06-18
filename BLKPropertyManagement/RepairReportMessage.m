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
        _state = @"等待审核";
    }
    else if ([_state isEqualToString:@"WAITP"]) {
        _state = @"等待配件";
    }
    else if ([_state isEqualToString:@"RETURN"]) {
        _state = @"返回物管";
    }
    else if ([_state isEqualToString:@"WAITPROCESS"]) {
        _state = @"已提交工程部";
    }
    else if ([_state isEqualToString:@"PROCESSING"]) {
        _state = @"已安排维修";
    }
    else if ([_state isEqualToString:@"PROCESSED"]) {
        _state = @"已完成";
    }
    else if ([_state isEqualToString:@"PROSTOP"]) {
        _state = @"已关闭";
    }
    else {
        _state = @"未知";
    }
}

@end
