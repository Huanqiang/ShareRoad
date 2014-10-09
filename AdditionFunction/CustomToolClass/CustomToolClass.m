//
//  CustomToolClass.m
//  MyPrivacy
//
//  Created by 枫叶 on 14-5-29.
//  Copyright (c) 2014年 skywang1994_枫叶. All rights reserved.
//

#import "CustomToolClass.h"

@implementation CustomToolClass
static CustomToolClass *instnce;

#pragma mark - 外部文件可以直接访问CustomToolClass内部函数
+ (id)shareInstance {
    if (instnce == nil) {
        instnce = [[[self class] alloc] init];
    }
    return instnce;
}

#pragma mark - NSArray与NSString的转换
- (NSString *)arrayToString:(NSArray *)array andSeparator:(NSString *)separator
{
    NSString *arrString = [NSString string];
    
    for (NSString *stringInArr in array) {
        if ([stringInArr isEqualToString:[array lastObject]]) {
            arrString = [arrString stringByAppendingFormat:@"%@",stringInArr];
        }
        else
        {
            arrString = [arrString stringByAppendingFormat:@"%@%@",stringInArr,separator];
        }
    }
    return arrString;
}

- (NSArray *)stringToArray:(NSString *)string andSeparator:(NSString *)separator
{
    NSArray *array = [NSArray array];
    
    array = [string componentsSeparatedByString:separator];
    
    return array;
}

#pragma mark - NSDate与NSString的转换

- (NSDate *)stringToDate:(NSString *)dateString
           andDateFormat:(NSString *)dateFormatStrring
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormatStrring;
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:dateString];
    
    return date;
}

- (NSString *)dateToString:(NSDate *)date
             andDateFormat:(NSString *)dateFormatStrring
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormatStrring;
    NSString *dateString = [[NSString alloc] init];
    dateString = [dateFormatter stringFromDate:date];
    
    return dateString;
}

#pragma mark - NSDictionary与NSString的转换
/*
 方法：字符串转化成时间
 参数介绍：
 dateString：需转化的字符串；
 dateFormatStrring：要转化的时间戳格式 @"yyyy-MM-dd HH:mm:ss.S"
 */
- (NSDictionary *)stringToDictionary:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return dic;
}
/*
 方法：时间转化成字符串
 参数介绍：
 date：需转化的时间；
 dateFormatStrring：要转化的时间戳格式
 */
//- (NSString *)dictionaryToString:(NSDictionary *)dic {
//    
//}

#pragma mark - NSData与NSString的转换
/*
 方法：字符串转化成NSata
 参数介绍：
 string：需转化的字符串；
 */
- (NSData *)stringToData:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}
/*
 方法：NSData转化成字符串
 参数介绍：
 data：需转化的NSData；
 */
- (NSString *)dataToString:(NSData *)data {
    NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    return result;
}


#pragma mark - 在Documents文件夹下的操作子文件夹
/*
 方法：在Documents文件夹下创建子文件夹
 */
- (void)createFolderInDocuments:(NSString *)folderName
{
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:folderName];
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSAssert(bo,@"创建目录失败");
}

/*
 方法：判断在Documents文件夹下是否存在指定文件夹
 */
- (BOOL)theFolderIsExits:(NSString *)folderName {
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:folderName];
    BOOL isDirExist = [[NSFileManager defaultManager] fileExistsAtPath:path];
    return isDirExist;
}

/*
 方法：删除指定文件夹下的所有文件
 */
- (void)removeFileInTheFolder:(NSString *)folderName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:folderName];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:path error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    
    NSString *filename;
    while ((filename = [e nextObject])) {
        [fileManager removeItemAtPath:[path stringByAppendingPathComponent:filename] error:NULL];
    }
}

@end
