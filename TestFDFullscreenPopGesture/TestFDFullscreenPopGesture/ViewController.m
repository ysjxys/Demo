//
//  ViewController.m
//  TestFDFullscreenPopGesture
//
//  Created by ysj on 16/10/28.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "ViewController.h"
#import "PushViewController.h"
#import "Push2ViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "PresentViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *disableNavPushBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"present" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarBtnClick)];
    self.navigationController.fd_prefersNavigationBarHidden = YES;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [btn setTintColor:self.view.tintColor];
    [btn setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    btn.frame = CGRectMake(130, 200, self.view.frame.size.width-130*2, 40);
    [btn addTarget:self action:@selector(pushBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"push2" forState:UIControlStateNormal];
    [btn2 setTintColor:self.view.tintColor];
    [btn2 setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    btn2.frame = CGRectMake(130, 250, self.view.frame.size.width-130*2, 40);
    [btn2 addTarget:self action:@selector(push2BtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    
    UIButton *disableNavPushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [disableNavPushBtn setTitle:@"NavPush is Enable" forState:UIControlStateNormal];
    [disableNavPushBtn setTitle:@"NavPush is UnEnable" forState:UIControlStateSelected];
    [disableNavPushBtn setTintColor:self.view.tintColor];
    [disableNavPushBtn setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [disableNavPushBtn setTitleColor:self.view.tintColor forState:UIControlStateSelected];
    disableNavPushBtn.frame = CGRectMake(50, 350, self.view.frame.size.width-50*2, 40);
    [disableNavPushBtn addTarget:self action:@selector(disableNavPushBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:disableNavPushBtn];
    _disableNavPushBtn = disableNavPushBtn;
    
    [self disableNavPushBtnClicked];
}
    
- (void)rightBarBtnClick{
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[PresentViewController alloc] init]];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)disableNavPushBtnClicked{
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = !self.navigationController.fd_fullscreenPopGestureRecognizer.enabled;
    if (self.navigationController.fd_fullscreenPopGestureRecognizer.enabled) {
        _disableNavPushBtn.selected = NO;
    }else{
        _disableNavPushBtn.selected = YES;
    }
}

- (void)pushBtnClicked{
    [self.navigationController pushViewController:[[PushViewController alloc]init] animated:YES];
}

- (void)push2BtnClicked{
    [self.navigationController pushViewController:[[Push2ViewController alloc]init] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
