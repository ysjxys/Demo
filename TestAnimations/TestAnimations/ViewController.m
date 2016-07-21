//
//  ViewController.m
//  TestAnimations
//
//  Created by ysj on 16/7/19.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealVC = self.revealViewController;
    [self.view addGestureRecognizer:revealVC.panGestureRecognizer];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"slipe to find more";
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
