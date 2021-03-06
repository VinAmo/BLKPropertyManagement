//
//  HTTPDataFetcher.h
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/10.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPDataFetcher : NSObject

+ (void)fetchCommunityNoticeMessages:(void (^)(id messages))callback AtPage:(NSUInteger)page WithSize:(NSUInteger)size;
+ (void)fetchRepairReportMessages:(void (^)(id messages))callback AtPage:(NSUInteger)page WithSize:(NSUInteger)size;
+ (void)fetchMaintenanceMessages:(void (^)(id messages))callback AtPage:(NSUInteger)page WithSize:(NSUInteger)size;
+ (void)fetchFeedbackMessages:(void (^)(id messages))callback AtPage:(NSUInteger)page WithSize:(NSUInteger)size;

@end
