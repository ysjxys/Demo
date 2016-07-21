//
//  ViewController.m
//  SJScrollView
//
//  Created by ysj on 15/11/12.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "ViewController.h"
#import "YSJScrollView.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) YSJScrollView *scroll;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSArray *arr = @[@"0首页-3景点门票.jpg",@"0首页-2旅游攻略.jpg",@"0首页-1杭州风貌.jpg",@"0首页-4杭州住宿.jpg"];
    NSArray *arr = @[@"0首页-3景点门票.jpg"];
    
    YSJScrollView *sjs = [YSJScrollView scrollViewWithRect:CGRectMake(0, 0, 320, 400) imgsStrArr:arr];
    [self.view addSubview:sjs];
    sjs.delegate = self;
    self.scroll = sjs;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self.scroll scrollEnabled:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.scroll changePic];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
