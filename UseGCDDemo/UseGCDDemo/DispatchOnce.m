//
//  DispatchOnce.m
//  UseGCDDemo
//
//  Created by ysj on 16/6/1.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "DispatchOnce.h"
@interface DispatchOnce()
@property (nonatomic, assign) int num;
@end
@implementation DispatchOnce

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)changeImgs{
    [super changeImgs];
    
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        NSLog(@"%d",self.num);
        NSData *data = [NSData dataWithContentsOfURL:self.urlArr[self.num]];
        UIImageView *imgView = self.imgViewArr[self.num];
        imgView.image = [UIImage imageWithData:data];
        self.num ++;
    });
}

@end
