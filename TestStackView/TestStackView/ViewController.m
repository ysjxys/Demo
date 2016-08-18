//
//  ViewController.m
//  TestStackView
//
//  Created by ysj on 16/8/17.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "ViewController.h"
#import "CustomerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"other" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarBtnClicked)];
}

- (void)rightBarBtnClicked{
    CustomerViewController *customer = [[CustomerViewController alloc]init];
    [self.navigationController pushViewController:customer animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
