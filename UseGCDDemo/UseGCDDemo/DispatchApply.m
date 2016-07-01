//
//  DispatchApply.m
//  UseGCDDemo
//
//  Created by ysj on 16/5/31.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "DispatchApply.h"

@implementation DispatchApply

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)changeImgs{
    [super changeImgs];
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //第一个参数为重复次数
    //dispatch_sync 与 dispatch_group 的结合
//    dispatch_apply(self.urlArr.count, queue, ^(size_t index) {
//        NSData *data = [NSData dataWithContentsOfURL:self.urlArr[index]];
//        UIImageView *imgView = self.imgViewArr[index];
//        imgView.image = [UIImage imageWithData:data];
//        NSLog(@"%zu",index);
//    });
//    NSLog(@"over");
    
    //自带循环的东东
    dispatch_async(queue, ^{
        dispatch_apply(self.urlArr.count, queue, ^(size_t index) {
            NSLog(@"%zu",index);
            
            NSData *data = [NSData dataWithContentsOfURL:self.urlArr[index]];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImageView * imgView = self.imgViewArr[index];
                imgView.image = [UIImage imageWithData:data];
            });
        });
    });
}

@end
