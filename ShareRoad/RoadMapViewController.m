//
//  RoadMapViewController.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/8.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "RoadMapViewController.h"

@interface RoadMapViewController ()<MJSecondPopupDelegate> {
    RoadInfo *shareRoadInfo;
    SpeechVideoWithIFlyMSC *speech;
    NSMutableArray *annotationArr;
    NSMutableArray *roadInfoArr;
    int roadInfoIndex;
}

@end

@implementation RoadMapViewController
@synthesize locationTypeBtn;
@synthesize showCameraViewBtn;
@synthesize showRecordingViewBtn;
@synthesize baiduMapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    user = [UserInfo shareInstance];
    shareRoadInfo = [[RoadInfo alloc] init];
    roadInfoArr = [NSMutableArray array];
    annotationArr = [NSMutableArray array];
    speech = [[SpeechVideoWithIFlyMSC alloc] init];
    iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    iFlySpeechSynthesizer = [speech createIFlyMSCVideo:iFlySpeechSynthesizer delegate:self];
    
    //创建文件夹
    if (![[CustomToolClass alloc] theFolderIsExits:@"RoadInfo"]) {
        [[CustomToolClass alloc] createFolderInDocuments:@"RoadInfo"];
    }
    //设置按钮圆角
    [self setBtnCircleBead:locationTypeBtn];
    [self setBtnCircleBead:showRecordingViewBtn];
    [self setBtnCircleBead:showCameraViewBtn];
    
    //控制缩放比例为20米
    baiduMapView.zoomLevel = 17;
    baiduMapView.userTrackingMode = BMKUserTrackingModeFollow;//设置跟踪态
    //设置标尺
    [self setMapScaleBar];
    
    //初始化定位
    locationService = [[BMKLocationService alloc] init];
    [self startLocation];
    //初始化地理反编码
    geocodesearch = [[BMKGeoCodeSearch alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [baiduMapView viewWillDisappear];
    baiduMapView.delegate = self;
    [baiduMapView setMapType:BMKMapTypeTrafficOn];     //设置为实时路况
    locationService.delegate = self;
    geocodesearch.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [baiduMapView viewWillDisappear];
    baiduMapView.delegate = nil;
    locationService.delegate = nil;
    geocodesearch.delegate = nil;
    [getRoadTimer invalidate];
    getRoadTimer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 设置比例尺
- (void)setMapScaleBar {
    baiduMapView.showMapScaleBar = true;
    baiduMapView.mapScaleBarPosition = CGPointMake(60, self.view.frame.size.height - 100);
}

#pragma mark - 切换定位地图类型
- (IBAction)startLocationWithDifferentType:(id)sender {
    [self stopLocation];
    if (locationTypeBtn.tag == 1) {
        [self setMapTypeAsFollow];
        locationTypeBtn.tag = 2;
    }else {
        [self setMapTypeAsFollowWithHeading];
        locationTypeBtn.tag = 1;
    }
    [self startLocation];
}

//设置地图为 罗盘态
- (void)setMapTypeAsFollowWithHeading {
    [locationTypeBtn setTitle:@"跟随" forState:UIControlStateNormal];
    [locationTypeBtn setImage:[UIImage imageNamed:@"Map_Following"] forState:UIControlStateNormal];
    baiduMapView.userTrackingMode = BMKUserTrackingModeFollow;//设置跟随态
}

//设置地图为 跟随态
- (void)setMapTypeAsFollow {
    [locationTypeBtn setTitle:@"罗盘" forState:UIControlStateNormal];
    [locationTypeBtn setImage:[UIImage imageNamed:@"Map_compass"] forState:UIControlStateNormal];
    baiduMapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;//设置罗盘态
}

#pragma mark - 百度地图定位
- (void)startLocation {
    [locationService startUserLocationService];
    self.baiduMapView.showsUserLocation = YES;
}

- (void)stopLocation {
    [locationService stopUserLocationService];
    self.baiduMapView.showsUserLocation = NO;
}

//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    shareRoadInfo.direction = userLocation.heading.trueHeading;
}
//处理位置坐标更新
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    [baiduMapView updateLocationData:userLocation];
    shareRoadInfo.coordinate = userLocation.location.coordinate;
    [self createReverseGeocode:userLocation.location.coordinate];
    
    //获取路况信息
    if (getRoadTimer == nil) {
        [self gainRoadInfoWithNet];
        getRoadTimer = [NSTimer scheduledTimerWithTimeInterval:300 target:self selector:@selector(gainRoadInfoWithNet) userInfo:nil repeats:YES];
    }
}

