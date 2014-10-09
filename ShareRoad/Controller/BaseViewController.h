//
//  BaseViewController.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/9.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceClass.h"

@interface BaseViewController : UIViewController<UITextFieldDelegate> {
    CGSize keyboardSize;
    NSArray *textFieldArr;
}

#pragma mark - 设置圆角
- (void)setViewCircleBead:(UIView *)senderView;
- (void)setBtnCircleBead:(UIButton *)senderBtn;

#pragma mark - 键盘操作
- (void)setCustomKeyboard:(id)delegate;

@end
