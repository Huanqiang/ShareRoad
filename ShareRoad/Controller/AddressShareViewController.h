//
//  AddressShareViewController.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/9.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "BaseNeedLogInViewController.h"
#import "BMapKit.h"
#import "CLLocation+YCLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface AddressShareViewController : BaseNeedLogInViewController<CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *addressShareBtn;

- (IBAction)addressShare:(id)sender;
@end
