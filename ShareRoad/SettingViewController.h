//
//  SettingViewController.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/8.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonInfoViewController.h"
#import "AddressShareViewController.h"
#import "MoreShareViewController.h"
#import "AboutUsViewController.h"

@interface SettingViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;

@end
