//
//  ViewController.m
//  TestCancelThread
//
//  Created by ysj on 16/7/8.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "ViewController.h"
#import "YSJWebService.h"

@interface ViewController ()
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *url = @"http://pub-web.leziyou.com/leziyou-web-new/api/v2/topic!types.action";
    for (int i = 0; i < 10; i++) {
        if (_dataTask) {
            [_dataTask cancel];
        }
        _dataTask = [YSJWebService requestTarget:self withUrl:url isPost:NO parameters:nil complete:^(id response) {
            NSLog(@"第%d次执行",i);
        } fail:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
