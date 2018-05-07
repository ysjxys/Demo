//
//  ViewController.m
//  TestKVC
//
//  Created by ysj on 2018/3/2.
//  Copyright © 2018年 ysj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong)  UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btn.frame = CGRectMake(200, 160, 160, 80);
    self.btn.backgroundColor = [UIColor lightGrayColor];
    [self.btn setTitle:@"呵呵" forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    
    [self.btn addObserver:self forKeyPath:@"tintColor" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
}

- (void)btnClick:(UIButton *)btn {
    NSLog(@"heheehehe");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"tintColor"]) {
        NSLog(@"tintColor method caalled");
        NSLog(@"tintColor: %@", self.btn.tintColor);
    }
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc]init];
    }
    return _btn;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
