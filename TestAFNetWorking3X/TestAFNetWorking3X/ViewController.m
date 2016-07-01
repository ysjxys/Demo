//
//  ViewController.m
//  TestAFNetWorking3X
//
//  Created by ysj on 16/4/29.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSProgress *progress;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [testBtn setTitle:@"测试" forState:UIControlStateNormal];
    [testBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [testBtn setBackgroundColor:[UIColor whiteColor]];
    testBtn.frame = CGRectMake(100, 500, 100, 40);
    testBtn.layer.cornerRadius = 0.15;
    testBtn.layer.borderWidth = 1;
    testBtn.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    [testBtn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];
    
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 450)];
    field.enabled = NO;
    field.text = @"empty";
    [self.view addSubview:field];
    self.textField = field;
    
    NSProgress *progress = [NSProgress progressWithTotalUnitCount:1000.0];
    self.progress = progress;
     [progress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)btnClicked{
    self.progress.completedUnitCount += 100;
//    NSURL *URL = [NSURL URLWithString:@"http://pub-web.leziyou.com/leziyou-web-new/api/v2/topic!types.action"];
    NSURL *URL = [NSURL URLWithString:@"http://192.168.10.119:8080/hztour-api/api/travel!listHotspotByParentCode.action?page=0&channelCode=ZTESEJUSUO&keyStr=%E7%81%AF%E7%AC%BC"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSProgress *progress = nil;
    
    
    [manager GET:URL.absoluteString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%lld/%lld",downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
    
//    [manager GET:URL.absoluteString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"%lld/%lld",downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"Error: %@", error);
//    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"lskdjfl=  %f",self.progress.fractionCompleted);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
