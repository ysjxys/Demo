//
//  CreateDispatchQueue.m
//  UseGCDDemo
//
//  Created by ysj on 16/5/31.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "CreateDispatchQueue.h"

@implementation CreateDispatchQueue

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)changeImgs{
    [super changeImgs];
    
    dispatch_queue_t customerDispatchQuere = dispatch_queue_create("com.yushengjie.CustomerQueue", DISPATCH_QUEUE_CONCURRENT);
    
    //设定优先级  将第一个参数的优先级设置与第二个参数优先级相同
    dispatch_set_target_queue(customerDispatchQuere, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0));
    
    
    for (int i = 0; i < self.urlArr.count; i++) {
        dispatch_async(customerDispatchQuere, ^{
            NSData *data = [NSData dataWithContentsOfURL:self.urlArr[i]];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImageView *imgView = self.imgViewArr[i];
                imgView.image = [UIImage imageWithData:data];
            });
        });
    }
}


@end
