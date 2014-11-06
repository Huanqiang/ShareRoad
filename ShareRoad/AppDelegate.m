//
//  AppDelegate.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/8.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //百度地图
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果需要关注网络及授权验证事件，请设定generalDelegate参数为self
    // 如果不需要关注网络及授权验证事件，请设定generalDelegate参数为nil
    BOOL ret = [_mapManager start:@"iuXrkvFZ3LaGgVSGkDG1fGVa"  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    // 集成科大讯飞语言
    //将“12345678”替换成您申请的APPID,申请地址:http://open.voicecloud.cn
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",@"53bf4f03"];
    [IFlySpeechUtility createUtility:initString];
    
    //集成 ShareSDK，  参数为ShareSDK官网中添加应用后得到的AppKey
    [ShareSDK registerApp:@"24d00bf5e974"];
    //添加新浪微博应用 注册网址 http://open.weibo.com
    [ShareSDK connectSinaWeiboWithAppKey:@"467676720"
                               appSecret:@"722094cf6e916af377861b0c76fd54b4"
                             redirectUri:@"https://api.weibo.com/oauth2/default.html"];
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK  connectSinaWeiboWithAppKey:@"467676720"
                                appSecret:@"722094cf6e916af377861b0c76fd54b4"
                              redirectUri:@"https://api.weibo.com/oauth2/default.html"
                              weiboSDKCls:[WeiboSDK class]];
    //集成 JPush
    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
    
    //处理极光推送内容
    NSDictionary *remoteNotification = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotification) {
        [self dealWithAPNS:remoteNotification];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - JPush
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
    [APService handleRemoteNotification:userInfo];
    
    [self dealWithAPNS:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)dealWithAPNS:(NSDictionary *)userInfo {
    // 取得 APNs 标准信息内容
    NSDictionary *dic = @{@"Lo": [userInfo valueForKey:@"Lo"], @"La": [userInfo valueForKey:@"La"], @"address": [userInfo valueForKey:@"address"], @"name": [userInfo valueForKey:@"name"]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushAPNS" object:dic];//发送一个字典过去
}

@end
