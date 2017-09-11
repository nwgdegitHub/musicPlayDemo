//
//  PlayingViewController.m
//  仿黑马音乐播放器
//
//  Created by 刘伟 on 2017/9/11.
//  Copyright © 2017年 刘伟. All rights reserved.
//

#import "PlayingViewController.h"
#import "UIView+Extension.h"
#import "MusicModel.h"
#import "MusicsTool.h"
#import <AVFoundation/AVFoundation.h>
#import "AudioTool.h"

@interface PlayingViewController ()
/**
 *  当前播放器
 */
@property (nonatomic, strong) AVAudioPlayer *player;

/**
 *  当前正在播放的音乐
 */
@property(nonatomic,strong)MusicModel *playingMusic;

/**
 *  歌曲大图
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/**
 *  歌曲名称
 */
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
/**
 *  歌手名称
 */
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;

/**
 *  时长
 */
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

/**
 *  播放按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *playBtn;


@end

@implementation PlayingViewController

//显示播放页
-(void)show{
    
    //先设置播放数据源
    [self resetPlayingMusic];
    
    // 1. 拿到Window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    // 2. 设置当前控制器的frame
    self.view.frame = window.bounds;
    // 3. 将当前控制器的view添加到Window上
    [window addSubview:self.view];
    self.view.hidden = NO;
    
    // 禁用交互功能
    window.userInteractionEnabled = NO;
    
    // 4.执行动画, 让控制器的view从下面转出来
    self.view.y = window.bounds.size.height;
    [UIView animateWithDuration:0.5 animations:^{
        // 执行动画
        self.view.y = 0;
    } completion:^(BOOL finished) {
        // 开启交互
        window.userInteractionEnabled = YES;
        
        //设置播放按钮图片
        NSLog(@"播放和暂停%d",self.playBtn.selected);
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        
    }];


}

//退出播放页
- (IBAction)exitPlayingVC:(UIButton *)sender {
    // 1. 拿到Window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // 禁用交互功能
    window.userInteractionEnabled = NO;
    
    // 2.执行退出动画
    [UIView animateWithDuration:0.5 animations:^{
        self.view.y = window.bounds.size.height;
        
    } completion:^(BOOL finished) {
        
        // 隐藏控制器的view
        self.view.hidden = YES;
        
        // 开启交互
        window.userInteractionEnabled = YES;
    }];
}

//开始播放
-(void)startPlayingMusic{

    //播放音乐肯定要文件名 而文件名在音乐模型中
    MusicModel *music = [MusicsTool playingMusic];
    self.player = [AudioTool playMusicWithFilename:music.filename];
    // 3.设置其他属性
    // 设置歌手
    self.singerLabel.text = music.singer;
    // 歌曲名称
    self.songLabel.text = music.name;
    // 背景大图
    self.iconView.image = [UIImage imageNamed:music.icon];
    // 设置总时长
    self.durationLabel.text = [self strWithTimeInterval:self.player.duration];
    
    //设置一个通知看当前播放时间
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(playerCurrentTime) userInfo:nil repeats:YES];
 
}

//暂停播放
-(void)pausedPlayingMusic{
    [self.player pause];
}

//重置播放数据源
-(void)resetPlayingMusic{
    // 停止当前正在播放的歌曲
    [AudioTool stopMusicWithFilename:self.playingMusic.filename];
}

// 将秒转换为指定格式的字符串
- (NSString *)strWithTimeInterval:(NSTimeInterval)interval
{
    int m = interval / 60;
    int s = (int)interval % 60;
    return [NSString stringWithFormat:@"%02d: %02d", m , s];
}

//播放和暂停音乐
- (IBAction)playAndPaused:(UIButton *)sender {
    
    //NSLog(@"播放和暂停%d",sender.selected);//0
    self.playBtn.selected = !sender.selected;
    
    if (self.playBtn.selected) {
        
        NSLog(@"播放状态");
        //播放按钮变换
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        // 开始播放
        [self startPlayingMusic];
    }
    else {
        NSLog(@"暂停状态");
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        // 暂停播放
        [self pausedPlayingMusic];
    
    }
}

//下一首
- (IBAction)nextMusic:(UIButton *)sender {
    //暂停当前音乐 (直接停止的下次回来会继续上次的时间 所以不能这样)
    //[self pausedPlayingMusic];
    //停止播放（播放时间置零这样才对）
    [AudioTool stopMusicWithFilename:[MusicsTool playingMusic].filename];
    
    //由音乐管理工具类返回下一首音乐
    MusicModel *nextMusic = [MusicsTool nextMusic];
    
    //把获得的下一首设置为当前音乐
    [MusicsTool setPlayingMusic:nextMusic];
    
    //播放音乐
    [self startPlayingMusic];
    
}

//上一首
- (IBAction)lastMusic:(UIButton *)sender {
    //暂停当前音乐
    //[self pausedPlayingMusic];
    //停止当前音乐
    [AudioTool stopMusicWithFilename:[MusicsTool playingMusic].filename];
    
    //由音乐管理工具类返回下一首音乐
    MusicModel *previouesMusic = [MusicsTool previouesMusic];
    
    //把获得的下一首设置为当前音乐
    [MusicsTool setPlayingMusic:previouesMusic];
    
    //播放音乐
    [self startPlayingMusic];
    
}


//待完善 进度条 拖动快进和后退...
-(void)playerCurrentTime{
    NSLog(@"当前播放时间%f",self.player.currentTime);
    if (self.player.playing) {
        return;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
