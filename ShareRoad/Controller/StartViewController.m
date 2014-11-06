//
//  StartViewController.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/6.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "StartViewController.h"

@implementation StartViewController
@synthesize login;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *firstLogin = [[LogInToolClass shareInstance] getUserInfo:@"firstLogin"];
    if ([firstLogin isEqualToString:@""] && login == nil) {
        [self showIntroWithCrossDissolve];
        [[LogInToolClass shareInstance] saveUserInfo:@"1" AndInfoType:@"firstLogin"];
    }else {
        if ([firstLogin isEqualToString:@"1"] && [login isEqualToString:@"1"]) {
            [self showIntroWithCrossDissolve];
            [[LogInToolClass shareInstance] saveUserInfo:@"1" AndInfoType:@"firstLogin"];
        }else {
            [self gotoTabBarViewController];
        }
    }
}

- (void)showIntroWithCrossDissolve {
    
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"路况知音";
    page1.desc = @"您的出行之选，随时随地了解最新路况";
    page1.bgImage = [UIImage imageNamed:@"Start_BgImage.jpg"];
    page1.titleImage = [UIImage imageNamed:@"StartImage1"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"准确定位";
    page2.desc = @"所在地清晰查看，掌握路况第一手资料！";
    page2.bgImage = [UIImage imageNamed:@"Start_BgImage.jpg"];
    page2.titleImage = [UIImage imageNamed:@"StartImage2"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"智能路况分享";
    page3.desc = @"让路况化成语音、图片，与他人实时分享！";
    page3.bgImage = [UIImage imageNamed:@"Start_BgImage.jpg"];
    page3.titleImage = [UIImage imageNamed:@"StartImage3"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3]];
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - EAIntroDelegate

- (void)introDidFinish {
    if ([login isEqualToString:@"1"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self gotoTabBarViewController];
    }
}


- (void)gotoTabBarViewController {
    //动画
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.7;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionFade;
    [[self.view layer] addAnimation:animation forKey:@"animation"];
    
    UIApplication *app =[UIApplication sharedApplication];
    AppDelegate *app2 = (AppDelegate *)app.delegate;
    app2.window.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBarViewController"];
    
}


@end
