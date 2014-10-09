//
//  PersonInfoViewController.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/9.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "PersonInfoViewController.h"

@interface PersonInfoViewController ()

@end

@implementation PersonInfoViewController
@synthesize personAddressTextField;
@synthesize personAddressView;
@synthesize personIconImageView;
@synthesize personNameLabel;
@synthesize personNameTextField;
@synthesize personNameView;
@synthesize personPhoneTextField;
@synthesize personPhoneView;
@synthesize personSexBtn;
@synthesize saveOrLogOutBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBtnCircleBead:saveOrLogOutBtn];
    [self setViewCircleBead:personNameView];
    [self setViewCircleBead:personAddressView];    
    [self setViewCircleBead:personPhoneView];
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

- (IBAction)selectedSex:(id)sender {
}

- (IBAction)modifyPersonInfo:(id)sender {
}

- (IBAction)modifyPersonPassword:(id)sender {
}

- (IBAction)saveOrLogOut:(id)sender {
}
@end
