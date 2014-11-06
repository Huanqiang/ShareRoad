//
//  RecordingViewController.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/4.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "RoadInfo.h"
#import "RecordingManage.h"
#import "ShareRoadInfoNetOperation.h"

@protocol MJSecondPopupDelegate;
@interface RecordingViewController : UIViewController<ShareRoadInfoDelegate> {
    RecordingManage *recordingManage;
    AVAudioRecorder *recorder;
    NSTimer *timer;
    int timeCount;
}

@property (weak, nonatomic) IBOutlet UIButton *saveRecordingBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *recordingImageView;
@property (assign, nonatomic) id <MJSecondPopupDelegate>delegate;
@property (assign, nonatomic) RoadInfo *shareRoadInfo;

- (IBAction)saveRecording:(id)sender;
- (IBAction)closePopView:(id)sender;

@end

@protocol MJSecondPopupDelegate<NSObject>
@optional
- (void)cancelButtonClicked:(RecordingViewController *)secondDetailViewController;
@end