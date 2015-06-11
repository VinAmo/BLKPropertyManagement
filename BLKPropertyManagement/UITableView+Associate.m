//
//  UITableView+Associate.m
//  BLKPropertyManagement
//
//  Created by blk01 on 15/6/11.
//  Copyright (c) 2015年 BLK. All rights reserved.
//

#import <objc/runtime.h>
#import "UITableView+Associate.h"

static const void *kUITableViewAssociateData = &kUITableViewAssociateData;

@implementation UITableView (Associate)

- (NSMutableArray *)data {
    return objc_getAssociatedObject(self, kUITableViewAssociateData);
}

- (void)setData:(NSMutableArray *)data {
    objc_setAssociatedObject(self, kUITableViewAssociateData, data, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
