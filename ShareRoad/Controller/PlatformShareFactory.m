//
//  PlatformShareFactory.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/3.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "PlatformShareFactory.h"

@implementation PlatformShareFactory

- (PlatformShare *)createPlatform:(PlatformShareType)platformType {
    PlatformShare *platform;
    switch (platformType) {
        case SinaWeibo:
            platform = [[WeiboShare alloc] init];
            break;
            
        default:
            break;
    }
    
    return platform;
}

@end
