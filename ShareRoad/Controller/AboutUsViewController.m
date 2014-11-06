//
//  AboutUsViewController.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/9.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController () {
    NSArray *aboutThisArr;
}

@end

@implementation AboutUsViewController
@synthesize mainTableView;
@synthesize urlLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于我们";
    
    aboutThisArr = @[@"功能介绍", @"给我评分", @"意见反馈"];
    
    UITapGestureRecognizer *openURLTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openDreamURL:)];
    [urlLabel addGestureRecognizer:openURLTapRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return aboutThisArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"AboutUsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [aboutThisArr objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        StartViewController * startViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StartViewController"];
        startViewController.login = @"1";
        [self presentViewController:startViewController animated:YES completion:nil];
    }else if(indexPath.row == 1) {
        [[CustomToolClass shareInstance] gotoGrade:MyAppID];
    }else if(indexPath.row == 2) {
        FeedbackContextViewController *feedbackContextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedbackContextViewController"];
        [self.navigationController pushViewController:feedbackContextViewController animated:YES];
    }
}

//打开dream网址
-(void)openDreamURL:(id)sender
{
    [[CustomToolClass shareInstance] openDreamURL:urlLabel.text];
}

@end
