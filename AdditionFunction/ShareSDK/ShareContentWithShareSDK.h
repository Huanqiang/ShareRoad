//
//  ShareContentWithShareSDK.h
//  ShareRoad
//
//  Created by 枫叶 on 14-7-17.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>

typedef void (^ dealWithShareContentDataBlock) ();

@interface ShareContentWithShareSDK : NSObject

#pragma mark - 对外接口
+ (id)shareInstance;


#pragma mark - 分享
/*
 方法：各平台分享内容（除微信、QQ、Pinterest平台外）
 参数介绍：
 参数 publishString： 要分享的文字
 参数 publishImage：  要分享的照片
 参数 type：          分享的平台
 */
- (void)shareContent: (NSString *)publishString AndPublishImage:(UIImage *)publishImage AndSharePlatformType:(ShareType)type AndDealWithData:(dealWithShareContentDataBlock )dateBlock;

/*
 方法：获取分享者信息
 参数介绍：
 参数 type：          分享的平台
 返回类型：ISSPlatformUser
 */
- (id)getCurrentUser:(ShareType)type;

/*
 方法：取消授权（除微信、QQ、Pinterest平台外）
 参数介绍：
 参数 type：          分享的平台
 */
- (void)cancelAuthWithPlatformType:(ShareType)type;


/*
 方法：判断是否已经授权（除微信、QQ、Pinterest平台外）
 参数介绍：
 参数 type：          分享的平台
 */
- (BOOL)isAuthWithPlatformType:(ShareType)type;

@end
