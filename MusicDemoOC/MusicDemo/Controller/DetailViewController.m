//
//  DetailViewController.m
//  MusicDemo
//
//  Created by 沈凯 on 2017/11/8.
//  Copyright © 2017年 Ssky. All rights reserved.
//

#import "DetailViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "CALayer+RotationAnimation.h"
#import "NSString+ConversionTime.h"
#import "NSTimer+Operation.h"
#import "LrcView.h"

@interface DetailViewController ()<AVAudioPlayerDelegate, UIScrollViewDelegate>
//歌名
@property (weak, nonatomic) IBOutlet UILabel *MusicName;
//歌者
@property (weak, nonatomic) IBOutlet UILabel *singer;
//图片
@property (weak, nonatomic) IBOutlet UIImageView *img;
//进度
@property (weak, nonatomic) IBOutlet UISlider *progress;
//播放按钮
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
//当前时间
@property (weak, nonatomic) IBOutlet UILabel *currentTime;
//总体时间
@property (weak, nonatomic) IBOutlet UILabel *totalTIme;
//播放器
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
//进度的定时器
@property (strong, nonatomic) NSTimer *progressTimer;
//歌词
@property (weak, nonatomic) IBOutlet LrcLabel *lrcLabel;
//歌词视图
@property (weak, nonatomic) IBOutlet LrcView *lrcView;
//歌词定时器
@property (strong, nonatomic) CADisplayLink *lrcTimer;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UI设置
    [self setUI];
//    播放音乐
    [self playMusic];
//    设置进度定时器
    [self addProgressTimer];
//    设置歌词定时器
    [self addLrcTimer];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self stopTimer:2];
}
#pragma mark UI设置
- (void)setUI
{
    [self setUIMessageWithModel:self.model];
    
    self.img.layer.masksToBounds = YES;
    self.img.layer.cornerRadius = [UIScreen mainScreen].bounds.size.width * 0.8 / 2;
    
    self.lrcView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    self.lrcView.lrcLabel = self.lrcLabel;
    self.lrcView.delegate = self;
    self.lrcView.pagingEnabled = YES;
    
    [self.progress setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateNormal];
}
#pragma mark 设置相关信息
- (void)setUIMessageWithModel:(MusicModel *)model
{
    self.MusicName.text = model.name;
    self.singer.text = model.singer;
    
    [self.img setImage:[UIImage imageNamed:model.icon]];
    
    self.lrcView.lrcName = model.lrcname;
}
#pragma mark 播放音乐
- (void)playMusic
{
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[[NSBundle mainBundle]URLForResource:self.model.filename withExtension:nil] error:nil];
    self.audioPlayer.delegate = self;
    
    [self.audioPlayer prepareToPlay];
    
    if (!self.audioPlayer.isPlaying) {
        [self.audioPlayer play];
    }
//    获取音乐信息
    self.currentTime.text = [NSString stringWithTime:self.audioPlayer.currentTime];
    self.totalTIme.text = [NSString stringWithTime:self.audioPlayer.duration];
//    图片旋转动画
    [self.img.layer startAnimate];
    
    self.playBtn.selected = YES;
}
#pragma mark 按钮方法
- (IBAction)previousAndNextBtnAction:(UIButton *)sender {
    if (sender.tag == 11) {
        [self switchMusicWhetherNext:NO];
    }else
    {
        [self switchMusicWhetherNext:YES];
    }
}
- (IBAction)playBtnActiosn:(UIButton *)sender {
//    判断是否处于播放状态
    if (sender.isSelected) {
        [sender setSelected:NO];
        [self.img.layer pauseAnimate];
        [self.audioPlayer pause];
        [self.progressTimer pauseTimer];
    }else {
        [sender setSelected:YES];
        [self.img.layer resumeAnimate];
        [self.audioPlayer play];
        [self.progressTimer resumeTimer];
    }
}
#pragma mark 切换歌曲方法
- (void)switchMusicWhetherNext:(BOOL)flag
{
    if (flag) {
        if (self.currentIndex == self.data.count - 1) {
            self.currentIndex = 0;
        }else
        {
            self.currentIndex = self.currentIndex + 1;
        }
    }else
    {
        if (self.currentIndex == 0) {
            self.currentIndex = self.data.count - 1;
        }else
        {
            self.currentIndex = self.currentIndex - 1;
        }
    }
    self.model = self.data[self.currentIndex];
    
    if (self.audioPlayer) {
        [self.audioPlayer stop];
        self.audioPlayer = nil;
    }
    [self setUIMessageWithModel:self.model];
    
    [self playMusic];
    
}
#pragma mark 状态栏设成白色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark 设置进度定时器
- (void)addProgressTimer
{
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}
#pragma mark 更新时间进度
- (void)updateProgressInfo
{
    self.currentTime.text = [NSString stringWithTime:self.audioPlayer.currentTime];
    self.progress.value = self.audioPlayer.currentTime / self.audioPlayer.duration;
}
#pragma mark 设置歌词定时器
- (void)addLrcTimer
{
    self.lrcTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLrc)];
    [self.lrcTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
#pragma mark 更新歌词
- (void)updateLrc
{
    self.lrcView.currentTime = self.audioPlayer.currentTime;
}
#pragma mark 停止定时器
- (void)stopTimer:(int)flag
{
//flag: 0.停止进度定时器 1.停止歌词定时器 2.停止所有定时器
    switch (flag) {
        case 0:
            if (self.progressTimer) {
                [self.progressTimer invalidate];
                self.progressTimer = nil;
            }
            break;
        case 1:
            if (self.lrcTimer) {
                [self.lrcTimer invalidate];
                self.lrcTimer = nil;
            }
            break;
        case 2:
            if (self.progressTimer) {
                [self.progressTimer invalidate];
                self.progressTimer = nil;
            }
            if (self.lrcTimer) {
                [self.lrcTimer invalidate];
                self.lrcTimer = nil;
            }
            break;
        default:
            break;
    }
}
#pragma mark 滑动事件方法
- (IBAction)touchDown_StartChange:(UISlider *)sender {
    [self.progressTimer pauseTimer];
}
- (IBAction)touchDragInside_EndChange:(UISlider *)sender {
    self.audioPlayer.currentTime = sender.value * self.audioPlayer.duration;
    [self.progressTimer resumeTimer];
}
- (IBAction)valueChanged:(UISlider *)sender {
    NSTimeInterval currentTime = sender.value *self.audioPlayer.duration;
    self.currentTime.text = [NSString stringWithTime:currentTime];
}
- (IBAction)tapSlider:(UITapGestureRecognizer *)sender {
//    1.获取用户点击的点
    CGPoint point = [sender locationInView:sender.view];
//    2.点击的点在进度条中的比例
    CGFloat ratio = point.x / self.progress.bounds.size.width;
//    3.获取当前应播放的时间
    NSTimeInterval currentTime = self.audioPlayer.duration * ratio;
    self.audioPlayer.currentTime = currentTime;
//    4.更新进度信息
    [self updateProgressInfo];
}
#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag) {
        [self switchMusicWhetherNext:YES];
    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    取出scrollView偏移量
    CGPoint Offset = scrollView.contentOffset;
    CGFloat offsetRatio = Offset.x / scrollView.bounds.size.width;
    
//    设置iconView和歌词Label的透明度
    self.img.alpha = 1 - offsetRatio;
    self.lrcLabel.alpha = 1 - offsetRatio;
}
@end