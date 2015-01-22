//
//  WeiboShare.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/3.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "WeiboShare.h"

@implementation WeiboShare

- (void)platformLogIn {
    [[ShareContentWithShareSDK shareInstance] shareContent:@"我正在使用“路况知音”APP" AndPublishImage:nil AndSharePlatformType:ShareTypeSinaWeibo AndDealWithData:^{        
    }];
}

- (void)cancelAuthWithPlatformType {
    [[ShareContentWithShareSDK shareInstance] cancelAuthWithPlatformType:ShareTypeSinaWeibo];
}

- (NSString *)gainPlatformPersonName {
    NSString *name = [[[ShareContentWithShareSDK shareInstance] getCurrentUser:ShareTypeSinaWeibo] nickname];
    return name;
}

- (BOOL)isAuthWithPlatformType {
    BOOL isAuth = [[ShareContentWithShareSDK shareInstance] isAuthWithPlatformType:ShareTypeSinaWeibo];
    return isAuth;
}

- (void)shareContext:(NSString *)publishString AndPublishImage:(UIImage *)publishImage  AndDealWithData:(dealWithShareContentDataBlock )dateBlock {
    [[ShareContentWithShareSDK shareInstance] shareContent:@"我正在使用“路况知音”APP" AndPublishImage:publishImage AndSharePlatformType:ShareTypeSinaWeibo AndDealWithData:^{
        dateBlock();
    }];
}

@end
