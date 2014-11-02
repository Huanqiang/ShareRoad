//
//  UpdatePersonPasswordViewController.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/2.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "UpdatePersonPasswordViewController.h"

@implementation UpdatePersonPasswordViewController
@synthesize personNewPasswordTextField;
@synthesize personOldPasswordTextField;
@synthesize personSureNewPasswordTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    user = [UserInfo shareInstance];
    [self.personOldPasswordTextField becomeFirstResponder];
    self->keyboardSize.height = 260;
    self->textFieldArr = @[personOldPasswordTextField, personNewPasswordTextField, personSureNewPasswordTextField];
    [self setCustomKeyboard:self];
}

- (IBAction)updatePersonPassword:(id)sender {
    [self hidenKeyboard];
    if ([[CustomToolClass shareInstance] TextFieldIsFull:self->textFieldArr]) {
        if (![personNewPasswordTextField.text isEqualToString:personSureNewPasswordTextField.text]) {
            [self showAlertView:@"抱歉" msg:@"您的新密码和确认密码不一致" delegate:self];
        }else {
            [self.view.window showHUDWithText:@"正在更新中..." Type:ShowLoading Enabled:YES];
            NSMutableArray *personInfo = [[NSMutableArray alloc] initWithArray:@[@"UserName",[user gainUserName],@"PassWord",personNewPasswordTextField.text, @"OldPassWord", personOldPasswordTextField.text]];
            
            [self webServiceWithNet:@"UpdatePassword" webServiceParmeters:personInfo success:^(NSDictionary *dic){
                [self dealWithNetManageResult:[dic objectForKey:@"result"]];
            }];
        }
    }else {
        [self showAlertView:@"抱歉" msg:@"请填写完整信息" delegate:self];
    }
}


//处理网络操作结果
- (void)dealWithNetManageResult:(NSString *)dic {
    
    NSString *msg = @"";
    
    switch ([dic intValue]) {
        case 0: {
            msg = @"修改密码失败";
            break;
        }
        case 1: {
            [self.view.window showHUDWithText:@"修改密码成功" Type:ShowPhotoYes Enabled:YES];
            [self performSelector:@selector(popController) withObject:nil afterDelay:0.9];
            break;
        }
    }
    if (![msg isEqualToString:@""]) {
        [self showAlertView:@"抱歉" msg:msg delegate:self];
    }
}

//回到前一个界面
- (void)popController {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
