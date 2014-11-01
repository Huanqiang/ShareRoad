//
//  RegisteredViewController.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/9.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisteredViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *personNameTextField;
@property (weak, nonatomic) IBOutlet UIView *personNameView;
@property (weak, nonatomic) IBOutlet UIView *personPhoneView;
@property (weak, nonatomic) IBOutlet UITextField *personPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *personPasswordTextField;
@property (weak, nonatomic) IBOutlet UIView *personPasswordView;
@property (weak, nonatomic) IBOutlet UITextField *personSurePasswordTextField;
@property (weak, nonatomic) IBOutlet UIView *personSurePasswordView;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

- (IBAction)registerOperation:(id)sender;
@end
