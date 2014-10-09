//
//  SettingViewController.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/8.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController () {
    NSArray *tableViewInfo;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tableViewInfo = @[@[@"个人信息", @"位置分享", @"更多分享"], @[@"关于我们"]];
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [tableViewInfo count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[tableViewInfo objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"SettingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.textLabel.text = [[tableViewInfo objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return  cell;    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        PersonInfoViewController *personInfoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonInfoViewController"];
        [self.navigationController pushViewController:personInfoViewController animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        AddressShareViewController *addressShareViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddressShareViewController"];
        [self.navigationController pushViewController:addressShareViewController animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 2) {
        MoreShareViewController *moreShareViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MoreShareViewController"];
        [self.navigationController pushViewController:moreShareViewController animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        AboutUsViewController *aboutUsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
        [self.navigationController pushViewController:aboutUsViewController animated:YES];
    }
}

@end
