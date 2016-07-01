//
//  ViewController.m
//  TestBackgroundRunning
//
//  Created by ysj on 16/5/12.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"我就是试试到底能能改变不同的字体颜色没有别的意思啊"];
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(0, 100, 320, 300)];
    tf.backgroundColor = [UIColor lightGrayColor];
    
    self.textField = tf;
    [self.view addSubview:tf];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 7)];
    
    tf.text = [NSString stringWithFormat:@"%@",str];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
