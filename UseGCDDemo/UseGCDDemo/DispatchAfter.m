//
//  DispatchAfter.m
//  UseGCDDemo
//
//  Created by ysj on 16/5/31.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "DispatchAfter.h"

@implementation DispatchAfter

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)changeImgs{
    [super changeImgs];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, 3ull*NSEC_PER_SEC);
    
    for (int i = 0; i < self.urlArr.count; i++) {
        dispatch_after(delayTime, dispatch_get_global_queue(0, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:self.urlArr[i]];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImageView *imgView = self.imgViewArr[i];
                imgView.image = [UIImage imageWithData:data];
            });
        });
    }
}

@end
