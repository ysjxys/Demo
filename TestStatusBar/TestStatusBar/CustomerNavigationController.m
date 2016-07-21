//
//  CustomerNavigationController.m
//  TestStatusBar
//
//  Created by ysj on 16/7/21.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "CustomerNavigationController.h"

@interface CustomerNavigationController ()

@end

@implementation CustomerNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    _statusBarStyle = UIStatusBarStyleLightContent;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return _statusBarStyle;
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
