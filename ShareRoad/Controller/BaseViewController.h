//
//  BaseViewController.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/9.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UITextFieldDelegate>

- (void)setViewCircleBead:(UIView *)senderView;
- (void)setBtnCircleBead:(UIButton *)senderBtn;

@end
