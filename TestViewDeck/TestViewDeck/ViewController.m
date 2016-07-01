//
//  ViewController.m
//  TestViewDeck
//
//  Created by ysj on 16/6/7.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "ViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "ViewDeck.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"xx" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemSelected)];
}

- (void)leftBarItemSelected{
    IIViewDeckController *result = (IIViewDeckController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [result toggleLeftViewAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
