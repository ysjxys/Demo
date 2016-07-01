//
//  DispatchSemaphore.m
//  UseGCDDemo
//
//  Created by ysj on 16/6/1.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "DispatchSemaphore.h"

@implementation DispatchSemaphore

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)changeImgs{
    [super changeImgs];
    
    //容易因内存错误异常结束   手机中尤甚
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    NSMutableArray *array = [NSMutableArray array];
//    for (int i = 0; i < 100000; i++) {
//        dispatch_async(queue, ^{
//            [array addObject:[NSNumber numberWithInt:i]];
//            NSLog(@"%d",i);
//        });
//    }
    
    NSMutableArray *array = [NSMutableArray array];
    dispatch_queue_t quere = dispatch_get_global_queue(0, 0);
    //设置同时访问线程只能为1条
    //原理：持有计数器，计数为0时等待，计数为1或大于1时，减去1并不再等待
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    for (int i = 0; i < 100000; i++) {
        dispatch_async(quere, ^{
            //持续等待 semaphore 计数大于等于1的情况出现
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            [array addObject:[NSNumber numberWithInt:1]];
            NSLog(@"%d",i);
            //将 semaphore 计数+1，进入下一个处理
            dispatch_semaphore_signal(semaphore);
        });
    }
}

@end
