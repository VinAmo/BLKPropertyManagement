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

+ (void)fetchLoginMessages:(void (^)(id messages))callback withUsername:(NSString *)username password:(NSString *)password;

+ (void)fetchRepairReportFilterMessages:(void (^)(id messages))callback;
+ (void)fetchMaintenanceFilterMessages:(void (^)(id messages))callback;
+ (void)fetchFeedbackFilterMessages:(void (^)(id messages))callback;

+ (void)fetchCommunityNoticeMessages:(void (^)(id messages))callback withPage:(NSUInteger)page size:(NSUInteger)size;
+ (void)fetchRepairReportMessages:(void (^)(id messages))callback withPage:(NSUInteger)page size:(NSUInteger)size category:(NSString *)category state:(NSString *)state;
+ (void)fetchMaintenanceMessages:(void (^)(id messages))callback withPage:(NSUInteger)page size:(NSUInteger)size category:(NSString *)category;
+ (void)fetchFeedbackMessages:(void (^)(id messages))callback withPage:(NSUInteger)page size:(NSUInteger)size category:(NSString *)category person:(NSString *)person;

+ (void)fetchRepairReportCompleteMessages:(void (^)(id messages))callback withReportIdentifier:(NSString *)identifier depiction:(NSString *)depiction time:(NSString *)time evaluation:(NSString *)evaluation;
+ (void)fetchRepairReportConfirmMessages:(void (^)(id messages))callback withReportIdentifier:(NSString *)identifier priority:(NSString *)priority content:(NSString *)content;
+ (void)fetchRepairReportChangePriorityMessages:(void (^)(id messages))callback withReportIdentifier:(NSString *)identifier priority:(NSString *)priority;
+ (void)fetchRepairReportCancelMessages:(void (^)(id messages))callback withReportIdentifier:(NSString *)identifier;
+ (void)fetchRepairReportImageMessages:(void (^)(id messages))callback withImageName:(NSString *)name;

+ (void)fetchFeedbackConfirmProcessMessages:(void (^)(id messages))callback withFeedbackIdentifier:(NSString *)identifier;
+ (void)fetchFeedbackCancelMessages:(void (^)(id messages))callback withFeedbackIdentifier:(NSString *)identifier;

@end
