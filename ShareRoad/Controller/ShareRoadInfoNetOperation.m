//
//  ShareRoadInfoNetOperation.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/4.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "ShareRoadInfoNetOperation.h"

@interface ShareRoadInfoNetOperation ()

@end

@implementation ShareRoadInfoNetOperation
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 路况信息分享
- (void)shareRoadInfo:(RoadInfo *)roadInfo {
    
    NSString *longitude = [NSString stringWithFormat:@"%f", roadInfo.coordinate.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%f", roadInfo.coordinate.latitude];
    
    NSString *base64String = nil;
    // Check if new API is available
    if (![roadInfo.fileData respondsToSelector:@selector(base64EncodedDataWithOptions:)]) {
        // Use the old API
        base64String = [roadInfo.fileData base64Encoding];
    } else {
        // It exists, so let's call it
        base64String = [roadInfo.fileData base64EncodedStringWithOptions:0];
    }
    
    NSString *userName = @"test";
    if (![[[UserInfo shareInstance] gainUserName] isEqualToString:@""]) {
        userName = [[UserInfo shareInstance] gainUserName];
    }
    NSMutableArray *personInfo = [[NSMutableArray alloc] initWithArray:@[@"UserName", [[UserInfo shareInstance] gainUserName], @"Longitude", longitude, @"Latitude", latitude, @"type", roadInfo.fileType, @"RoadInfo", base64String, @"RoadInfoName", @"roadImage.png", @"RoadAddress", roadInfo.address]];
    
    
    [self webServiceWithNet:@"ShareRoadInfo" webServiceParmeters:personInfo success:^(NSDictionary *dic){
        [self.delegate comebackNetValue:[dic objectForKey:@"result"]];
    }];
}

@end
