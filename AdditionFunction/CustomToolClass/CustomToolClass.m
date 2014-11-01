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

#pragma mark - 验证手机号码
-(BOOL)validateMobile:(NSString* )mobileNumber {
    NSString *mobileStr = @"^((145|147)|(15[^4])|(17[6-8])|((13|18)[0-9]))\\d{8}$";
    NSPredicate *cateMobileStr = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobileStr];
    
    if ([cateMobileStr evaluateWithObject:mobileNumber]==YES)
    {
        return YES;
    }
    return NO;
}

#pragma mark - 给我评分
- (void)gotoGrade:(NSString *)appleID {
    NSString *str = [NSString stringWithFormat:
                     @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d", [appleID intValue]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

#pragma mark - 打开dream网址
-(void)openWebURL:(NSString *)urlString {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}


#pragma mark - 判断输入框是否有输入
- (BOOL)TextFieldIsFull:(NSArray *)textFieldArr {
    for (UITextField *textField in textFieldArr) {
        if ([textField.text isEqualToString:@""]) {
            return NO;
        }
    }
    return YES;
}
@end
