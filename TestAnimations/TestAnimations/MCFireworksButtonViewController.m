//
//  MCFireworksButtonViewController.m
//  TestAnimations
//
//  Created by ysj on 16/7/20.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "MCFireworksButtonViewController.h"
#import "SWRevealViewController.h"
#import "MCFireworksButton.h"

@interface MCFireworksButtonViewController ()
@property (nonatomic, assign) BOOL isSelected;
@end

@implementation MCFireworksButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealVC = self.revealViewController;
    [self.view addGestureRecognizer:revealVC.panGestureRecognizer];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = 50;
    MCFireworksButton *btn = [[MCFireworksButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-width)/2, 200, width, width)];
//    btn.particleScale = 0.05;
//    btn.particleScaleRange = 0.02;
//    btn.particleImage = [UIImage imageNamed:@"Sparkle"];
//    [btn setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
    
    btn.particleScale = 0.2;//发散图像初始显示大小
    btn.particleScaleRange = 0.1;//发散图像发散过程中大小变化范围
    btn.particleImage = [UIImage imageNamed:@"Icon"];
    [btn setImage:[UIImage imageNamed:@"question"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:btn];
}

- (void)btnClicked:(UIButton *)btn{
    _isSelected = !_isSelected;
    MCFireworksButton *mcBtn = (MCFireworksButton *)btn;
    if (_isSelected) {
        [mcBtn popOutsideWithDuration:0.5];
        [mcBtn animate];
    }else{
        [mcBtn popInsideWithDuration:0.5];
        [mcBtn animate];
    }
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
