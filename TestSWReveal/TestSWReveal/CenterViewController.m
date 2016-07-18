//
//  CenterViewController.m
//  TestSWReveal
//
//  Created by ysj on 16/7/15.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "CenterViewController.h"
#import "SWRevealViewController.h"

@interface CenterViewController ()

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    SWRevealViewController *revealVC = self.tabBarController.revealViewController;
//    SWRevealViewController *revealVC = self.navigationController.revealViewController;
    [self.view addGestureRecognizer:revealVC.panGestureRecognizer];
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
