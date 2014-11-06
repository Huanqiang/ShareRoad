//
//  SpeechVideoWithIFlyMSC.h
//  ShareRoad
//
//  Created by wanghuanqiang on 14/11/5.
//  Copyright (c) 2014年 枫叶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoadInfo.h"
#import <AVFoundation/AVFoundation.h>
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "iflyMSC/IFlySpeechConstant.h"

@interface SpeechVideoWithIFlyMSC : UIViewController

- (IFlySpeechSynthesizer *)createIFlyMSCVideo:(IFlySpeechSynthesizer *)iFlySpeechSynthesizer delegate:(id)delegate;
- (NSString *)gainSoundPath:(NSString *)fileName;
- (void)playGetNewRoadRing;
- (void)playPromptsRing;

@end
