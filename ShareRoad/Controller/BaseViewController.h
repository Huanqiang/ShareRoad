//
//  BaseViewController.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/9.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceClass.h"
#import "UIWindow+YzdHUD.h"
#import "LogInToolClass.h"
#import "UserInfo.h"
#import "BOAlertController.h"
#import "CustomToolClass.h"

@interface BaseViewController : UIViewController<UITextFieldDelegate> {
    CGSize keyboardSize;
    NSArray *textFieldArr;
}

#pragma mark - 设置圆角
- (void)setViewCircleBead:(UIView *)senderView;
- (void)setBtnCircleBead:(UIButton *)senderBtn;

#pragma mark - 网络操作
- (void)webServiceWithNet:(NSString *)wsName webServiceParmeters:(NSMutableArray *)wsParmeters success:(void(^)(NSDictionary *dic)) success;

#pragma mark - 弹出简单提示 alertView 控件
- (void)showAlertView:(NSString *)title msg:(NSString *)msg delegate:(id)delegate;

#pragma mark - 键盘操作
- (void)setCustomKeyboard:(id)delegate;

@end
