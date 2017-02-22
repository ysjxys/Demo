//
//  CommonGCDUseViewController.m
//  UseGCDDemo
//
//  Created by ysj on 16/5/30.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "CommonGCDUseViewController.h"

@interface CommonGCDUseViewController()

@end
@implementation CommonGCDUseViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
}

- (void)changeImgs{
    [super changeImgs];
    
    //一条额外线程  全部数据加载完后方显示  不太好  舍弃
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        for (int i = 0; i < self.urlArr.count; i++) {
//            NSData *data = [NSData dataWithContentsOfURL:self.urlArr[i]];
//            [self.dataArr addObject:data];
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            for (int i = 0; i < self.imgViewArr.count; i++) {
//                UIImageView *imgView = self.imgViewArr[i];
//                imgView.image = [UIImage imageWithData:self.dataArr[i]];
//            }
//        });
//    });
    
    for (int i = 0; i < self.urlArr.count; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:self.urlArr[i]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                UIImageView *imgView = self.imgViewArr[i];
                imgView.image = [UIImage imageWithData:data];
            });
        });
    }
    
}

@end
