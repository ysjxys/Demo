//
//  AVPlayerViewController.m
//  TestMediaPlayer
//
//  Created by ysj on 15/12/29.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "AVPlayerViewController.h"
#import "YSJNavigationController.h"
#import "Reachability.h"
#import <AVFoundation/AVFoundation.h>    

#define NETURL @"http://mw5.dwstatic.com/2/4/1529/134981-99-1436844583.mp4"
#define NETURL2 @"http://v.jxvdy.com/sendfile/w5bgP3A8JgiQQo5l0hvoNGE2H16WbN09X-ONHPq3P3C1BISgf7C-qVs6_c8oaw3zKScO78I--b0BGFBRxlpw13sf2e54QA"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface AVPlayerViewController ()<UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIButton *playBtn;
@property (strong, nonatomic) IBOutlet UILabel *nowTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *allTimeLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *vTitleConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *hTitleConstraint;
@property (strong, nonatomic) IBOutlet UISlider *progressSlider;
@property (strong, nonatomic) IBOutlet UILabel *netStateLabel;
@property (strong, nonatomic) IBOutlet UIProgressView *bufferProgressView;
@property (strong, nonatomic) IBOutlet UIButton *chooseItemBtn;


@property (nonatomic, strong) AVPlayerItem *avPlayItem;
@property (nonatomic, strong) AVPlayer *avPlayer;
@property (nonatomic, strong) AVPlayerLayer *avPlayerLayer;
@property (nonatomic, assign) BOOL isControlBarHidden;
@property (nonatomic, assign) float itemTotalSeconds;
@property (nonatomic, strong) id playbackTimeObserver;
@property (nonatomic, strong) Reachability *reachability;
@property (nonatomic, assign) BOOL isHalfScreen;
@property (nonatomic, strong) UIView *chooseItemView;
@property (nonatomic, strong) NSArray *itemArray;
@end

@implementation AVPlayerViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self checkNet];
//    [self.avPlayer play];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    self.isHalfScreen = YES;
    
    [self addTarget];
    [self addGestureRecognizer];
    [self addNotifications];
    [self initAVPlayer];
    [self addObserver];
}

- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserver];
}

- (void)checkNet{
    self.reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([self.reachability currentReachabilityStatus]) {
        case NotReachable:
            self.netStateLabel.text = @"没网诶";
            break;
        case ReachableViaWiFi:
            self.netStateLabel.text = @"WIFI";
            break;
        case ReachableViaWWAN:
            self.netStateLabel.text = @"3G/4G";
            break;
        default:
            break;
    }
}


- (void)addObserver{
    [self.avPlayItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self.avPlayItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
//    [self.avPlayer addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    __weak typeof(self) weakSelf = self;
    self.playbackTimeObserver = [self.avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        NSLog(@"-----------");
        CMTime currentTime = weakSelf.avPlayer.currentItem.currentTime;
        float currentSecondTime = currentTime.value/currentTime.timescale;
        weakSelf.nowTimeLabel.text = [weakSelf translateSecondsToString:currentSecondTime];
        weakSelf.progressSlider.value = currentSecondTime/weakSelf.itemTotalSeconds;
    }];
}

- (void)removeObserver{
    [self.avPlayItem removeObserver:self forKeyPath:@"status" context:nil];
    [self.avPlayer removeTimeObserver:self.playbackTimeObserver];
//    [self.avPlayer removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.avPlayItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    AVPlayerItem *playerItem = object;
    if ([keyPath isEqualToString:@"status"]) {
        if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
            float totalSecond = playerItem.duration.value/playerItem.duration.timescale;
            self.allTimeLabel.text =[self translateSecondsToString:totalSecond];
            self.itemTotalSeconds = totalSecond;
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *loadedTimeRanges = [[self.avPlayer currentItem] loadedTimeRanges];
        CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval timeInterval = startSeconds + durationSeconds;// 计算缓冲总进度
        NSLog(@"start:%f,duration:%f",startSeconds,durationSeconds);
        NSLog(@"Time Interval:%f,total:%f",timeInterval,self.itemTotalSeconds);
        if (self.itemTotalSeconds != 0.0f) {
            [self.bufferProgressView setProgress:timeInterval/self.itemTotalSeconds animated:NO];
        }
    }
}

