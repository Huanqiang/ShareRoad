//
//  BaseNeedLogInViewController.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/2.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "BaseNeedLogInViewController.h"

@interface BaseNeedLogInViewController ()

@end

@implementation BaseNeedLogInViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)isLogIn {
    if (![[UserInfo shareInstance] isCookie]) {
        //判断用户是否登录
        BOAlertController *alert = [[BOAlertController alloc] initWithTitle:@"抱歉" message:@"您尚未登录，请登录" subView:nil viewController:self];
        RIButtonItem *logInItem = [RIButtonItem itemWithLabel:@"登录" action:^{
            LogInViewController *logInViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
            [self.navigationController pushViewController:logInViewController animated:YES];
        }];
        [alert addButton:logInItem type:RIButtonItemType_Other];
        RIButtonItem *registerItem = [RIButtonItem itemWithLabel:@"注册" action:^{
            RegisteredViewController *logInViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisteredViewController"];
            [self.navigationController pushViewController:logInViewController animated:YES];
        }];
        [alert addButton:registerItem type:RIButtonItemType_Other];
        RIButtonItem *comebackItem = [RIButtonItem itemWithLabel:@"不理睬" action:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addButton:comebackItem type:RIButtonItemType_Other];
        [alert show];
    }
}

@end
