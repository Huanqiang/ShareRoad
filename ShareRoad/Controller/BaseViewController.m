//
//  BaseViewController.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/9.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "BaseViewController.h"

#define WebServiceURL @"http://dream-001.xicp.net:5010"
#define WebServiceFile @"/RoadInfService.asmx"
#define WebServiceXmlNameSpace @"http://tempuri.org/"

@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    className = @"baseViewController";
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

#pragma mark - 设置圆角
- (void)setBtnCircleBead:(UIButton *)senderBtn {
    senderBtn.layer.masksToBounds = YES;
    senderBtn.layer.cornerRadius = 5.0;
}

- (void)setViewCircleBead:(UIView *)senderView {
    senderView.layer.masksToBounds = YES;
    senderView.layer.cornerRadius = 5.0;
}


#pragma mark - 网络操作
- (void)webServiceWithNet:(NSString *)wsName webServiceParmeters:(NSMutableArray *)wsParmeters success:(void(^)(NSDictionary *dic)) success{
        
    [[WebServiceClass shareInstance] createAsynchronousRequestWithWebService:WebServiceURL webServiceFile:WebServiceFile xmlNameSpace:WebServiceXmlNameSpace webServiceName:wsName wsParameters:wsParmeters success:^(NSDictionary *dic){
        [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
        success(dic);
    }failure:^(NSError *error){
        [self.view.window showHUDWithText:@"网络错误..." Type:ShowPhotoNo Enabled:YES];
    }];
}

#pragma mark - 弹出简单提示 alertView 控件
- (void)showAlertView:(NSString *)title msg:(NSString *)msg delegate:(id)delegate{
    BOAlertController *alert = [[BOAlertController alloc] initWithTitle:title message:msg subView:nil viewController:delegate];
    RIButtonItem *okItem = [RIButtonItem itemWithLabel:@"确定" action:^{
        
    }];
    [alert addButton:okItem type:RIButtonItemType_Destructive];
    [alert show];
}



#pragma mark - 键盘操作
- (void)setCustomKeyboard:(id)delegate {
    //键盘操作
    
    //注册键盘弹起与收起通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    for (UITextField *textField in textFieldArr) {
        //指定本身为代理
        textField.delegate = delegate;
        
        //指定编辑时键盘的return键类型
        if ([textField isEqual:[textFieldArr lastObject]]) {
            textField.returnKeyType = UIReturnKeyDefault;
        }else {
            textField.returnKeyType = UIReturnKeyNext;
        }
        //注册键盘响应事件方法
        [textField addTarget:self action:@selector(nextOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    }
    
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
}

-(void)keyboardWillShow:(NSNotification *)note
{
    NSDictionary *info = [note userInfo];
    keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
}


//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //    CGRect frame = textField.frame;
    CGRect frame = textField.superview.frame;
    if (frame.origin.y == 0) {
        
        frame = textField.frame;
    }
    //判断控件与键盘的位置差
    int offset = frame.origin.y + 60 - (self.view.frame.size.height - keyboardSize.height);//键盘高度216
    if ([className isEqualToString:@"PersonInfoViewController"]) {
        offset += 260;
    }
    

    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

//隐藏键盘的方法
-(void)hidenKeyboard
{
    for (UITextField *textField in textFieldArr) {
        //指定本身为代理
        [textField resignFirstResponder];
    }
}

//点击键盘上的Return按钮响应的方法
-(IBAction)nextOnKeyboard:(UITextField *)sender
{
    if ([sender isEqual: [textFieldArr lastObject]]) {
        [self hidenKeyboard];
        return;
    }else {
        for (int i = 0; i < [textFieldArr count]; i++) {
            if ([sender isEqual:[textFieldArr objectAtIndex:i]]) {
                [[textFieldArr objectAtIndex:i + 1] becomeFirstResponder];
            }
        }
        return;
    }
}
@end
