//
//  RecordingManage.h
//  IFlyTest
//
//  Created by 枫叶 on 14-7-17.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#include "lame.h"  

@interface RecordingManage : NSObject<AVAudioRecorderDelegate>

#pragma mark - 外部文件可以直接访问RecordingManage内部函数
+ (id)shareInstance;

#pragma mark - 录音
//录音设置
- (AVAudioRecorder *)audioSetting:(id)delegate;

/*
 方法：开始录音
 参数介绍：
 recorder：     AVAudioRecorder对象
 */
- (void)startRecord:(AVAudioRecorder *)recorder;

/*
 方法：停止录音
 参数介绍：
 recorder：     AVAudioRecorder对象
 */
- (void)stopRecord:(AVAudioRecorder *)recorder;

/*
 方法：删除录制文件
 参数介绍：
 recorder：     AVAudioRecorder对象
 */
- (void)deleteRecord:(AVAudioRecorder *)recorder;

/*
 方法：获取录音文件路径
 */
- (NSString *)getRecordingURL;
- (NSString *)getRecordingMP3URL;

/*
 方法：转编码为mp3
 */
- (void)audio_PCMtoMP3:(NSString *)cafFilePath andMP3FilePath:(NSString *)mp3FilePath;

/*
 方法：播放录音
 参数介绍：
 avPlayURL：     录音文件地址URL
 avPlay：        AVAudioPlayer对象
 */
- (void)playRecordSound:(NSURL *)avPlayURL AndAudioPlayer:(AVAudioPlayer *)avPlay;

@end
