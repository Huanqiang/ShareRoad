//
//  PersonInfoViewController.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/9.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "PersonInfoViewController.h"

@interface PersonInfoViewController () {
    UserInfo *user;
    CLLocationManager *locationManager;
}

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
@synthesize saveBtn;
@synthesize logOutBtn;
@synthesize getAddressInfoBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self->className = @"PersonInfoViewController";
    [self setKeyBoard];
    [self setViewcornerRadius];
    user = [UserInfo shareInstance];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked)];
    [personIconImageView addGestureRecognizer:singleTap];
    
    [self isLogIn];
}

//设置键盘
- (void)setKeyBoard {
    personNameTextField.userInteractionEnabled = NO;
    self->keyboardSize.height = 216;
    self->textFieldArr = @[personPhoneTextField, personAddressTextField];
    [self setCustomKeyboard:self];
}

//设置按钮为圆角
- (void)setViewcornerRadius {
    [self setBtnCircleBead:saveBtn];
    [self setBtnCircleBead:logOutBtn];
    [self setViewCircleBead:personNameView];
    [self setViewCircleBead:personAddressView];
    [self setViewCircleBead:personPhoneView];
    personIconImageView.layer.masksToBounds = YES;
    personIconImageView.layer.cornerRadius = personIconImageView.frame.size.height / 2;
}

- (void)viewWillAppear:(BOOL)animated {
    [self setPersonInfo];
    [self viewOperationSetting];
    [self isExistAddress];
}

//设置用户信息
- (void)setPersonInfo {
    //读取文本信息，判断有无用户头像、姓名、性别、手机号、所在地；
    NSLog(@"name:%@", [user gainUserName]);
    personNameTextField.text = [user gainUserName];
    personNameLabel.text = [user gainUserName];
    personPhoneTextField.text = [user gainUserPhone];
    personAddressTextField.text = [user gainUserAddress];
    
    NSString *userImagePath = [user gainUserIconPath];
    if (![userImagePath isEqualToString:@""]) {
        personIconImageView.image = [UIImage imageWithContentsOfFile:userImagePath];
    }
    NSString *userSex = [user gainUserSex];
    if (![userSex isEqualToString:@""]) {
        if ([userSex intValue] == 1) {
            personSexBtn.tag = 1;
        }else if ([userSex intValue] == 2) {
            personSexBtn.tag = 2;
        }
        [self setUserSex];
    }
}

- (void)setUserSex {
    if (personSexBtn.tag == 1) {
        [self.personSexBtn setImage:[UIImage imageNamed:@"Person_SexBoy"] forState:UIControlStateNormal];
    }else if (personSexBtn.tag == 2) {
        [self.personSexBtn setImage:[UIImage imageNamed:@"Person_SexGirl"] forState:UIControlStateNormal];
    }
}

//设置界面一开始时候的操作
- (void)viewOperationSetting {
    saveBtn.hidden = YES;
    logOutBtn.hidden = NO;
    personAddressTextField.userInteractionEnabled = NO;
    personIconImageView.userInteractionEnabled = NO;
    personNameTextField.userInteractionEnabled = NO;
    personPhoneTextField.userInteractionEnabled = NO;
    personSexBtn.userInteractionEnabled = NO;
    getAddressInfoBtn.userInteractionEnabled = NO;
}

//判断用户所在地是否存在
- (void)isExistAddress {
    if ([personAddressTextField.text isEqualToString:@""]) {
        getAddressInfoBtn.hidden = NO;
        personAddressTextField.hidden = YES;
    }else {
        getAddressInfoBtn.hidden = YES;
        personAddressTextField.hidden = NO;
    }
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
    BOAlertController *actionSheet = [[BOAlertController alloc] initWithTitle:@"请选择性别" message:nil subView:nil viewController:self];
    RIButtonItem *boyItem = [RIButtonItem itemWithLabel:@"男" action:^{
        personSexBtn.tag = 1;
        [self setUserSex];
    }];
    [actionSheet addButton:boyItem type:RIButtonItemType_Other];
    RIButtonItem *girlItem = [RIButtonItem itemWithLabel:@"女" action:^{
        personSexBtn.tag = 2;
        [self setUserSex];
    }];
    [actionSheet addButton:girlItem type:RIButtonItemType_Other];
    [actionSheet showInView:self.view];
}

