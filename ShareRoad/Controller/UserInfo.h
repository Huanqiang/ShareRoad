//
//  UserInfo.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/31.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogInToolClass.h"
#import "PhotoAndCameraClass.h"

@interface UserInfo : NSObject

+ (id)shareInstance;

- (void)saveUserCookie;

//储存用户信息
- (void)saveUserName:(NSString *)userName;
- (void)saveUserPassword:(NSString *)userPassword;
- (void)saveUserAddress:(NSString *)userAddress;
- (void)saveUserSex:(NSString *)userSex;
- (void)saveUserPhone:(NSString *)userPhone;
- (void)saveUserIcon:(NSData *)userIcon;


//获取用户信息
- (NSString *)gainUserName;
- (NSString *)gainUserIcon;
- (NSString *)gainUserSex;
- (NSString *)gainUserPhone;
- (NSString *)gainUserAddress;

@end
