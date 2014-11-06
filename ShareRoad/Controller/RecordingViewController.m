//
//  RecordingViewController.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/4.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "RecordingViewController.h"


@implementation RecordingViewController
@synthesize saveRecordingBtn;
@synthesize closeBtn;
@synthesize recordingImageView;
@synthesize shareRoadInfo;


- (void)viewWillAppear:(BOOL)animated {
    self.view.layer.masksToBounds = YES;
    self.view.layer.cornerRadius = 5.0;
    //重新设置弹出框的大小和位置
    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    [self.view setFrame:CGRectMake((window.frame.size.width - 244)/2, (window.frame.size.height- 200)/2, 244, 200)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    recordingManage = [RecordingManage shareInstance];
    recorder = [recordingManage audioSetting:self];
    [recordingManage startRecord:recorder];
    timeCount = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(soundImageChanged) userInfo:nil repeats:YES];
}

- (void)soundImageChanged {
    if (recorder.currentTime >= 10) {
        [self stopRecording];
        [self saveVoice];
        return;
    }
    
    timeCount ++;
    if (timeCount > 4) {
        timeCount = 1;
    }
    [recordingImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Speak_Voice%d.png",timeCount]]];
}


#pragma mark - 录音操作
- (void)stopRecording {
    [timer invalidate];
    [recordingManage stopRecord:recorder];
    shareRoadInfo.fileData = [self getVioce];
}

#pragma mark - 网络保存
- (IBAction)saveRecording:(id)sender {
    [self stopRecording];
    [self saveVoice];
}

- (void)saveVoice {
    self.view.hidden = YES;
    [self.view.window showHUDWithText:@"正在分享中..." Type:ShowLoading Enabled:YES];
    ShareRoadInfoNetOperation *share = [[ShareRoadInfoNetOperation alloc] init];
    share.delegate = self;
    [share shareRoadInfo:shareRoadInfo];
}

- (NSData *)getVioce {
    NSString *voicePath = [recordingManage getRecordingURL];
    NSString *voicemp3 = [recordingManage getRecordingMP3URL];
    [recordingManage audio_PCMtoMP3:voicePath andMP3FilePath:voicemp3];
    NSData *voiceData = [NSData dataWithContentsOfFile:voicemp3];
    return voiceData;
}

// ShareRoadInfoDelegate
- (void)comebackNetValue:(NSString *)value {
    switch ([value intValue]) {
        case 0: {
            [self.view.window showHUDWithText:@"分享失败" Type:ShowPhotoNo Enabled:YES];
            break;
        }
        case 1: {
            [self.view.window showHUDWithText:@"分享成功" Type:ShowPhotoYes Enabled:YES];
            [self performSelector:@selector(closeSelf) withObject:nil afterDelay:0.9];
            break;
        }
    }
}

#pragma mark - 关闭窗口
- (IBAction)closePopView:(id)sender {
    [self closeSelf];
}

- (void)closeSelf {
    [self stopRecording];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}
@end
