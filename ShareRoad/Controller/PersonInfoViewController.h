//
//  PersonInfoViewController.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/9.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "BaseViewController.h"

@interface PersonInfoViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *personIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *personNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *personSexBtn;
@property (weak, nonatomic) IBOutlet UIView *personNameView;
@property (weak, nonatomic) IBOutlet UITextField *personNameTextField;
@property (weak, nonatomic) IBOutlet UIView *personPhoneView;
@property (weak, nonatomic) IBOutlet UITextField *personPhoneTextField;
@property (weak, nonatomic) IBOutlet UIView *personAddressView;
@property (weak, nonatomic) IBOutlet UITextField *personAddressTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveOrLogOutBtn;

- (IBAction)selectedSex:(id)sender;
- (IBAction)modifyPersonInfo:(id)sender;
- (IBAction)modifyPersonPassword:(id)sender;
- (IBAction)saveOrLogOut:(id)sender;

@end