- (NSString *)translateSecondsToString:(float)second{
    int newSecond = second;
    NSMutableString *ms = [NSMutableString string];
    if (newSecond/3600 > 0) {
       [ms appendString:[NSString stringWithFormat:@"%d:",newSecond/3600]];
    }
    if (newSecond%3600/60 > 9) {
        [ms appendString:[NSString stringWithFormat:@"%d:",newSecond%3600/60]];
    }else{
        [ms appendString:[NSString stringWithFormat:@"0%d:",newSecond%3600/60]];
    }
    if (newSecond%60 > 9) {
        [ms appendString:[NSString stringWithFormat:@"%d",newSecond%60]];
    }else{
        [ms appendString:[NSString stringWithFormat:@"0%d",newSecond%60]];
    }
    return ms;
}

- (void)initAVPlayer{
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:NETURL]];
    AVPlayerItem *item2 = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:NETURL2]];
//    AVPlayerItem *item2 = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"movie.mp4" ofType:@""]]];
    self.itemArray = @[item,item2];
    
    self.avPlayItem = self.itemArray[0];
    
    AVPlayer *avPlayer = [AVPlayer playerWithPlayerItem:self.avPlayItem];
//    AVPlayer *avPlayer = [AVPlayer playerWithURL:[NSURL fileURLWithPath:@"file:///var/mobile/Media/DCIM/102APPLE/IMG_2358.MOV"]];
    
    
    self.avPlayer = avPlayer;
    
    CGFloat w = SCREEN_WIDTH;
    CGFloat h = SCREEN_WIDTH*(SCREEN_WIDTH/SCREEN_HEIGHT);
    CGFloat x = 0;
    CGFloat y = (SCREEN_HEIGHT - h)/2;
    
    AVPlayerLayer *avLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
    avLayer.frame = CGRectMake(x, y, w, h);
    self.avPlayerLayer = avLayer;
    
    [self.view.layer insertSublayer:avLayer atIndex:0];
}

- (void)addGestureRecognizer{
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showHideControlBar)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}

//是否触发手势代理方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view == self.progressSlider) {
        return NO;
    };
    return YES;
}

- (void)showHideControlBar{
    if (self.isControlBarHidden) {
        [UIView animateWithDuration:0.4 animations:^{
            self.topView.alpha = 1;
            self.bottomView.alpha = 1;
            self.playBtn.alpha = 1;
            self.chooseItemView.alpha = 1;
            self.isControlBarHidden = NO;
        }];
    }else{
        [UIView animateWithDuration:0.4 animations:^{
            self.topView.alpha = 0;
            self.bottomView.alpha = 0;
            self.playBtn.alpha = 0;
            self.chooseItemView.alpha = 0;
            self.isControlBarHidden = YES;
        }];
    }
}

- (void)addNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChanged) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)statusBarOrientationChanged{
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (interfaceOrientation == UIDeviceOrientationLandscapeRight || interfaceOrientation == UIDeviceOrientationLandscapeLeft) {
        self.vTitleConstraint.priority = UILayoutPriorityDefaultLow;
        self.hTitleConstraint.priority = UILayoutPriorityDefaultHigh;
        [self setPlayerLayoutHorizontal];
    }else if (interfaceOrientation == UIInterfaceOrientationPortrait){
        self.hTitleConstraint.priority = UILayoutPriorityDefaultLow;
        self.vTitleConstraint.priority = UILayoutPriorityDefaultHigh;
        [self setPlayerLayoutVerictal];
    }
}

