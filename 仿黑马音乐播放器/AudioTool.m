//
//  AudioTool.m
//  仿黑马音乐播放器
//
//  Created by 刘伟 on 2017/9/11.
//  Copyright © 2017年 刘伟. All rights reserved.
//

#import "AudioTool.h"

@implementation AudioTool

static NSMutableDictionary *_soundIDs;

static NSMutableDictionary *_players;

+ (NSMutableDictionary *)soundIDs
{
    if (!_soundIDs) {
        _soundIDs = [NSMutableDictionary dictionary];
    }
    return _soundIDs;
}
+ (NSMutableDictionary *)players
{
    if (!_players) {
        _players = [NSMutableDictionary dictionary];
    }
    return _players;
}
// 根据音乐文件名称播放音乐
+ (AVAudioPlayer *)playMusicWithFilename:(NSString  *)filename{
    
    AVAudioPlayer *player = [self players][filename];
    
    if (!player) {
        
        NSURL *url = [[NSBundle mainBundle]URLForResource:filename withExtension:nil];
        if (!url) {
            return nil;
        }
        
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        if (![player prepareToPlay]) {
            return nil;
        }
        
        [self players][filename] = player;
    }
    if (!player.playing)
    {
        [player play];
    }
    
    return player;

}

//停止正在播放的音乐
+ (void)stopMusicWithFilename:(NSString  *)filename{
    // 0.判断文件名是否为nil
    if (filename == nil) {
        return;
    }
    
    // 1.从字典中取出播放器
    AVAudioPlayer *player = [self players][filename];
    
    // 2.判断播放器是否为nil
    if (player) {
        // 2.1停止播放
        [player stop];
        // 2.2清空播放器
        //        player = nil;
        // 2.3从字典中移除播放器
        [[self players] removeObjectForKey:filename];
    }
}


@end








































