//
//  MusicsTool.m
//  仿黑马音乐播放器
//
//  Created by 刘伟 on 2017/9/11.
//  Copyright © 2017年 刘伟. All rights reserved.
//

#import "MusicsTool.h"
#import "MJExtension.h"
#import "MusicModel.h"
@implementation MusicsTool

// 所有歌曲
static NSArray *_musics;

// 当前正在播放歌曲
static  MusicModel *_playingMusic;

+(NSArray *)musics{
    if (!_musics) {
        _musics = [MusicModel objectArrayWithFilename:@"Musics.plist"];
    }
    return _musics;
}

// 返回当前正在播放的音乐
+ (MusicModel *)playingMusic
{
    return _playingMusic;
}

// 设置当前正在播放的音乐
+ (void)setPlayingMusic:(MusicModel *)music{

    // 判断传入的音乐模型是否为nil
    // 判断数组中是否包含该音乐模型
    if (!music || ![[self musics] containsObject:music]) {
        return;
    }
   _playingMusic = music;

}

// 获取下一首
+ (MusicModel *)nextMusic{
    
    //先获得当前音乐在数组的下标
    NSUInteger currentMusicIndex = [_musics indexOfObject:_playingMusic];
    
    //防止本地音乐文件数组越界
    NSUInteger nextMusicIndex;
    if (currentMusicIndex == _musics.count-1) {
        nextMusicIndex = 0;
    }
    else {
        nextMusicIndex = currentMusicIndex+1;
    }
    MusicModel *nextMusic = [_musics objectAtIndex:nextMusicIndex];
    
    return nextMusic;
    
}

// 获取上一首
+ (MusicModel *)previouesMusic{
    
    //先获得当前音乐在数组的下标
    NSUInteger currentMusicIndex = [_musics indexOfObject:_playingMusic];
    
    //防止本地音乐文件数组越界
    NSUInteger previouesMusicIndex;
    if (currentMusicIndex == 0) {
        previouesMusicIndex = _musics.count-1;
    }
    else {
        previouesMusicIndex = currentMusicIndex-1;
    }

    MusicModel *lastMusic = [_musics objectAtIndex:previouesMusicIndex];
    
    return lastMusic;

}

@end