- (void)setPlayerLayoutHorizontal{
    CGFloat badge = 0.0f;
    CGFloat w = SCREEN_WIDTH - badge*2;
    CGFloat h = SCREEN_HEIGHT*(w/SCREEN_WIDTH);
    CGFloat x = badge;
    CGFloat y = (SCREEN_HEIGHT - h)/2;
    self.avPlayerLayer.frame = CGRectMake(x, y, w, h);
}

- (void)setPlayerLayoutVerictal{
    CGFloat w = SCREEN_WIDTH;
    CGFloat h = SCREEN_WIDTH*(w/SCREEN_HEIGHT);
    CGFloat x = 0;
    CGFloat y = (SCREEN_HEIGHT - h)/2;
    self.avPlayerLayer.frame = CGRectMake(x, y, w, h);
}

- (void)addTarget{
    self.progressSlider.value = 0;
    [self.progressSlider addTarget:self action:@selector(sliderValueChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)sliderValueChanged{
    float purposeTime = self.progressSlider.value * self.itemTotalSeconds;
    self.nowTimeLabel.text = [self translateSecondsToString:purposeTime];
    CMTime cmTime = CMTimeMake(purposeTime, 1);
    [self.avPlayer seekToTime:cmTime completionHandler:^(BOOL finished) {
        if (self.avPlayer.rate > 0 && !self.avPlayer.error) {
            // avPlayer is playing
            [self.avPlayer play];
        }
    }];
}


- (IBAction)playBtnClicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (self.avPlayer.rate > 0 && !self.avPlayer.error) {
        // avPlayer is playing
        btn.selected = NO;
        [self.avPlayer pause];
    }else{
        btn.selected = YES;
        [self.avPlayer play];
    }
}

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)fullScreenBtnClicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (self.isHalfScreen) {
        self.isHalfScreen = NO;
        //这句话是防止手动先把设备置为横屏,导致下面的语句失效.
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
        
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
    }else{
        self.isHalfScreen = YES;
        //这句话是防止手动先把设备置为竖屏,导致下面的语句失效.
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
        
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
    }
}

- (IBAction)chooseItemBtnClicked:(id)sender {
    self.chooseItemView.hidden = !self.chooseItemView.isHidden;
}


- (IBAction)lockBtnClicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
}

- (UIView *)chooseItemView{
    if (!_chooseItemView) {
        _chooseItemView = [[UIView alloc]init];
        _chooseItemView.backgroundColor = [UIColor darkGrayColor];
        NSInteger numPerLine = 4;
        NSInteger count = self.itemArray.count;
        CGFloat x;
        CGFloat y;
        if (count/4 < 1) {
            x = self.chooseItemBtn.frame.origin.x + self.chooseItemBtn.frame.size.width - 35*count;
            y = self.bottomView.frame.origin.y - 25;
            _chooseItemView.frame = CGRectMake(x, y, 35*count, 25);
        }else{
            x = self.chooseItemBtn.frame.origin.x + self.chooseItemBtn.frame.size.width - 35*numPerLine;
            y = self.bottomView.frame.origin.y - 25*(count/4+1);
           _chooseItemView.frame = CGRectMake(x, y, 35*numPerLine, 25*(count/4+1));
        }
        for (int i = 0; i < count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i;
            [btn setBackgroundColor:[UIColor darkGrayColor]];
            [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.frame = CGRectMake(2+i%numPerLine*35, 2+i/numPerLine*25, 33, 22);
            [btn addTarget:self action:@selector(changeItem:) forControlEvents:UIControlEventTouchUpInside];
            [_chooseItemView addSubview:btn];
        }
        _chooseItemView.hidden = YES;
        [self.view addSubview:_chooseItemView];
    }
    return _chooseItemView;
}

- (void)changeItem:(id)sender{
    UIButton *btn = sender;
//    [self.avPlayer pause];
    [self removeObserver];
    self.avPlayItem = self.itemArray[btn.tag];
    [self.avPlayer replaceCurrentItemWithPlayerItem:self.avPlayItem];
    [self addObserver];
    [self.avPlayer seekToTime:CMTimeMake(1, 1)];
//    [self.avPlayer play];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserver];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
