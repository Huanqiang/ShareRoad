//
//  SpeechVideoWithIFlyMSC.m
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/5.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "SpeechVideoWithIFlyMSC.h"

@implementation SpeechVideoWithIFlyMSC

- (IFlySpeechSynthesizer *)createIFlyMSCVideo:(IFlySpeechSynthesizer *)iFlySpeechSynthesizer delegate:(id)delegate {
    // 创建合成对象
    iFlySpeechSynthesizer.delegate = delegate;
    //设置语音合成的参数
    //合成的语速,取值范围 0~100
    [iFlySpeechSynthesizer setParameter:@"14" forKey:[IFlySpeechConstant SPEED]];
    //合成的音量;取值范围 0~100
    [iFlySpeechSynthesizer setParameter:@"100" forKey:[IFlySpeechConstant VOLUME]];
    //发音人,默认为”xiaoyan”;可以设置的参数列表可参考个性化发音人列表
    [iFlySpeechSynthesizer setParameter:@"xiaoyan" forKey:[IFlySpeechConstant VOICE_NAME]];
    //音频采样率,目前支持的采样率有 16000 和 8000
    [iFlySpeechSynthesizer setParameter:@"16000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
    //语速控制
    [iFlySpeechSynthesizer setParameter:@"60" forKey:[IFlySpeechConstant SPEED]];
    ////asr_audio_path保存录音文件路径，如不再需要，设置value为nil表示取消，默认目录是documents
    [iFlySpeechSynthesizer setParameter:nil forKey:[IFlySpeechConstant TTS_AUDIO_PATH]];
    
    return iFlySpeechSynthesizer;
}

- (NSString *)gainSoundPath:(NSString *)fileName {
    //这里将图片放在沙盒的documents文件夹中
    NSString * documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *subdir = [documentsPath stringByAppendingPathComponent:@"RoadInfo"]; //RoadInfo就是你创建的文件夹名
    NSString *path = [subdir stringByAppendingPathComponent:fileName];
    
    return path;
}

#pragma mark - 播放系统提示音

- (void)playGetNewRoadRing {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"getNewRoadInfoRing" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    [self playSystemSound:url];
}

- (void)playPromptsRing {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"promptsRing" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    [self playSystemSound:url];
}

- (void)playSystemSound:(NSURL *)url
{
    //AudioServicesPlaySystemSound播放WAV格式
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
    /*添加音频结束时的回调*/
    //    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, SoundFinished, (__bridge void *)(url));
    /*开始播放*/
    AudioServicesPlaySystemSound(soundID);
}

@end
