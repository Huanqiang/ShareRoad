//
//  AddressShareViewController.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/9.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "AddressShareViewController.h"

@interface AddressShareViewController () {
    CLLocationCoordinate2D locatonCoor;
    NSString *locationAddress;
}

@end

@implementation AddressShareViewController
@synthesize phoneNumberTextField;
@synthesize addressShareBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [phoneNumberTextField becomeFirstResponder];
    [self setBtnCircleBead:addressShareBtn];
    user = [UserInfo shareInstance];
    [self isLogIn];
    [self initLocationManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addressShare:(id)sender {
    [phoneNumberTextField resignFirstResponder];
    
    if (![phoneNumberTextField.text isEqualToString:@""]) {
        if (![phoneNumberTextField.text isEqualToString:[user gainUserPhone]]) {
            [self.view.window showHUDWithText:@"正在分享中..." Type:ShowLoading Enabled:YES];
            
            NSDictionary *userCoordinateDic = BMKConvertBaiduCoorFrom(locatonCoor, BMK_COORDTYPE_GPS);
            CLLocationCoordinate2D locatonCoor1 = BMKCoorDictionaryDecode(userCoordinateDic);
            NSMutableArray *personInfo = [[NSMutableArray alloc] initWithArray:@[@"userName", [user gainUserName], @"phoneNumber", phoneNumberTextField.text, @"longitude", [NSString stringWithFormat:@"%f", locatonCoor1.longitude], @"latitude", [NSString stringWithFormat:@"%f", locatonCoor1.latitude], @"detailAddress", locationAddress]];
            [self webServiceWithNet:@"ShareAddress" webServiceParmeters:personInfo success:^(NSDictionary *dic){
                [self dealWithNetManageResult:[dic objectForKey:@"result"]];
            }];
        }else {
            [self showAlertView:@"抱歉" msg:@"请不要给自己分享地址" delegate:self];
        }
    }else {
        [self showAlertView:@"抱歉" msg:@"请填写对方手机号" delegate:self];
    }
}

//处理网络操作结果
- (void)dealWithNetManageResult:(NSString *)result {
    
    NSString *msg = @"";
    
    switch ([result intValue]) {
        case 0: {
            msg = @"反馈失败";
            break;
        }
        case 1: {
            [self.view.window showHUDWithText:@"分享成功" Type:ShowPhotoYes Enabled:YES];
            break;
        }
        case 2:{
            msg = @"您所要分享者的手机号不存在或者该用户尚未注册";
        }
    }
    if (![msg isEqualToString:@""]) {
        [self showAlertView:@"抱歉" msg:msg delegate:self];
    }
}

#pragma mark - 地址更新
- (void)initLocationManager {
    locationManager=[[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];
}

//地理位置发生改变时触发  CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // 停止位置更新
    [manager stopUpdatingLocation];
    
    CLLocation *locationGCJ = [newLocation locationMarsFromEarth];
    locatonCoor = locationGCJ.coordinate;
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:locationGCJ completionHandler:^(NSArray *placemarks, NSError *error) {
        if(placemarks.count > 0) {
//            [self.view.window showHUDWithText:@"获取成功" Type:ShowPhotoYes Enabled:YES];
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            locationAddress = placemark.name;
        }else {
            [self.view.window showHUDWithText:@"获取地址失败" Type:ShowPhotoYes Enabled:YES];
        }
    }];
}

// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
}
@end