#pragma mark - 地图反向编码
-(void)createReverseGeocode:(CLLocationCoordinate2D)userLocationCoordinate {
    // BMKReverseGeocodeOption 反geo检索信息类
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeocodeSearchOption.reverseGeoPoint = userLocationCoordinate;
    BOOL flag = [geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    
    if(flag) {
//        NSLog(@"反geo检索发送成功");
    }else {
//        NSLog(@"反geo检索发送失败");
    }
}

//反向编码_百度地图API
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == 0) {
        //操作
        shareRoadInfo.address = result.address;
    }
}

#pragma mark - 标注
//添加标注:传入经纬度
- (void)addPointAnnotation:(RoadInfo *)roadInfo {
    BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc]init];
    pointAnnotation.coordinate = roadInfo.coordinate;
    pointAnnotation.title = roadInfo.address;
    pointAnnotation.subtitle = roadInfo.fileName;
    
    [baiduMapView addAnnotation:pointAnnotation];
    [annotationArr addObject:pointAnnotation];
}


//原理类似 UITableView 循环委托加载 CellforRowWithIndexPath
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation {
    static NSString *AnnotationViewID = @"annotationViewID";
    
    BMKAnnotationView *annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    
    UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 120)];
    popView.layer.masksToBounds = YES;
    popView.layer.cornerRadius = 4.0;
    popView.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    
    //自定义显示的内容
    UIFont * tfont = [UIFont systemFontOfSize:13];
    UILabel *driverName = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, 160, 22)];
    driverName.text = annotation.title;
    driverName.backgroundColor = [UIColor clearColor];
    driverName.font = tfont;
    driverName.textColor = [UIColor blackColor];
    driverName.numberOfLines = 0;
    [popView addSubview:driverName];
    
    //高度估计文本大概要显示几行，宽度根据需求自己定义。 MAXFLOAT 可以算出具体要多高
    CGSize size =CGSizeMake(160,80);
    //    获取当前文本的属性
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    //    ios7方法，获取文本需要的size，限制宽度
    CGSize  actualsize =[annotation.title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    //   更新UILabel的frame
    driverName.frame =CGRectMake(0, 0, 160, actualsize.height);
    
    BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc] initWithCustomView:popView];
    pView.frame = CGRectMake(0, 0, 160, 120);
    driverName.textAlignment = NSTextAlignmentCenter;
    
    //如果是图片标注,设置标注点图标为图片；  如果是语音标注,设置标注点图标为语音
    NSString *pathExtension = [annotation.subtitle pathExtension];
    if ([pathExtension isEqualToString:@"jpg"]) {
        annotationView.image = [UIImage imageNamed:@"Map_AnnotationPicture@2x"];
        //设置弹出气泡图片
        UIImage *image = [UIImage imageWithContentsOfFile:[[PhotoAndCameraClass shareInstance] getImageURLString:annotation.subtitle]];;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, actualsize.height, 160, 120 - actualsize.height);        
        [popView addSubview:imageView];
    }else if ([pathExtension isEqualToString:@"mp3"]) {
        annotationView.image = [UIImage imageNamed:@"Map_AnnotationVoice@2x"];
        popView.frame = CGRectMake(0, 0, 160, actualsize.height);
        pView.frame  = popView.frame;
    }else {
        ((BMKPinAnnotationView *)annotationView).pinColor = BMKPinAnnotationColorGreen;
        popView.frame = CGRectMake(0, 0, 160, actualsize.height);
        pView.frame  = popView.frame;
    }
    
    ((BMKPinAnnotationView*) annotationView).paopaoView = nil;
    ((BMKPinAnnotationView*) annotationView).paopaoView = pView;
    
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));//不知道干什么用的
    annotationView.annotation = annotation;//绑定对应的标点经纬度
    annotationView.canShowCallout = TRUE;//允许点击弹出气泡框
    
    return annotationView;
}

//点击标注
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    NSString *pathExtension = [view.annotation.subtitle pathExtension];
    if ([pathExtension isEqualToString:@"mp3"]) {
        //播放
        NSString *soundPath = [speech gainSoundPath:view.annotation.subtitle];
        [self playSoundWithPath:soundPath];
    }
}

