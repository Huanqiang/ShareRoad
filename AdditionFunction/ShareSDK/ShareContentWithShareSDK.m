//
//  ShareContentWithShareSDK.m
//  ShareRoad
//
//  Created by 枫叶 on 14-7-17.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "ShareContentWithShareSDK.h"

@implementation ShareContentWithShareSDK

static ShareContentWithShareSDK *instnce;
#pragma mark - 对外接口
//使外部文件可以直接访问UesrDB内部函数
+ (id)shareInstance {
    if (instnce == nil) {
        instnce = [[[self class] alloc] init];
    }
    return instnce;
}

#pragma mark - 分享内容
//设置分享内容
- (id)setPublishContent: (NSString *)publishString AndPublishImage:(UIImage *)publishImage {
    
    id<ISSContent> content = [ShareSDK content:publishString
                                defaultContent:@"来自“路况知音”的分享"
                                         image:[ShareSDK pngImageWithImage:publishImage]
                                         title:@"“路况知音”的分享"
                                           url:@"http://www.sharesdk.cn"
                                   description:@"这是一条来自“路况知音”的分享"
                                     mediaType:SSPublishContentMediaTypeNews];
    return content;
}

//分享
- (void)shareContent: (NSString *)publishString AndPublishImage:(UIImage *)publishImage AndSharePlatformType:(ShareType)type AndDealWithData:(dealWithShareContentDataBlock )dateBlock{
    [ShareSDK shareContent:[self setPublishContent:publishString AndPublishImage:publishImage]
                      type:type
               authOptions:nil
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSResponseStateSuccess)
                        {
                            NSLog(@"分享成功");
                            dateBlock();
                        }
                        else if (state == SSResponseStateFail)
                        {
                            NSLog(@"分享失败,错误码:%ld,错误描述:%@", (long)[error errorCode],  [error errorDescription]);
                        }
                    }];
}

//获取分享者
- (id)getCurrentUser:(ShareType)type {
    id<ISSPlatformUser> user = [ShareSDK currentAuthUserWithType:type];
    return user;
}

#pragma mark - 取消授权
//取消授权
- (void)cancelAuthWithPlatformType:(ShareType)type {
    [ShareSDK cancelAuthWithType:type];
}

//判断是否已经授权
- (BOOL)isAuthWithPlatformType:(ShareType)type {
    if ([ShareSDK hasAuthorizedWithType:type]) {
        return YES;
    }
    return NO;
}

@end
