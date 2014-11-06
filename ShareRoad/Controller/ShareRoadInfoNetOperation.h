//
//  ShareRoadInfoNetOperation.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/4.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "BaseViewController.h"
#import "ShareRoadInfoDelegate.h"
#import "RoadInfo.h"

@interface ShareRoadInfoNetOperation : BaseViewController

@property(nonatomic, retain) NSObject<ShareRoadInfoDelegate> *delegate;
- (void)shareRoadInfo:(RoadInfo *)roadInfo;

@end
