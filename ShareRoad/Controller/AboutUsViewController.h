//
//  AboutUsViewController.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/9.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "BaseViewController.h"
#import "FeedbackContextViewController.h"
#import "StartViewController.h"

@interface AboutUsViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;

@end
