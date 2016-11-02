//
//  PushViewController.m
//  TestFDFullscreenPopGesture
//
//  Created by ysj on 16/10/31.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "PushViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface PushViewController ()
@property (nonatomic, strong) UIButton *disableVCPushBtn;
@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIButton *disableVCPushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [disableVCPushBtn setTitle:@"VCPush is Enable" forState:UIControlStateNormal];
    [disableVCPushBtn setTitle:@"VCPush is UnEnable" forState:UIControlStateSelected];
    [disableVCPushBtn setTintColor:self.view.tintColor];
    [disableVCPushBtn setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [disableVCPushBtn setTitleColor:self.view.tintColor forState:UIControlStateSelected];
    disableVCPushBtn.frame = CGRectMake(50, 300, self.view.frame.size.width-50*2, 40);
    [disableVCPushBtn addTarget:self action:@selector(disableVCPushBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:disableVCPushBtn];
    _disableVCPushBtn = disableVCPushBtn;
    
    [self disableVCPushBtnClicked];
}

- (void)disableVCPushBtnClicked{
    self.fd_interactivePopDisabled = !self.fd_interactivePopDisabled;
    if (self.fd_interactivePopDisabled) {
        _disableVCPushBtn.selected = YES;
    }else{
        _disableVCPushBtn.selected = NO;
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
