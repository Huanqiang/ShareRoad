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

- (void)removeUserCookie {
    [[LogInToolClass shareInstance] saveCookie:NO];
}

- (BOOL)isCookie {
    return [[LogInToolClass shareInstance] isCookie];
}

//储存用户信息
- (void)saveUserName:(NSString *)userName {
    [[LogInToolClass shareInstance] saveUserInfo:userName AndInfoType:@"personName"];
}
- (void)saveUserPassword:(NSString *)userPassword {
    [[LogInToolClass shareInstance] saveUserInfo:userPassword AndInfoType:@"personPassword"];
}
- (void)saveUserAddress:(NSString *)userAddress {
    [[LogInToolClass shareInstance] saveUserInfo:userAddress AndInfoType:@"personAddress"];
}
- (void)saveUserSex:(NSString *)userSex {
    [[LogInToolClass shareInstance] saveUserInfo:userSex AndInfoType:@"personSex"];
}
- (void)saveUserPhone:(NSString *)userPhone {
    [[LogInToolClass shareInstance] saveUserInfo:userPhone AndInfoType:@"personPhone"];
}
- (void)saveUserIcon:(NSData *)userIcon {
    [[PhotoAndCameraClass shareInstance] saveImageToDocuments:userIcon AndImageName:@"userImageIcon.png"];
}
- (void)saveUserIconPath {
    [[LogInToolClass shareInstance] saveUserInfo:[[PhotoAndCameraClass shareInstance] getImageURLString:@"userImageIcon.png"] AndInfoType:@"personIcon"];
}

//获取用户信息
- (NSString *)gainUserName {
    return [[LogInToolClass shareInstance] getUserInfo:@"personName"];
}
- (NSString *)gainUserIconPath {
    return [[LogInToolClass shareInstance] getUserInfo:@"personIcon"];
}
- (NSDictionary *)gainUserIcon {
    return [[PhotoAndCameraClass shareInstance] getImageWithImageName:@"userImageIcon"];
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


//删除用户信息
- (void)removeUserName {
    [[LogInToolClass shareInstance] removeUserInfo:@"personName"];
}
- (void)removeUserIcon {
    [[LogInToolClass shareInstance] removeUserInfo:@"personIcon"];
}
- (void)removeUserSex {
    [[LogInToolClass shareInstance] removeUserInfo:@"personPhone"];
}
- (void)removeUserPhone{
    [[LogInToolClass shareInstance] removeUserInfo:@"personPhone"];
}
- (void)removeUserAddress {
    [[LogInToolClass shareInstance] removeUserInfo:@"personAddress"];
}


@end
