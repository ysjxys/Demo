//
//  ViewController.m
//  TestScrollView
//
//  Created by ysj on 2016/12/22.
//  Copyright © 2016年 ysj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 300)];
//    mainScroll.delegate = self;
//    mainScroll.contentSize = CGSizeMake(960, 500);
    mainScroll.contentSize = CGSizeMake(320, 500);
    mainScroll.contentOffset = CGPointMake(0, 0);
    mainScroll.pagingEnabled = YES;
//    scroll.maximumZoomScale = 2.0;
//    scroll.minimumZoomScale = 0.5;
//    scroll.bounces = NO;
    mainScroll.backgroundColor = [UIColor purpleColor];
    mainScroll.clipsToBounds = NO;
    [self.view addSubview:mainScroll];
    
    
    UIScrollView *scroll1 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 500)];
    scroll1.delegate = self;
    scroll1.backgroundColor = [UIColor lightGrayColor];
    scroll1.contentOffset = CGPointMake(0, 0);
    scroll1.contentSize = CGSizeMake(320, 500);
    scroll1.maximumZoomScale = 2.0;
    scroll1.minimumZoomScale = 1.0;
    scroll1.clipsToBounds = NO;
    [mainScroll addSubview:scroll1];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 500)];
    imgView.image = [UIImage imageNamed:@"1"];
    [scroll1 addSubview:imgView];
    imgView.tag = 1;
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    UIImageView *imgView = [scrollView viewWithTag:1];
    return imgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
