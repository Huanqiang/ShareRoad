//
//  CustomToolClass.h
//  MyPrivacy
//
//  Created by 枫叶 on 14-5-29.
//  Copyright (c) 2014年 skywang1994_枫叶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PassValueDelegate <NSObject>

-(void)passValue:(id)value;

@end

@interface CustomToolClass : NSObject
#pragma mark - 外部文件可以直接访问CustomToolClass内部函数
/*
 方法：外部文件可以直接访问CustomToolClass内部函数
 */
+ (id)shareInstance;

#pragma mark - NSArray与NSString的转换
/*
 方法：数组转字符串
 参数介绍：
 array：需转化的数组；
 separator：分隔符
 */
- (NSString *)arrayToString:(NSArray *)array andSeparator:(NSString *)separator;

/*
 方法：字符串转数组
 参数介绍：
 string：需转化的字符串；
 separator：分隔符
 */
- (NSArray *)stringToArray:(NSString *)string andSeparator:(NSString *)separator;

#pragma mark - NSDate与NSString的转换
/*
 方法：字符串转化成时间
 参数介绍：
 dateString：需转化的字符串；
 dateFormatStrring：要转化的时间戳格式 @"yyyy-MM-dd HH:mm:ss.S"
 */
- (NSDate *)stringToDate:(NSString *)dateString
           andDateFormat:(NSString *)dateFormatStrring;
/*
 方法：时间转化成字符串
 参数介绍：
 date：需转化的时间；
 dateFormatStrring：要转化的时间戳格式
 */
- (NSString *)dateToString:(NSDate *)date
             andDateFormat:(NSString *)dateFormatStrring;

#pragma mark - 验证手机号码
/*
 方法：验证手机号码是否为11位
 参数介绍：
    mobileNumber： 手机号
 返回值：
    号码正确：返回 yes
    号码错误：返回 NO
 */
-(BOOL)validateMobile:(NSString* )mobileNumber;

#pragma mark - 给我评分
/*
 方法：传入本 app 的 appID ，使用户跳转到 APP 商店进行打分；
 参数介绍：
 appleID： 本 app 的 appID
 */
- (void)gotoGrade:(NSString *)appleID;

#pragma mark - 打开dream网址
/*
 方法：通过传入一个 url的字符串，在 Safari 上打开该网址
 参数介绍：
 urlString： url 的字符串
 */
-(void)openWebURL:(NSString *)urlString;

#pragma mark - 判断输入框是否有输入
/*
 方法判断输入框是否全部有输入
 参数介绍：
 textFieldArr： 输入框的集合
 返回值：
 全部有输入：      返回 yes
 有一个没有输入：   返回 NO
 */
- (BOOL)TextFieldIsFull:(NSArray *)textFieldArr;

@end
