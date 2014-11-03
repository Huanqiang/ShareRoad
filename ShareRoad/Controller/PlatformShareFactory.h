//
//  PlatformShareFactory.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/3.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "PlatformShare.h"
#import "WeiboShare.h"

@interface PlatformShareFactory : UIViewController

- (PlatformShare *)createPlatform:(PlatformShareType)platformType;

@end