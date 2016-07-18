//
//  BasicViewController.m
//  TestSWReveal
//
//  Created by ysj on 16/7/15.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "BasicViewController.h"
#import "SWRevealViewController.h"

@interface BasicViewController ()

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    SWRevealViewController *revealVC = self.revealViewController;
    [self.view addGestureRecognizer:revealVC.panGestureRecognizer];
    
    CGFloat edge = 40.0f;
    CGFloat width = self.view.frame.size.width - edge*2;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(edge, 200, width, width)];
    label.font = [UIFont systemFontOfSize:40];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    self.label = label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
