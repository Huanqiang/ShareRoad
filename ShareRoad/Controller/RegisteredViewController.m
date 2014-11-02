//
//  RegisteredViewController.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/9.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "RegisteredViewController.h"

@interface RegisteredViewController () {
    UserInfo *user;
}

@end

@implementation RegisteredViewController
@synthesize personPasswordTextField;
@synthesize personNameTextField;
@synthesize personPhoneTextField;
@synthesize personSurePasswordTextField;
@synthesize personNameView;
@synthesize personPasswordView;
@synthesize personPhoneView;
@synthesize personSurePasswordView;
@synthesize registerBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self->keyboardSize.height = 216;
    self->textFieldArr = @[personNameTextField, personPhoneTextField, personPasswordTextField, personSurePasswordTextField];
    [self setCustomKeyboard:self];
    
    user = [UserInfo shareInstance];
    
    [self setViewCircleBead:personPhoneView];
    [self setViewCircleBead:personNameView];
    [self setViewCircleBead:personPasswordView];
    [self setViewCircleBead:personSurePasswordView];
    [self setBtnCircleBead:registerBtn];
    
    [self.personNameTextField becomeFirstResponder];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting_return"] style:UIBarButtonItemStylePlain target:self action:@selector(popToSettingView)];
}

- (void)popToSettingView {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerOperation:(id)sender {

    //判断是否全部输入完整
    if (![[CustomToolClass shareInstance] TextFieldIsFull:self->textFieldArr]) {
        [self showAlertView:@"抱歉" msg:@"请填写完整信息" delegate:self];
        return;
    }
    
    //判断手机号码是否正确
    if (![[CustomToolClass shareInstance] validateMobile:personPhoneTextField.text]) {
        [self showAlertView:@"抱歉" msg:@"请填写正确的手机号码" delegate:self];
        return;
    }
    
    //判断两次输入的密码是否一致
    if (![personPasswordTextField.text isEqualToString:personSurePasswordTextField.text]) {
        [self showAlertView:@"抱歉" msg:@"您的密码和确认密码不一致" delegate:self];
        return;
    }
    
    [self netManage];
}

//网络操作
- (void)netManage {
    [self hidenKeyboard];
    [self.view.window showHUDWithText:@"正在注册中..." Type:ShowLoading Enabled:YES];
    NSMutableArray *personInfo = [[NSMutableArray alloc] initWithArray:@[@"UserName", personNameTextField.text, @"PhoneNumber", personPhoneTextField.text, @"Password", personPasswordTextField.text]];
    
    [self webServiceWithNet:@"Register" webServiceParmeters:personInfo success:^(NSDictionary *dic){
        [self dealWithNetManageResult:[dic objectForKey:@"result"]];
    }];
}

//处理网络操作结果
- (void)dealWithNetManageResult:(NSString *)result {
    NSString *msg = @"";
    switch ([result intValue]) {
        case 0: {
            [self.view.window showHUDWithText:@"注册失败" Type:ShowPhotoNo Enabled:YES];
            break;
        }
        case 1: {
            [self.view.window showHUDWithText:@"注册成功" Type:ShowPhotoYes Enabled:YES];
            [self performSelector:@selector(saveUserInfoAfterRegister) withObject:nil afterDelay:0.9];
            
            break;
        }
        case 2: {
            msg = @"该用户名已存在";
            break;
        }
        case 3: {
            msg = @"该手机号已被注册";
            break;
        }
    }
    
    if (![msg isEqualToString:@""]) {
        [self showAlertView:@"抱歉" msg:msg delegate:self];
    }
}

//保存
- (void)saveUserInfoAfterRegister {
    [user saveUserName:personNameTextField.text];
    [user saveUserPhone:personPhoneTextField.text];
    [user saveUserPassword:personPasswordTextField.text];
    [user saveUserCookie];
    
    //设置JPush
//    [APService setAlias:phoneNumberField.text callbackSelector:nil object:self];
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
