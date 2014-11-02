//
//  PersonInfoViewController.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/9.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "BaseNeedLogInViewController.h"
#import "CLLocation+YCLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface PersonInfoViewController : BaseNeedLogInViewController<CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *personIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *personNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *personSexBtn;
@property (weak, nonatomic) IBOutlet UIView *personNameView;
@property (weak, nonatomic) IBOutlet UITextField *personNameTextField;
@property (weak, nonatomic) IBOutlet UIView *personPhoneView;
@property (weak, nonatomic) IBOutlet UITextField *personPhoneTextField;
@property (weak, nonatomic) IBOutlet UIView *personAddressView;
@property (weak, nonatomic) IBOutlet UITextField *personAddressTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *logOutBtn;
@property (weak, nonatomic) IBOutlet UIButton *getAddressInfoBtn;

- (IBAction)selectedSex:(id)sender;
- (IBAction)modifyPersonInfo:(id)sender;
- (IBAction)modifyPersonPassword:(id)sender;
- (IBAction)savePersonInfo:(id)sender;
- (IBAction)logOut:(id)sender;
- (IBAction)getAddressInfo:(id)sender;


@end