- (void)playSoundWithPath:(NSString *)path {
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *playerError;
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&playerError];
    avPlayer = audioPlayer;
    avPlayer.volume = 1.0f;
    if (avPlayer == nil)
    {
        NSLog(@"ERror creating player: %@", [playerError description]);
    }
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategorySoloAmbient error: nil];
    avPlayer.delegate = self;
    [avPlayer play];
}

#pragma mark - 分享语音
- (IBAction)getRecording:(id)sender {
    [speech playPromptsRing];
    [self popRecordingView];
}

- (void)popRecordingView {
    RecordingViewController *recordingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RecordingViewController"];
    recordingViewController.delegate = self;
    recordingViewController.shareRoadInfo = shareRoadInfo;
    shareRoadInfo.fileType = @"1";
    [self presentPopupViewController:recordingViewController animationType:MJPopupViewAnimationFade];
}

- (void)cancelButtonClicked:(RecordingViewController *)aSecondDetailViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

#pragma mark - 分享图片
- (IBAction)getCameraAndPhoto:(id)sender {
    [self popCameraPickerView];
}

// 弹出照相机界面
- (void)popCameraPickerView {
    UIImagePickerController *cameraPickerController = [[UIImagePickerController alloc] init];
    cameraPickerController = [[PhotoAndCameraClass shareInstance] pickImageFromCamera:cameraPickerController AndController:self];
    [self presentViewController:cameraPickerController animated:YES completion:^{}];
}

// 获取照片后，回调函数 UIImagePickerControllerDelegate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *selectedImage = [info objectForKey:UIImagePickerControllerEditedImage];  // 获取图片
        shareRoadInfo.fileData = UIImageJPEGRepresentation(selectedImage, 0.50);   // 压缩图片，并转为 data
        shareRoadInfo.fileType = @"2";
        [self submitImage];
    }];
}

#pragma mark - 分享操作
- (void)submitImage {
    ShareRoadInfoNetOperation *shareOperation = [[ShareRoadInfoNetOperation alloc] init];
    shareOperation.delegate = self;
    [shareOperation shareRoadInfo:shareRoadInfo];
}

// ShareRoadInfoDelegate 分享照片后网络操作回调
- (void)comebackNetValue:(NSString *)value {
    switch ([value intValue]) {
        case 0: {
            [self.view.window showHUDWithText:@"分享失败" Type:ShowPhotoNo Enabled:YES];
            break;
        }
        case 1: {
            [self.view.window showHUDWithText:@"分享成功" Type:ShowPhotoYes Enabled:YES];
            break;
        }
    }
}

#pragma mark - 获取路况点
- (void)gainRoadInfoWithNet {
    
    [self.view.window showHUDWithText:@"正在获取中..." Type:ShowLoading Enabled:YES];
    NSString *longitude = [NSString stringWithFormat:@"%f", shareRoadInfo.coordinate.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%f", shareRoadInfo.coordinate.latitude];
    
    NSMutableArray *personInfo = [[NSMutableArray alloc] initWithArray:@[@"Longitude", longitude, @"Latitude", latitude, @"TimeQuantum", @"20"]];
    [self webServiceWithNet:@"GetRoadInfo" webServiceParmeters:personInfo success:^(NSDictionary *dic){
        [self dealWithNetManageResult:dic];
    }];
}

//处理网络操作结果
- (void)dealWithNetManageResult:(NSDictionary *)dic {
    switch ([[dic objectForKey:@"result"] intValue]) {
        case 0: {
            [self.view.window showHUDWithText:@"获取失败" Type:ShowPhotoNo Enabled:YES];
            break;
        }
        case 1: {
            //获取路况信息处理
            NSArray *array = [dic objectForKey:@"roadInfo"];
            if ([array isEqual:@[]]) {
                [self.view.window showHUDWithText:@"暂无信息" Type:ShowPhotoYes Enabled:YES];
            }else {
                [speech playGetNewRoadRing];
                [self performSelector:@selector(showAnnotationView:) withObject:array afterDelay:0.9];
            }
            break;
        }
    }
}

- (void)showAnnotationView:(NSArray *)array {
    //移除之前的所有路况点
    [roadInfoArr removeAllObjects];
    [baiduMapView removeAnnotations:annotationArr];
    [annotationArr removeAllObjects];
    
    for (NSDictionary *dic in array) {
        [self setRoadInfo:dic];
    }
    
    [self performSelector:@selector(playSpeaking) withObject:nil afterDelay:1.5];
}

//设置RoadInfo
- (void)setRoadInfo:(NSDictionary *)dic{
    RoadInfo *roadInfo = [[RoadInfo alloc] init];
    roadInfo.coordinate = [roadInfo setCoordinate:[dic objectForKey:@"Longitude"] latitude:[dic objectForKey:@"Latitude"]];
    roadInfo.address = [dic objectForKey:@"address"];
    roadInfo.fileName = [[dic objectForKey:@"URL"] lastPathComponent];
    roadInfo.fileType = [dic objectForKey:@"type"];
    roadInfo.distance = [dic objectForKey:@"distance"];
    [roadInfoArr addObject:roadInfo];
    
    [self saveRoadInfo:[dic objectForKey:@"URL"] andRoadInfo:roadInfo];
}

// 保存附件
- (void)saveRoadInfo:(NSString *)roadInfoURL andRoadInfo:(RoadInfo *)roadInfo{
    NSURL *url = [[NSURL alloc] initWithString:[roadInfo creatFileURL:roadInfoURL]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse* response, NSData* data, NSError* connectionError){
        if (data.length > 0 && connectionError == nil) {
            //保存附件
            [roadInfo saveFile:roadInfoURL contentData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                //添加pointAnnotation
                [self addPointAnnotation:roadInfo];
            });
        }
    }];
}

