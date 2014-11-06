//
//  AppDelegate.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/8.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
#import <ShareSDK/ShareSDK.h>
#import "BMapKit.h"
#import "APService.h"
#import "iflyMSC/IFlySpeechUtility.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, BMKGeneralDelegate> {
    BMKMapManager * _mapManager;
}

@property (strong, nonatomic) UIWindow *window;


@end

