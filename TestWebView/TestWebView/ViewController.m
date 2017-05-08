//
//  ViewController.m
//  TestWebView
//
//  Created by ysj on 16/7/5.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    webView.delegate = self;
    [self.view addSubview:webView];
    
//    NSURL *url = [NSURL URLWithString:@"https://www.tmall.com/"];
    NSURL *url = [NSURL URLWithString:@"https://172.16.14.115:9000/person/json"];
//    NSURL *url = [NSURL URLWithString:@"http://data.zjxcdfs.com"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
