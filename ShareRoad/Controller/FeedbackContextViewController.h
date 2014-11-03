//
//  FeedbackContextViewController.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/3.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "BaseNeedLogInViewController.h"

@interface FeedbackContextViewController : BaseNeedLogInViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UITextView *feedbackContext;
@property (weak, nonatomic) IBOutlet UIButton *submitFeedbackContextBtn;
- (IBAction)submitFeedbackContext:(id)sender;
@end
