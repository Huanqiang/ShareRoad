//
//  PlatformShare.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/3.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareContentWithShareSDK.h"

typedef enum
{
    SinaWeibo = 0,         /**< 新浪微博 */
    QQWeibo = 1,             /**< 腾讯微博 */
    QQSpace = 2,           /**< QQ空间 */
    WeixiSession = 3,      /**< 微信好友 */
    WeixiTimeline = 4,     /**< 微信朋友圈 */
}
PlatformShareType;

@interface PlatformShare : UIViewController

- (void)platformLogIn;                       //登录平台
- (void)cancelAuthWithPlatformType;          //退出平台
- (NSString *)gainPlatformPersonName;        //获取平台上的用户名
- (BOOL)isAuthWithPlatformType;              //判断是否授权

@end
