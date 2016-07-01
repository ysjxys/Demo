//
//  ViewController.m
//  testPods
//
//  Created by ysj on 15/11/17.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit.h>

@interface ViewController ()<MAMapViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MAMapView *map = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    map.delegate = self;
    [self.view addSubview:map];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
