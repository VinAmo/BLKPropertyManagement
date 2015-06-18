//
//  HTTPDataFetcher.h
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/10.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPDataFetcher : NSObject

+ (void)setCookies;
+ (void)deleteCookies;

+ (void)fetchRepairReportFilterMessages:(void (^)(id messages))callback;
+ (void)fetchFeedbackFilterMessages:(void (^)(id messages))callback;

+ (void)fetchCommunityNoticeMessages:(void (^)(id messages))callback withPage:(NSUInteger)page size:(NSUInteger)size;
+ (void)fetchRepairReportMessages:(void (^)(id messages))callback withPage:(NSUInteger)page size:(NSUInteger)size category:(NSString *)category state:(NSString *)state;
+ (void)fetchMaintenanceMessages:(void (^)(id messages))callback withPage:(NSUInteger)page size:(NSUInteger)size category:(NSString *)category state:(NSString *)state;
+ (void)fetchFeedbackMessages:(void (^)(id messages))callback withPage:(NSUInteger)page size:(NSUInteger)size category:(NSString *)category person:(NSString *)person;

+ (void)fetchRepairReportConfirmMessages:(void (^)(id messages))callback withReportIdentifier:(NSString *)identifier content:(NSString *)content time:(NSString *)time;
+ (void)fetchRepairReportCancelMessages:(void (^)(id messages))callback withReportIdentifier:(NSString *)identifier;

@end
