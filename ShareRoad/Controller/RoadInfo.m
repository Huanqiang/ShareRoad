//
//  RoadInfo.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/4.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "RoadInfo.h"

@implementation RoadInfo
@synthesize coordinate;
@synthesize address;
@synthesize filePath;
@synthesize fileData;
@synthesize fileName;
@synthesize fileType;
@synthesize distance;
@synthesize direction;

- (CLLocationCoordinate2D)setCoordinate:(NSString *)longitude latitude:(NSString *)latitude {
   return CLLocationCoordinate2DMake(latitude.floatValue, longitude.floatValue);
}

- (void)saveFile:(NSString *)roadInfoURL contentData:(NSData *)data {
    //这里将图片放在沙盒的documents文件夹中
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //得到选择后沙盒中图片的完整路径
    NSString *subdir = [DocumentsPath stringByAppendingPathComponent:@"RoadInfo"];//RoadInfo就是你创建的文件夹名
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //把刚刚图片转换的data对象保存至沙盒中
    [fileManager createDirectoryAtPath:subdir withIntermediateDirectories:YES attributes:nil error:nil];
    [fileManager createFileAtPath:[subdir stringByAppendingString:[NSString stringWithFormat:@"/%@",[roadInfoURL lastPathComponent]]] contents:data attributes:nil];
}

#pragma mark - 重新创建路况文件链接
- (NSString *)creatFileURL:(NSString *)roadInfoURL {
    NSArray *array = [roadInfoURL componentsSeparatedByString:@"/"];
    NSArray *fileArr = [NSArray arrayWithObjects: WebServiceURL, array[3], array[4], array[5], nil];
    NSString *urlString = [fileArr componentsJoinedByString:@"/"];
    return urlString;
}

@end
