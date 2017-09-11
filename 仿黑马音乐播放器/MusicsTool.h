//
//  MusicsTool.h
//  仿黑马音乐播放器
//
//  Created by 刘伟 on 2017/9/11.
//  Copyright © 2017年 刘伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicModel.h"

@interface MusicsTool : NSObject

//获取所有音乐
+(NSArray *)musics;

// 返回当前正在播放的音乐
+ (MusicModel *)playingMusic;

// 设置当前正在播放的音乐
+ (void)setPlayingMusic:(MusicModel *)music;

// 获取下一首
+ (MusicModel *)nextMusic;

// 获取上一首
+ (MusicModel *)previouesMusic;

@end
