//
//  ViewController.m
//  YSJAVAudioPlayer
//
//  Created by ysj on 15/11/27.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AFSoundManager.h"

@interface ViewController ()<AVAudioPlayerDelegate>
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) UIProgressView *progress;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UISlider *slider;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //开始
    UIButton *btnPlay = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnPlay setTitle:@"播放" forState:UIControlStateNormal];
    btnPlay.frame = CGRectMake(0, 0, 100, 50);
    btnPlay.center = self.view.center;
    [self.view addSubview:btnPlay];
    [btnPlay addTarget:self action:@selector(played) forControlEvents:UIControlEventTouchUpInside];
    
    //暂停
    UIButton *btnPause = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnPause setTitle:@"暂停" forState:UIControlStateNormal];
    btnPause.frame = CGRectMake(btnPlay.frame.origin.x, btnPlay.frame.origin.y-120, 100, 50);
    [self.view addSubview:btnPause];
    [btnPause addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    
    //停止
    UIButton *btnStop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnStop setTitle:@"停止" forState:UIControlStateNormal];
    btnStop.frame = CGRectMake(btnPlay.frame.origin.x, btnPlay.frame.origin.y-60, 100, 50);
    [self.view addSubview:btnStop];
    [btnStop addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    
    //后台播放
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
//    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    //播放进度条
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];
    
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(40, btnPause.frame.origin.y - 60, 240, 30)];
    [slider addTarget:self action:@selector(changeSlider) forControlEvents:UIControlEventValueChanged];
    [slider addTarget:self action:@selector(DragExit) forControlEvents:UIControlEventAllEvents];
    
    self.slider = slider;
    [self.view addSubview:slider];
}


- (void)remoteControlReceivedWithEvent:(UIEvent *)receivedEvent {
    
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        
        switch (receivedEvent.subtype) {
                
            case UIEventSubtypeRemoteControlTogglePlayPause:
//                [[PlayController sharedInstance] pause];
                NSLog(@"RemoteControlEvents: pause");
                break;
            case UIEventSubtypeRemoteControlNextTrack:
//                [[PlayController sharedInstance] playModeNext];
                NSLog(@"RemoteControlEvents: playModeNext");
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
//                [[PlayController sharedInstance] playPrev];
                NSLog(@"RemoteControlEvents: playPrev");
                break;
            case UIEventSubtypeRemoteControlPause:
                NSLog(@"UIEventSubtypeRemoteControlPause: pause");
                break;
            default:
                break;
        }
    }
}

- (void)updateSlider{
//    self.slider.value = self.player.currentTime/self.player.duration*self.slider.maximumValue;
    
}

- (void)DragExit{
    NSLog(@"xx");
}

- (void)changeSlider{
//    [self.timer invalidate];
//    [self.player pause];
//    self.player.currentTime = self.slider.value/self.slider.maximumValue*self.player.duration;
    NSLog(@"s");
}

- (void)played{
    [self.player play];
//    [self.timer fire];
    [self configPlayingInfo];
}
//此方法在播放歌曲与切换歌曲时调用即可
- (void)configPlayingInfo{
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"歌曲名字" forKey:MPMediaItemPropertyTitle];//歌曲名设置
        [dict setObject:@"歌手姓名" forKey:MPMediaItemPropertyArtist];//歌手名设置
        [dict setObject:[[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:@"placeholder image"]]  forKey:MPMediaItemPropertyArtwork];//专辑图片设置
        [dict setObject:[NSNumber numberWithDouble:self.player.currentTime] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime]; //音乐当前已经播放时间
        [dict setObject:[NSNumber numberWithFloat:1.0] forKey:MPNowPlayingInfoPropertyPlaybackRate];//进度光标的速度 （这个随 自己的播放速率调整，我默认是原速播放）
        [dict setObject:[NSNumber numberWithDouble:self.player.duration] forKey:MPMediaItemPropertyPlaybackDuration];//歌曲总时间设置
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
    }
}

- (void)pause{
    [self.player pause];
}

- (void)stop{
    [self.player stop];
    self.player = nil;
}

- (AVAudioPlayer *)player{
    if (!_player) {
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"那些花儿" ofType:@"mp3"]];
        AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        player.delegate = self;
        player.volume = 0.5;
        _player = player;
    }
    return _player;
}


#pragma mark - delegate

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    [player stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
