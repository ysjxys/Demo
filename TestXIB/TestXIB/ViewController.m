//
//  ViewController.m
//  TestXIB
//
//  Created by ysj on 15/11/11.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr = [[NSBundle mainBundle]loadNibNamed:@"ViewCtl" owner:self options:nil];
    UIView *view = [arr lastObject];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
