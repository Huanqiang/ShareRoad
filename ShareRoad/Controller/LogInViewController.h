//
//  LogInViewController.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/9.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "BaseViewController.h"

@interface LogInViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *personNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *personPasswordTextField;
- (IBAction)LogIn:(id)sender;
@end
