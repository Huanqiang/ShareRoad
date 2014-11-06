//
//  OppositeDirection.m
//  ShareRoad
//
//  Created by 枫叶 on 14-9-9.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "OppositeDirection.h"

@implementation OppositeDirection

static OppositeDirection *instnce;
#pragma mark - 外部文件可以直接访问RecordingManage内部函数

+ (id)shareInstance {
    if (instnce == nil) {
        instnce = [[[self class] alloc] init];
    }
    return instnce;
}

#pragma mark - 判断两个点之间的位置关系

- (NSString *)judgePosition:(int)x {
    NSString *position;
    
    switch (x) {
        case 0:
            position = @"正前方";
            break;
        case 1:
            position = @"右前方";
            break;
        case 2:
            position = @"正右方";
            break;
        case 3:
            position = @"右后方";
            break;
        case 4:
            position = @"正后方";
            break;
        case 5:
            position = @"左后方";
            break;
        case 6:
            position = @"正左方";
            break;
        case 7:
            position = @"左前方";
            break;
        default:
            break;
    }
    
    return position;
}


//根据两个点经纬度和主点（userLocationCoordinate）的角度，判断出另一个点（rodeLocationCoordinate）在主点的方位
- (int)judgeDirection:(CLLocationCoordinate2D)userLocationCoordinate andRoadInfo:(CLLocationCoordinate2D)rodeLocationCoordinate andUserAngle:(double)userAngle{
    double roadAngle = [self judgeAngle:userLocationCoordinate andRoadInfoCoordinate:rodeLocationCoordinate];
    double angleGap = roadAngle - userAngle;
    
    int direction = 0;
    
    if (angleGap < 0) {
        angleGap = roadAngle + 360 - userAngle;
    }else {
        angleGap = roadAngle - userAngle;
    }
    
    if (angleGap > 0 && angleGap < 90) {                  // road点在user点的右前方
        direction = 1;
    }else if(angleGap == 90){                             // road点在user点的正右方
        direction = 2;
    }else if (angleGap > 90 && angleGap < 180) {          // road点在user点的右后方
        direction = 3;
    }else if(angleGap == 180){                            // road点在user点的正后方
        direction = 4;
    }else if (angleGap > 180 && angleGap < 270) {         // road点在user点的左后方
        direction = 5;
    }else if(angleGap == 270){                            // road点在user点的正左方
        direction = 6;
    }else if (angleGap > 270 && angleGap < 360) {         // road点在user点的左前方
        direction = 7;
    }else if(angleGap == 0){                              // road点在user点的正前方
        direction = 0;
    }
    return direction;
}

//根据两个点的经纬度，以一个点（userLocationCoordinate）为坐标中心，y轴正方向为正北方向（即为 0°），求出另一个点（rodeLocationCoordinate）关于正北方向的角度（0° ~ 360°）
- (double)judgeAngle:(CLLocationCoordinate2D)userLocationCoordinate andRoadInfoCoordinate:(CLLocationCoordinate2D)rodeLocationCoordinate {
    double a = rodeLocationCoordinate.longitude - userLocationCoordinate.longitude;  //经度差
    double b = rodeLocationCoordinate.latitude - userLocationCoordinate.latitude;    //纬度差
    double c = hypot(fabs(a), fabs(b));
    double cosy = 0.0;
    double angle = 0;
    
    if (a > 0 && b > 0) {                  // 判断road点在user点的东北位置
        cosy = b / c;
        angle = 0;
    }else if (a == 0 && b > 0) {           //在正北位置
        angle = -90;
    }else if (a > 0 && b < 0) {            // 判断road点在user点的东南位置
        cosy = a / c;
        angle = 90;
    }else if (a > 0 && b == 0) {           //在正东位置
        angle = 90;
    }else if (a < 0 && b < 0) {            // 判断road点在user点的西南位置
        cosy = fabs(b) / c;
        angle = 180;
    }else if (a == 0 && b < 0) {           //在正南位置
        angle = 90;
    }else if (a < 0 && b > 0) {            // 判断road点在user点的西北位置
        cosy = fabs(a) / c;
        angle = 270;
    }else if (a < 0 && b == 0) {           //在正西位置
        angle = 180;
    }
    
    double m = acos(cosy);
    //n 即以正北为 0 的总角度
    double n = ( m / M_PI ) * 180 + angle;
    
    return n;
}

@end
