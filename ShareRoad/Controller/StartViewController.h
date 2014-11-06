//
//  StartViewController.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/6.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EAIntroView.h"
#import "AppDelegate.h"
#import "UserInfo.h"

@interface StartViewController : UIViewController<EAIntroDelegate> {
    UserInfo *user;
}

@property (nonatomic, strong) NSString *login;

@end
