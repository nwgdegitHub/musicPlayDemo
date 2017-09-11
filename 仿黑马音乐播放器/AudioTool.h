//
//  AudioTool.h
//  仿黑马音乐播放器
//
//  Created by 刘伟 on 2017/9/11.
//  Copyright © 2017年 刘伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioTool : NSObject

// 根据音乐文件名称播放音乐
+ (AVAudioPlayer *)playMusicWithFilename:(NSString  *)filename;
// 根据音乐文件名称停止音乐
+ (void)stopMusicWithFilename:(NSString  *)filename;

@end
