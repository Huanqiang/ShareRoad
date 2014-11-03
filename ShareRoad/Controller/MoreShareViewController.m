//
//  MoreShareViewController.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/9.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "MoreShareViewController.h"

@interface MoreShareViewController () {
    NSMutableArray *platformArr;
    NSArray *platformImageNameArr;
}

@end

@implementation MoreShareViewController
@synthesize mainTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"更多分享";
    int tableArr[] = {SinaWeibo};
    platformImageNameArr = @[@"sinaWeibo"];
    
    platformArr = [NSMutableArray array];
    [self createPlatform:tableArr];
}

- (void)createPlatform:(int *)tableArr {
    PlatformShareFactory *platformShareFactory = [[PlatformShareFactory alloc] init];
    for (int i = 0; i < 1; i++) {
        PlatformShare *plat = [platformShareFactory createPlatform:tableArr[i]];
        [platformArr addObject:plat];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView 操作
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return platformArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"MoreShareCell";
    MoreShareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString *imageName = [platformImageNameArr objectAtIndex:indexPath.row];
    cell.platformImageView.image = [UIImage imageNamed:imageName];
    
    PlatformShare *plat = [platformArr objectAtIndex:indexPath.row];
    if ([plat isAuthWithPlatformType]) {
        cell.platformPersonNameLabel.hidden = NO;
        cell.platformPersonNameLabel.text = [plat gainPlatformPersonName];
        cell.platformISLogInLabel.hidden = NO;
        cell.platformIsNotLogInLabel.hidden = YES;
        [cell.platformISLogInBtn setTitle:@"取消授权" forState:UIControlStateNormal];
    }else {
        cell.platformPersonNameLabel.hidden = YES;
        cell.platformISLogInLabel.hidden = YES;
        cell.platformIsNotLogInLabel.hidden = NO;
        [cell.platformISLogInBtn setTitle:@"授权" forState:UIControlStateNormal];
    }
    cell.platformISLogInBtn.tag = indexPath.row;
    [cell.platformISLogInBtn addTarget:self action:@selector(authSharePlatform:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)authSharePlatform:(UIButton *)button {
    PlatformShare *plat = [platformArr objectAtIndex:button.tag];
    if ([plat isAuthWithPlatformType]) {
        [plat cancelAuthWithPlatformType];
        [mainTableView reloadData];
    }else {
        [[ShareContentWithShareSDK shareInstance] shareContent:@"我正在使用“路况知音”APP" AndPublishImage:nil AndSharePlatformType:ShareTypeSinaWeibo AndDealWithData:^{
            [mainTableView reloadData];
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