#pragma mark - 修改个人信息
- (IBAction)modifyPersonInfo:(id)sender {
    saveBtn.hidden = NO;
    logOutBtn.hidden = YES;
    personAddressTextField.userInteractionEnabled = YES;
    personIconImageView.userInteractionEnabled = YES;
    personPhoneTextField.userInteractionEnabled = YES;
    personSexBtn.userInteractionEnabled = YES;
    getAddressInfoBtn.userInteractionEnabled = YES;
    
    [personPhoneTextField becomeFirstResponder];
}

#pragma mark - 修改密码
- (IBAction)modifyPersonPassword:(id)sender {
    
}

#pragma mark - 更新信息
//获取相册图片
- (void)imageClicked {
    UIImagePickerController *imagerPickerController = [[UIImagePickerController alloc] init];
    imagerPickerController.delegate = self;
    imagerPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagerPickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagerPickerController.allowsEditing = YES;
    [self presentViewController:imagerPickerController animated:YES completion:^{}];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *selectedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        NSData *imageData = UIImagePNGRepresentation(selectedImage);
        [user saveUserIcon:imageData];
        personIconImageView.image = selectedImage;
    }];
}

- (IBAction)savePersonInfo:(id)sender {    
    [self hidenKeyboard];
    
    NSDictionary *dic = [user gainUserIcon];
    NSData *imageData = [dic allValues][0];
    NSString *hasImage = [dic allKeys][0];
    
    //将图片转为base64编码
    NSString *imageInfoString = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSString *phoneNum = personPhoneTextField.text;
    if ([personPhoneTextField.text isEqualToString:[user gainUserPhone]]) {
        phoneNum = @"1";
    }
    
    if ([[CustomToolClass shareInstance] TextFieldIsFull:self->textFieldArr]) {
        [self.view.window showHUDWithText:@"正在更新中..." Type:ShowLoading Enabled:YES];
        NSMutableArray *personInfo = [[NSMutableArray alloc] initWithArray:@[@"UserName", [user gainUserName], @"userIcon", imageInfoString, @"Address", personAddressTextField.text, @"userSex", [NSString stringWithFormat:@"%ld", (long)personSexBtn.tag],  @"hasImage", hasImage,  @"MobileNo", phoneNum]];
        
        [self webServiceWithNet:@"UpdatePersonInfo" webServiceParmeters:personInfo success:^(NSDictionary *dic){
            [self dealWithNetManageResult:[dic objectForKey:@"result"]];
        }];
    }else {
        [self showAlertView:@"抱歉" msg:@"请填写完整信息" delegate:self];
    }
}

//处理网络操作结果
- (void)dealWithNetManageResult:(NSString *)result {
    NSString *msg = @"";
    switch ([result intValue]) {
        case 0:
        {
            msg = @"更新失败";
            break;
        }
        case 1:
        {
            [self.view.window showHUDWithText:@"修改成功" Type:ShowPhotoYes Enabled:YES];
            [self saveUserInfoAfterGetPersonInfo];            
            break;
        }
    }
    if (![msg isEqualToString:@""]) {
        [self showAlertView:@"抱歉" msg:msg delegate:self];
    }
    [self viewOperationSetting];
}

//保存到本地
- (void)saveUserInfoAfterGetPersonInfo {
    [user saveUserIconPath];
    [user saveUserPhone:personPhoneTextField.text];
    [user saveUserAddress:personAddressTextField.text];
    [user saveUserSex:[NSString stringWithFormat:@"%ld",(long)personSexBtn.tag]];
}

#pragma mark - 注销
- (IBAction)logOut:(id)sender {
    [user removeUserCookie];
    [user removeUserIcon];
    [user removeUserName];
    [user removeUserPhone];
    [user removeUserSex];
    [user removeUserAddress];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 定位
- (IBAction)getAddressInfo:(id)sender {
    [self initLocationManager];
}

- (void)initLocationManager {
    locationManager=[[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];
}

//地理位置发生改变时触发  CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // 停止位置更新
    [manager stopUpdatingLocation];
    
    CLLocation *loactionGCJ = [newLocation locationMarsFromEarth];
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:loactionGCJ completionHandler:^(NSArray *placemarks, NSError *error) {
        if(placemarks.count > 0) {
            [self.view.window showHUDWithText:@"获取成功" Type:ShowPhotoYes Enabled:YES];
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            personAddressTextField.text = placemark.name;
            [self isExistAddress];
        }else {
            [self.view.window showHUDWithText:@"获取失败" Type:ShowPhotoYes Enabled:YES];
        }
    }];
}

// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
}
@end
