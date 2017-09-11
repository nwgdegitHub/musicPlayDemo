//
//  ViewController.m
//  仿黑马音乐播放器
//
//  Created by 刘伟 on 2017/9/11.
//  Copyright © 2017年 刘伟. All rights reserved.
//

#import "ViewController.h"
#import "MusicModel.h"
#import "MusicsTool.h"
#import "UIImage+NJ.h"
#import "PlayingViewController.h"

@interface ViewController ()

/**
 * 播放界面
 */
@property(nonatomic,strong)PlayingViewController *playingVC;

@end

@implementation ViewController

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"music";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    MusicModel *music = [MusicsTool musics][indexPath.row];
    cell.imageView.image = [UIImage circleImageWithName:music.singerIcon borderWidth:5 borderColor:[UIColor blueColor]];
    cell.textLabel.text = music.name;
    cell.detailTextLabel.text = music.singer;
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"你选择了第%ld个",(long)indexPath.row);
    
    //设置当前播放的音乐是第几首
    MusicModel *music = [MusicsTool musics][indexPath.row];
    [MusicsTool setPlayingMusic:music];
    [self.playingVC show];
}

#pragma mark - 懒加载
-(PlayingViewController *)playingVC{
    if (!_playingVC) {
        _playingVC = [[PlayingViewController alloc]init];
    }
    return _playingVC;
}
@end


















