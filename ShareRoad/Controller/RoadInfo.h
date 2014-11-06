//
//  RoadInfo.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/4.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface RoadInfo : NSObject

@property (nonatomic) CLLocationCoordinate2D coordinate;     // 经纬度.
@property (nonatomic, strong) NSString *address;             // 地址.
@property (nonatomic, strong) NSString *filePath;            // 文件路径.
@property (nonatomic, strong) NSString *fileName;            // 文件名称
@property (nonatomic, strong) NSData *fileData;              // 文件名称
@property (nonatomic, strong) NSString *fileType;            // 文件类型
@property (nonatomic, strong) NSString *distance;            // 距离
@property (nonatomic) double direction;                      // 方向


- (CLLocationCoordinate2D)setCoordinate:(NSString *)longitude latitude:(NSString *)latitude;
- (void)saveFile:(NSString *)roadInfoURL contentData:(NSData *)data;
- (NSString *)creatFileURL:(NSString *)roadInfoURL;

@end
