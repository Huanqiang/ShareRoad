//
//  BOAlertController.h
//  AlertViewTest
//
//  Created by wanghuanqiang on 14/10/12.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

/*   ******使用说明******
 介绍：
 对于 alertView 和 actionSheet 这两个弹出试图来说，创建方法是一致的；
 想使用 ActionSheet 则调用 showInView: 方法；
 想使用 AlertView 则使用 show 方法；
 
 使用方法：
 BOAlertController *actionSheet = [[BOAlertController alloc] initWithTitle:@"title" message:nil viewController:self];
 
 RIButtonItem *cancelItem = [RIButtonItem itemWithLabel:@"取消" action:^{
    NSLog(@"123");
 }];
 [actionSheet addButton:cancelItem type:RIButtonItemType_Cancel];
 
 RIButtonItem *okItem = [RIButtonItem itemWithLabel:@"确定" action:^{
    NSLog(@"345");
 }];
 [actionSheet addButton:okItem type:RIButtonItemType_Destructive];

 [actionSheet showInView:self.view];
 */

typedef enum {
    RIButtonItemType_Cancel         = 1,
    RIButtonItemType_Destructive       ,
    RIButtonItemType_Other
}RIButtonItemType;

typedef enum {
    BOAlertControllerType_AlertView    = 1,
    BOAlertControllerType_ActionSheet
}BOAlertControllerType;

#define isIOS8  ([[[UIDevice currentDevice]systemVersion]floatValue]>=8)

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RIButtonItem.h"

@interface BOAlertController : NSObject

- (id)initWithTitle:(NSString *)title message:(NSString *)message subView:(UIView *)subView viewController:(UIViewController *)inViewController;
- (void)addButton:(RIButtonItem *)button type:(RIButtonItemType)itemType;

//Show ActionSheet in all versions
- (void)showInView:(UIView *)view;

//Show AlertView in all versions
- (void)show;

@end