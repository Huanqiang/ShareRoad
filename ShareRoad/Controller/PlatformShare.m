//
//  PlatformShare.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/3.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "PlatformShare.h"

@implementation PlatformShare

- (void)platformLogIn {}
- (void)cancelAuthWithPlatformType{}
- (NSString *)gainPlatformPersonName{
    return @"";
}
- (BOOL)isAuthWithPlatformType{
    return YES;
}

- (void)shareContext:(NSString *)publishString AndPublishImage:(UIImage *)publishImage  AndDealWithData:(dealWithShareContentDataBlock )dateBlock{}



@end
