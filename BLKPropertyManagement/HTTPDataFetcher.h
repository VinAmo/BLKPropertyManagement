//
//  HTTPDataFetcher.h
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/10.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

/**
 *  @author V, 15-07-07 11:07:13
 *
 *  网络请求
 */

#import <Foundation/Foundation.h>

@interface HTTPDataFetcher : NSObject

+ (void)setCookies;
+ (void)deleteCookies;

// 请求登陆
+ (void)fetchLoginMessages:(void (^)(id messages))callback withUsername:(NSString *)username password:(NSString *)password;

// 请求筛选条件数据
+ (void)fetchRepairReportFilterMessages:(void (^)(id messages))callback;
+ (void)fetchMaintenanceFilterMessages:(void (^)(id messages))callback;
+ (void)fetchFeedbackFilterMessages:(void (^)(id messages))callback;

// 请求主要数据（填充各模块主界面table view）
+ (void)fetchCommunityNoticeMessages:(void (^)(id messages))callback withPage:(NSUInteger)page size:(NSUInteger)size;
+ (void)fetchRepairReportMessages:(void (^)(id messages))callback withPage:(NSUInteger)page size:(NSUInteger)size category:(NSString *)category state:(NSString *)state;
+ (void)fetchMaintenanceMessages:(void (^)(id messages))callback withPage:(NSUInteger)page size:(NSUInteger)size category:(NSString *)category;
+ (void)fetchFeedbackMessages:(void (^)(id messages))callback withPage:(NSUInteger)page size:(NSUInteger)size category:(NSString *)category person:(NSString *)person;

// 请求用户操作数据（通过cell中的button响应事件）
+ (void)fetchRepairReportCompleteMessages:(void (^)(id messages))callback withReportIdentifier:(NSString *)identifier depiction:(NSString *)depiction time:(NSString *)time evaluation:(NSString *)evaluation;
+ (void)fetchRepairReportConfirmMessages:(void (^)(id messages))callback withReportIdentifier:(NSString *)identifier priority:(NSString *)priority content:(NSString *)content;
+ (void)fetchRepairReportChangePriorityMessages:(void (^)(id messages))callback withReportIdentifier:(NSString *)identifier priority:(NSString *)priority;
+ (void)fetchRepairReportCancelMessages:(void (^)(id messages))callback withReportIdentifier:(NSString *)identifier;
+ (void)fetchRepairReportImageMessages:(void (^)(id messages))callback withImageName:(NSString *)name;

+ (void)fetchFeedbackConfirmProcessMessages:(void (^)(id messages))callback withFeedbackIdentifier:(NSString *)identifier;
+ (void)fetchFeedbackCancelMessages:(void (^)(id messages))callback withFeedbackIdentifier:(NSString *)identifier;

@end
