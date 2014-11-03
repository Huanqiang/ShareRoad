//
//  FeedbackContextViewController.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/3.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "FeedbackContextViewController.h"

@implementation FeedbackContextViewController
@synthesize feedbackContext;
@synthesize placeholderLabel;
@synthesize submitFeedbackContextBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBtnCircleBead:submitFeedbackContextBtn];
    [feedbackContext becomeFirstResponder];
    feedbackContext.delegate = self;
    
    user = [UserInfo shareInstance];
    
    [self isLogIn];
}

- (IBAction)submitFeedbackContext:(id)sender {
    [feedbackContext resignFirstResponder];
    
    if (![feedbackContext.text isEqualToString:@""]) {
        [self.view.window showHUDWithText:@"正在反馈中..." Type:ShowLoading Enabled:YES];
        NSMutableArray *personInfo = [[NSMutableArray alloc] initWithArray:@[@"userName", [user gainUserName], @"feedbackContext", feedbackContext.text]];
        [self webServiceWithNet:@"Feedback" webServiceParmeters:personInfo success:^(NSDictionary *dic){
            [self dealWithNetManageResult:[dic objectForKey:@"result"]];
        }];
    }else {
        [self showAlertView:@"抱歉" msg:@"请填写反馈信息" delegate:self];
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
            [self.view.window showHUDWithText:@"反馈成功" Type:ShowPhotoYes Enabled:YES];
            
            [self performSelector:@selector(comeBack) withObject:nil afterDelay:0.9];
            break;
        }
    }
    if (![msg isEqualToString:@""]) {
        [self showAlertView:@"抱歉" msg:msg delegate:self];
    }
}

- (void)comeBack {
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {//检测到“完成”
        [textView resignFirstResponder];//释放键盘
        return NO;
    }
    if (feedbackContext.text.length==0){//textview长度为0
        if ([text isEqualToString:@""]) {//判断是否为删除键
            placeholderLabel.hidden=NO;//隐藏文字
        }else{
            placeholderLabel.hidden=YES;
        }
    }else{//textview长度不为0
        if (feedbackContext.text.length==1){//textview长度为1时候
            if ([text isEqualToString:@""]) {//判断是否为删除键
                placeholderLabel.hidden=NO;
            }else{//不是删除
                placeholderLabel.hidden=YES;
            }
        }else{//长度不为1时候
            placeholderLabel.hidden=YES;
        }
    }
    return YES;
}
@end