// 语言播报
- (void)playSpeaking {
    if ([roadInfoArr count] != 0) {
        roadInfoIndex = 0;
        [self startSingleRoadInfoSpeaking:[roadInfoArr objectAtIndex:roadInfoIndex]];
    }
}

//播放单个点
- (void)startSingleRoadInfoSpeaking:(RoadInfo *)roadInfo {
    int x = [[OppositeDirection shareInstance] judgeDirection:shareRoadInfo.coordinate andRoadInfo:roadInfo.coordinate andUserAngle:shareRoadInfo.direction];
    NSString *position = [NSString stringWithFormat:@"重庆人保提醒您,%@%.1d米有新消息", [[OppositeDirection shareInstance] judgePosition:x], [roadInfo.distance intValue]];
    //    重庆人保提醒您前方500米有新消息
    [iFlySpeechSynthesizer startSpeaking:position];
}

#pragma mark - IFlySpeechSynthesizerDelegate
//开始播放
- (void) onSpeakBegin{
}
//缓冲进度
- (void) onBufferProgress:(int) progress message:(NSString *)msg {
    NSLog(@"bufferProgress:%d,message:%@",progress,msg);
}
//播放进度
- (void) onSpeakProgress:(int) progress {
    NSLog(@"play progress:%d",progress);
}
//暂停播放
- (void) onSpeakPaused {
}

//恢复播放
- (void) onSpeakResumed {
}

//结束回调
- (void) onCompleted:(IFlySpeechError *) error {
    if (roadInfoIndex < roadInfoArr.count) {
        RoadInfo *roadInfo = [roadInfoArr objectAtIndex:roadInfoIndex];
        NSString *pathExtension = [roadInfo.fileName pathExtension];
        if ([pathExtension isEqualToString:@"mp3"]) {
            //播放
            NSString *path = [speech gainSoundPath:roadInfo.fileName];
            [self playSoundWithPath:path];
        }else {
            roadInfoIndex++;
            if (roadInfoIndex < roadInfoArr.count) {
                NSThread *myThread = [[NSThread alloc] initWithTarget:self selector:@selector(startSingleRoadInfoSpeaking:) object:[roadInfoArr objectAtIndex: roadInfoIndex]];
                [myThread start];
            }
        }
    }
}

#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    roadInfoIndex++;
    if (roadInfoIndex < roadInfoArr.count) {
        NSThread *myThread = [[NSThread alloc] initWithTarget:self selector:@selector(startSingleRoadInfoSpeaking:) object:[roadInfoArr objectAtIndex: roadInfoIndex]];
        [myThread start];
    }
}


- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:IMAGE_UPLOAD_COMPLETED object:self.imageUploadProgress];
    [[NSNotificationCenter  defaultCenter] removeObserver:self  name:@"pushAPNS" object:nil];
}

@end
