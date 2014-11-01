//
//  UserInfo.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/31.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

static UserInfo *instnce;
#pragma mark - 对外接口
//使外部文件可以直接访问UesrDB内部函数
+ (id)shareInstance {
    if (instnce == nil) {
        instnce = [[[self class] alloc] init];
    }
    return instnce;
}

- (void)saveUserCookie {
    [[LogInToolClass shareInstance] saveCookie:YES];
}

//储存用户信息
- (void)saveUserName:(NSString *)userName {
    [[LogInToolClass shareInstance] saveUserInfo:userName AndInfoType:@"userName"];    
}
- (void)saveUserPassword:(NSString *)userPassword {
    [[LogInToolClass shareInstance] saveUserInfo:userPassword AndInfoType:@"password"];
}
- (void)saveUserAddress:(NSString *)userAddress {
    [[LogInToolClass shareInstance] saveUserInfo:userAddress AndInfoType:@"address"];
}
- (void)saveUserSex:(NSString *)userSex {
    [[LogInToolClass shareInstance] saveUserInfo:userSex AndInfoType:@"address"];
}
- (void)saveUserPhone:(NSString *)userPhone {
    [[LogInToolClass shareInstance] saveUserInfo:userPhone AndInfoType:@"phoneNumber"];
}
- (void)saveUserIcon:(NSData *)userIcon {
    [[PhotoAndCameraClass shareInstance] saveImageToDocuments:userIcon AndImageName:@"userImageIcon"];
    [[LogInToolClass shareInstance] saveUserInfo:[[PhotoAndCameraClass shareInstance] getImageURLString:@"userImageIcon.png"] AndInfoType:@"userIcon"];
}

//获取用户信息
- (NSString *)gainUserName {
    return [[LogInToolClass shareInstance] getUserInfo:@"personName"];
}
- (NSString *)gainUserIcon {
    return [[LogInToolClass shareInstance] getUserInfo:@"personIcon"];
}
- (NSString *)gainUserSex {
    return [[LogInToolClass shareInstance] getUserInfo:@"personSex"];
}
- (NSString *)gainUserPhone {
    return [[LogInToolClass shareInstance] getUserInfo:@"personPhone"];
}
- (NSString *)gainUserAddress {
    return [[LogInToolClass shareInstance] getUserInfo:@"personAddress"];
}

@end
