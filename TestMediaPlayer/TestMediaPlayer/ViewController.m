//
//  ViewController.m
//  TestMediaPlayer
//
//  Created by ysj on 15/12/25.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AVPlayerViewController.h"

#define NETURL @"http://mw5.dwstatic.com/2/4/1529/134981-99-1436844583.mp4"

@interface ViewController ()
@property (nonatomic, strong) MPMoviePlayerController *mediaPlayer;
@property (nonatomic, strong) AVPlayerViewController *avPlayerVC;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"AVPlayer" style:UIBarButtonItemStylePlain target:self action:@selector(avPlayer)];
    
    NSURL *localUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"movie.mp4" ofType:@""]];
    NSURL *netUrl = [NSURL URLWithString:[NETURL stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    MPMoviePlayerController *mediaPlayer = [[MPMoviePlayerController alloc]initWithContentURL:localUrl];
//    MPMoviePlayerController *mediaPlayer = [[MPMoviePlayerController alloc]initWithContentURL:netUrl];
    self.mediaPlayer = mediaPlayer;
    mediaPlayer.view.frame = CGRectMake(0, 100, 320, 240);
    [self.view addSubview:mediaPlayer.view];
    
    [self addNotification];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 400, 120, 40);
    [btn setTitle:@"播放/暂停" forState:UIControlStateNormal];
    [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [btn addTarget:self action:@selector(playedAndPused) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self avPlayer];
}

- (void)avPlayer{
    self.avPlayerVC = nil;
    self.avPlayerVC = [[AVPlayerViewController alloc]init];
    [self.navigationController pushViewController:self.avPlayerVC animated:YES];
}

- (void)playedAndPused{
    if (self.mediaPlayer.playbackState == MPMoviePlaybackStatePlaying) {
        [self.mediaPlayer pause];
    }else{
        [self.mediaPlayer play];
    }
}

- (void)addNotification{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.mediaPlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.mediaPlayer];
}

- (void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.mediaPlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",self.mediaPlayer.playbackState);
            break;
    }
}

- (void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",self.mediaPlayer.playbackState);
}

- (MPMoviePlayerController *)mediaPlayer{
    if (!_mediaPlayer) {
        
    }
    return _mediaPlayer;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
