//
//  GCDDemo.m
//  UseGCDDemo
//
//  Created by ysj on 16/5/30.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "GCDDemo.h"

@implementation GCDDemo

+ (instancetype)gcdDemoWithDic:(NSDictionary *)dic{
    GCDDemo *demo = [[self alloc]init];
    demo.name = dic[@"name"];
    demo.destVcClass = dic[@"class"];
    return demo;
}

@end
