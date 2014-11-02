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
- (void)removeUserCookie;
- (BOOL)isCookie;

//储存用户信息
- (void)saveUserName:(NSString *)userName;
- (void)saveUserPassword:(NSString *)userPassword;
- (void)saveUserAddress:(NSString *)userAddress;
- (void)saveUserSex:(NSString *)userSex;
- (void)saveUserPhone:(NSString *)userPhone;
- (void)saveUserIcon:(NSData *)userIcon;      // 将照片存至 Doc 文件里
- (void)saveUserIconPath;                     // 存储照片路径


//获取用户信息
- (NSString *)gainUserName;
- (NSDictionary *)gainUserIcon;
- (NSString *)gainUserIconPath;
- (NSString *)gainUserSex;
- (NSString *)gainUserPhone;
- (NSString *)gainUserAddress;

//删除用户信息
- (void)removeUserName;
- (void)removeUserIcon;
- (void)removeUserSex;
- (void)removeUserPhone;
- (void)removeUserAddress;

@end
