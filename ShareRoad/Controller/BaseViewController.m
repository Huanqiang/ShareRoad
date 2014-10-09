//
//  BaseViewController.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/9.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (void)setBtnCircleBead:(UIButton *)senderBtn {
    senderBtn.layer.masksToBounds = YES;
    senderBtn.layer.cornerRadius = 5.0;
}

- (void)setViewCircleBead:(UIView *)senderView {
    senderView.layer.masksToBounds = YES;
    senderView.layer.cornerRadius = 5.0;
}


@end
