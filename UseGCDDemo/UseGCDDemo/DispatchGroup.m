//
//  DispatchGroup.m
//  UseGCDDemo
//
//  Created by ysj on 16/5/31.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "DispatchGroup.h"

@implementation DispatchGroup

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)changeImgs{
    [super changeImgs];
    
    dispatch_queue_t quere = dispatch_get_global_queue(0, 0);
    dispatch_group_t group = dispatch_group_create();
    self.dataArr = [self.urlArr mutableCopy];
    
    for (int i = 0; i < self.urlArr.count; i++) {
        dispatch_group_async(group, quere, ^{
            NSData *data = [NSData dataWithContentsOfURL:self.urlArr[i]];
            [self.dataArr replaceObjectAtIndex:i withObject:data];
            NSLog(@"%d",i);
        });
    }
    
    //从现在起等待ns dispatch_group_wait会挂起当前线程。。。不能点其他的操作了呦
//    long result = dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, 10ull*NSEC_PER_SEC));
    //DISPATCH_TIME_FOREVER  一直等待
    long result = dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    //返回值为long类型，0为全部执行完毕，1为仍有未执行完毕的内容，可根据返回值分别进入分支
    if (result == 0) {
        NSLog(@"全部执行完毕");
    }else{
        NSLog(@"未全部执行完毕");
    }
    
    //dispatch_group_async全部执行完毕后，执行dispatch_group_notify
    dispatch_group_notify(group, quere, ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            for (int i = 0; i < self.dataArr.count; i++) {
                NSData *data = self.dataArr[i];
                UIImageView *imgView = self.imgViewArr[i];
                imgView.image = [UIImage imageWithData:data];
            }
            NSLog(@"notify");
        });
    });
}

@end
