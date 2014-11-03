//
//  MoreShareTableViewCell.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/3.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreShareTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *platformImageView;
@property (weak, nonatomic) IBOutlet UILabel *platformPersonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *platformISLogInLabel;
@property (weak, nonatomic) IBOutlet UILabel *platformIsNotLogInLabel;
@property (weak, nonatomic) IBOutlet UIButton *platformISLogInBtn;
@end
