//
//  OppositeDirection.h
//  ShareRoad
//
//  Created by 枫叶 on 14-9-9.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface OppositeDirection : NSObject

#pragma mark - 外部文件可以直接访问RecordingManage内部函数
+ (id)shareInstance;

//返回方位
- (NSString *)judgePosition:(int)x;

//根据两个点经纬度和主点（userLocationCoordinate）的角度，判断出另一个点（rodeLocationCoordinate）在主点的方位
- (int)judgeDirection:(CLLocationCoordinate2D)userLocationCoordinate andRoadInfo:(CLLocationCoordinate2D)rodeLocationCoordinate andUserAngle:(double)userAngle;

@end
