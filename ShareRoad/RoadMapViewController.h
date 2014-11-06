//
//  RoadMapViewController.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/10/8.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "BaseViewController.h"
#import "BMapKit.h"
#import "OppositeDirection.h"
#import "ShareRoadInfoDelegate.h"
#import "ShareRoadInfoNetOperation.h"
#import "UIViewController+MJPopupViewController.h"
#import "RecordingViewController.h"
#import "SpeechVideoWithIFlyMSC.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"

@interface RoadMapViewController : BaseViewController<BMKMapViewDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate, ShareRoadInfoDelegate, IFlySpeechSynthesizerDelegate, UIImagePickerControllerDelegate, AVAudioPlayerDelegate> {
    BMKLocationService *locationService;
    BMKGeoCodeSearch *geocodesearch;
    IFlySpeechSynthesizer *iFlySpeechSynthesizer;
    AVAudioPlayer *avPlayer;
    NSTimer *getRoadTimer;
}

@property (weak, nonatomic) IBOutlet BMKMapView *baiduMapView;
@property (weak, nonatomic) IBOutlet UIButton *locationTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *showRecordingViewBtn;
@property (weak, nonatomic) IBOutlet UIButton *showCameraViewBtn;

- (IBAction)startLocationWithDifferentType:(id)sender;
- (IBAction)getRecording:(id)sender;
- (IBAction)getCameraAndPhoto:(id)sender;





@end
