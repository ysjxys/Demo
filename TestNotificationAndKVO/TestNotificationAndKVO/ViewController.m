//
//  ViewController.m
//  TestNotificationAndKVO
//
//  Created by ysj on 16/8/9.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+XWAdd.h"

@interface ViewController ()
@property (nonatomic, strong) UIScrollView *scroll;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 200, 200, 200)];
    scroll.backgroundColor = [UIColor lightGrayColor];
    scroll.contentSize = CGSizeMake(200, 400);
    [self.view addSubview:scroll];
    self.scroll = scroll;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(50, 100, 50, 50);
    [btn addTarget:self action:@selector(changeContentSize) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [scroll addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    [scroll xw_addObserverBlockForKeyPath:NSStringFromSelector(@selector(frame)) block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
        NSLog(@"old value:%@", oldVal);
        NSLog(@"new value:%@", newVal);
    }];
    
    NSLog(@"%@",NSStringFromClass(self.class));
}

- (void)changeContentSize{
//    self.scroll.contentSize = self.scroll.contentSize.height>300?CGSizeMake(200, 200):CGSizeMake(200, 400);
    self.scroll.contentSize = CGSizeMake(200, 200);
    self.scroll.frame = CGRectMake(0, 200, 200, 100);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (object == self.scroll && [keyPath isEqualToString:NSStringFromSelector(@selector(contentSize))]) {
        NSLog(@"xx");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [self.scroll removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentSize))];
}

@end
