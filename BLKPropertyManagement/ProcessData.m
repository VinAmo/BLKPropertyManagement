//
//  ProcessData.m
//  BLKPropertyManagement
//
//  Created by V on 16/06/2015.
//  Copyright (c) 2015 BLK. All rights reserved.
//

#import "ProcessData.h"

@implementation ProcessData

+ (NSDictionary *)resultFromSource:(NSDictionary *)source {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    [source enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([key isEqual:[NSNull null]]) {
            key = @"";
        }
        if ([obj isEqual:[NSNull null]]) {
            obj = @"";
        }
        [result setObject:obj forKey:key];
    }];
    return result;
}

@end
