//
//  ViewController.m
//  TestBlock
//
//  Created by ysj on 2018/3/9.
//  Copyright © 2018年 ysj. All rights reserved.
//

#import "ViewController.h"

typedef void (^testBlock)(int num, NSString *name);


@interface ViewController ()

@property (nonatomic, copy) testBlock myBlock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self testBlock1];
    [self testBlock2];
}

- (void)testBlock2 {
    
//    int num = 5;
//    NSString *name = @"啊哈哈";
    
    __block int num = 5;
    __block NSString *name = @"啊哈哈";
    
    testBlock theBlock = ^(int n, NSString *m) {
        name = [NSString stringWithFormat:@"111 %@", m];
        num++;
        NSLog(@"num: %d, name: %@", num, name);
    };
    
    theBlock(num, name);
    NSLog(@"new name:%@, new num:%d", name, num);
}

- (void)testBlock1 {
    testBlock theBlock = ^(int num, NSString *name) {
        NSLog(@"num: %d, name: %@", num, name);
    };
    
    int num = 5;
    NSString *name = @"啊哈哈";
    
    theBlock(num, name);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
