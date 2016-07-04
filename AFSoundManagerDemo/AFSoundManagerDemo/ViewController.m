//
//  ViewController.m
//  AFSoundManagerDemo
//
//  Created by ysj on 15/11/30.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "ViewController.h"
#import "AFSoundManager.h"

typedef NS_ENUM(NSInteger,OrderType){
    OrderListCircle = 0,
    OrderListOnce,
    OrderRandom,
};


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;
@property (nonatomic, strong) AFSoundQueue *queue;
@property (nonatomic) OrderType orderType;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AFSoundItem *item1 = [[AFSoundItem alloc]initWithLocalResource:@"那些花儿.mp3" atPath:nil];
    AFSoundItem *item2 = [[AFSoundItem alloc]initWithLocalResource:@"朴树 - 平凡之路.mp3" atPath:nil];
    AFSoundItem *item3 = [[AFSoundItem alloc]initWithLocalResource:@"许巍 - 曾经的你.mp3" atPath:nil];
    AFSoundItem *item4 = [[AFSoundItem alloc]initWithLocalResource:@"许巍 - 蓝莲花.mp3" atPath:nil];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:item1,item2,item3,item4, nil];
    self.queue = [[AFSoundQueue alloc]initWithItems:array];
    
    self.orderType = OrderListOnce;
    [self.orderBtn setTitle:@"列表播放" forState:UIControlStateNormal];
    self.slider.value = 0;

    [self.queue listenFeedbackUpdatesWithBlock:^(AFSoundItem *item) {
        self.timeLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld/%.2ld:%.2ld",item.timePlayed/60,item.timePlayed%60,item.duration/60,item.duration%60];
        self.slider.value = (float)item.timePlayed/(float)item.duration*self.slider.maximumValue;
        } andFinishedBlock:^(AFSoundItem *nextItem) {
            
    }];
    [self.queue pause];
    self.queue.status = AFSoundStatusPaused;
}

- (IBAction)playPrevious:(id)sender {
    switch (self.orderType) {
        case OrderListCircle:
            if ([self.queue indexOfCurrentItem] == 0) {
                NSLog(@"%ld",(long)[self.queue countOfItems]);
                [self.queue playItemAtIndex:[self.queue countOfItems]-1];
            }else{
                [self.queue playPreviousItem];
            }
            break;
        case OrderListOnce:
            [self.queue playPreviousItem];
            break;
        case OrderRandom:
            [self.queue playItemAtIndex:arc4random()%100%[self.queue countOfItems]];
            break;
        default:
            break;
    }
}

- (IBAction)play:(id)sender {
    if (self.queue.status == AFSoundStatusPlaying) {
        [self.queue pause];
        self.queue.status = AFSoundStatusPaused;
    }else{
        [self.queue playCurrentItem];
        self.queue.status = AFSoundStatusPlaying;
    }
    
}

- (IBAction)playNext:(id)sender {
    switch (self.orderType) {
        case OrderListCircle:
            if ([self.queue indexOfCurrentItem] == [self.queue countOfItems]-1) {
                [self.queue playItemAtIndex:0];
            }else{
                [self.queue playNextItem];
            }
            break;
        case OrderListOnce:
            [self.queue playNextItem];
            break;
        case OrderRandom:
            [self.queue playItemAtIndex:arc4random()%100%[self.queue countOfItems]];
            break;
        default:
            break;
    }
    
}

- (IBAction)circleMode:(id)sender {
    switch (self.orderType) {
        case OrderListOnce:
            self.orderType = OrderListCircle;
            [self.orderBtn setTitle:@"列表循环" forState:UIControlStateNormal];
            break;
        case OrderListCircle:
            self.orderType = OrderRandom;
            [self.orderBtn setTitle:@"随机播放" forState:UIControlStateNormal];
            break;
        case OrderRandom:
            self.orderType = OrderListOnce;
            [self.orderBtn setTitle:@"列表播放" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
