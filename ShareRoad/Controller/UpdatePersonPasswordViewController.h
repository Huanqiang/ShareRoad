//
//  UpdatePersonPasswordViewController.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/2.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "BaseViewController.h"

@interface UpdatePersonPasswordViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *personOldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *personNewPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *personSureNewPasswordTextField;

- (IBAction)updatePersonPassword:(id)sender;
@end
