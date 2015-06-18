//
//  FeedBackMessage.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/12.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import "FeedBackMessage.h"

@implementation FeedBackMessage

- (void)setState:(NSString *)state {
    if (_state != state) {
        _state = state;
    }
    
    if ([_state isEqualToString:@"PROCESSED"]) {
        _state = @"已处理";
    }
    else if ([_state isEqualToString:@"WAITPROCESS"]) {
        _state = @"等待处理";
    }
    else if ([_state isEqualToString:@"PROCESSING"]) {
        _state = @"处理中";
    }
    else {
        _state = @"";
    }
}

@end
