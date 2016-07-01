//
//  ViewController.m
//  TestAutoLayout
//
//  Created by ysj on 15/12/29.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "ViewController.h"
#import "CodeMakeConstraintViewController.h"
#import "VFLViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithTitle:@"code" style:UIBarButtonItemStylePlain target:self action:@selector(code)],[[UIBarButtonItem alloc]initWithTitle:@"VFL" style:UIBarButtonItemStylePlain target:self action:@selector(VFL)]];
}

- (void)code{
    CodeMakeConstraintViewController *cmcVC = [[CodeMakeConstraintViewController alloc]init];
    [self.navigationController pushViewController:cmcVC animated:YES];
}

- (void)VFL{
    VFLViewController *vflVC = [[VFLViewController alloc]init];
    [self.navigationController pushViewController:vflVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
