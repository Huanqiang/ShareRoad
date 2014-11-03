//
//  MoreShareViewController.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/9.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "BaseViewController.h"
#import "MoreShareTableViewCell.h"
#import "PlatformShare.h"
#import "PlatformShareFactory.h"

@interface MoreShareViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end
