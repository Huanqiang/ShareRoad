//
//  RecordingManage.m
//  IFlyTest
//
//  Created by 枫叶 on 14-7-17.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import "RecordingManage.h"

@implementation RecordingManage

static RecordingManage *instnce;
#pragma mark - 外部文件可以直接访问RecordingManage内部函数
+ (id)shareInstance {
    if (instnce == nil) {
        instnce = [[[self class] alloc] init];
    }
    return instnce;
}

#pragma mark - 录音

//录音设置
- (AVAudioRecorder *)audioSetting:(id)delegate
{
    //用于获取IOS7的录音权限
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    [audioSession setActive:YES error:nil];
    //录音设置
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:11025.0] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    
    //录音文件的存放
    NSURL *url = [NSURL fileURLWithPath:[self getRecordingURL]];
    
    NSError *error;
    //初始化
    AVAudioRecorder *recorder = [[AVAudioRecorder alloc]initWithURL:url settings:recordSetting error:&error];
    //开启音量检测
    recorder.meteringEnabled = YES;
    recorder.delegate = delegate;
    
    return recorder;
}

- (NSString *)getRecordingURL {
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    // 這句就是在上面獲取的路徑下加上你创建的文件夹的路径  类似xxx/xxxx/xxx/Documents/subdir/
    NSString *subdir = [DocumentsPath stringByAppendingPathComponent:@"RoadInfo"];//RoadInfo就是你创建的文件夹名
    NSString *recordingURL = [NSString stringWithFormat:@"%@/lll.caf", subdir];
    return recordingURL;
}

- (NSString *)getRecordingMP3URL {
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    // 這句就是在上面獲取的路徑下加上你创建的文件夹的路径  类似xxx/xxxx/xxx/Documents/subdir/
    NSString *subdir = [DocumentsPath stringByAppendingPathComponent:@"RoadInfo"];  //RoadInfo就是你创建的文件夹名
    NSString *recordingURL = [NSString stringWithFormat:@"%@/lll.mp3", subdir];
    return recordingURL;
}

- (void)startRecord:(AVAudioRecorder *)recorder {
    // 创建录音文件，准备录音
    if ([recorder prepareToRecord]) {
        // 开始
        [recorder record];
        NSLog(@"开始录音");
    }
}

// 停止录音
- (void)stopRecord:(AVAudioRecorder *)recorder {
    double cTime = recorder.currentTime;
    if (cTime > 2) {// 如果录制时间<2 不发送
        
    }else {
        // 删除记录的文件
        [recorder deleteRecording];
    }
    [recorder stop];
}

// 删除录制文件
- (void)deleteRecord:(AVAudioRecorder *)recorder {
    //删除录制文件
    [recorder deleteRecording];
    [recorder stop];
    
    NSLog(@"取消发送");
}

//转编码为 mp3
- (void)audio_PCMtoMP3:(NSString *)cafFilePath andMP3FilePath:(NSString *)mp3FilePath
{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    if([fileManager removeItemAtPath:mp3FilePath error:nil]) {
        NSLog(@"删除");
    }
    
    @try {
        int read, write;
        
        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置

        if(pcm == NULL) {
            NSLog(@"file not found");
        } else {
            fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
            FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
            
            const int PCM_SIZE = 8192;
            const int MP3_SIZE = 8192;
            short int pcm_buffer[PCM_SIZE*2];
            unsigned char mp3_buffer[MP3_SIZE];
            
            lame_t lame = lame_init();
            lame_set_in_samplerate(lame, 11025.0);
            lame_set_VBR(lame, vbr_default);
            lame_init_params(lame);
            
            do {
                read = fread(pcm_buffer, 2 * sizeof(short int), PCM_SIZE, pcm);
                if (read == 0)
                    write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
                else
                    write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
                
                fwrite(mp3_buffer, write, 1, mp3);
                
            } while (read != 0);
            
            lame_close(lame);
            fclose(mp3);
            fclose(pcm);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        NSLog(@"MP3生成成功");
    }
}


//播放录音
- (void)playRecordSound:(NSURL *)avPlayURL AndAudioPlayer:(AVAudioPlayer *)avPlay {
    if (avPlay.playing) {
        [avPlay stop];
        return;
    }
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:avPlayURL error:nil];
    avPlay = player;
    [avPlay play];
}

@end
