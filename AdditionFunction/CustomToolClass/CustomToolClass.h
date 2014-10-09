//
//  CustomToolClass.h
//  MyPrivacy
//
//  Created by 枫叶 on 14-5-29.
//  Copyright (c) 2014年 skywang1994_枫叶. All rights reserved.
//

#import <Foundation/Foundation.h>

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

#pragma mark - NSDictionary与NSString的转换
/*
 方法：字符串转化成字典
 参数介绍：
 string：需转化的字符串；
 */
- (NSDictionary *)stringToDictionary:(NSString *)string;
/*
 方法：字典转化成字符串
 参数介绍：
 dic：需转化的字典；
 */
//- (NSString *)dictionaryToString:(NSDictionary *)dic;

#pragma mark - NSData与NSString的转换
/*
 方法：字符串转化成NSata
 参数介绍：
 string：需转化的字符串；
 */
- (NSData *)stringToData:(NSString *)string;
/*
 方法：NSData转化成字符串
 参数介绍：
 data：需转化的NSData；
 */
- (NSString *)dataToString:(NSData *)data;


#pragma mark - 在Documents文件夹下创建子文件夹
/*
 方法：在Documents文件夹下创建子文件夹
 */
- (void)createFolderInDocuments:(NSString *)folderName;

/*
 方法：判断在Documents文件夹下是否存在置顶文件夹
 */
- (BOOL)theFolderIsExits:(NSString *)folderName;

/*
 方法：删除指定文件夹下的所有文件
 */
- (void)removeFileInTheFolder:(NSString *)folderName;



@end
