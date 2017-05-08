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
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
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
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点我呀" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    btn.frame = CGRectMake(100, 300, 100, 40);
    btn.layer.cornerRadius = 0.15;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    [btn addTarget:self action:@selector(btnClicked2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 450)];
    field.enabled = NO;
    field.text = @"empty";
    [self.view addSubview:field];
    self.textField = field;
    
    NSProgress *progress = [NSProgress progressWithTotalUnitCount:1000.0];
    self.progress = progress;
     [progress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];
    
    UIProgressView *progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(20, 100, 280, 2)];
    self.progressView = progressView;
    [self.view addSubview:progressView];
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSLog(@"%@", path);
    [self prepareDownloadAndProgress];
}

- (void)btnClicked2{
    NSLog(@"xx");
}

- (void)btnClicked{
    [self testGetAndProgress];
//    if (_downloadTask.state == NSURLSessionTaskStateCompleted || _downloadTask.state == NSURLSessionTaskStateCanceling ||
//        _downloadTask.state == NSURLSessionTaskStateRunning) {
//        return;
//    }else{
//        [_downloadTask resume];
//    }
}

- (void)prepareDownloadAndProgress{
    self.progress.completedUnitCount += 100;
    
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc]initWithSessionConfiguration:sessionConfiguration];
    
    NSURL *URL = [NSURL URLWithString:@"http://mw5.dwstatic.com/2/4/1529/134981-99-1436844583.mp4"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    self.downloadTask = [sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // @property int64_t totalUnitCount;     需要下载文件的总大小
        // @property int64_t completedUnitCount; 当前已经下载的大小
        // 给Progress添加监听 KVO
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        // 回到主队列刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            // 设置进度条的百分比
            self.progressView.progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *pathStr = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:response.suggestedFilename];
        //仅将string转化为url类型，不会改变内容，适用于加载远程服务器文件数据
//        NSURL *url1 = [NSURL URLWithString:pathStr];
        //将string转化为文件路径，会自动去掉'/'，适用于加载本地文件
        NSURL *url1 = [NSURL fileURLWithPath:pathStr];
        
        //这样亦可
//        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        NSURL *url2 = [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
        return url1;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"%@",filePath);
        if (error) {
            NSLog(@"%@",error);
        }
        NSLog(@"------------      download complete!      ------------");
    }];
}

- (void)testGetAndProgress{
    self.progress.completedUnitCount += 100;
    NSURL *URL = [NSURL URLWithString:@"http://pub-web.leziyou.com/leziyou-web-new/api/v2/topic!types.action"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:URL.absoluteString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%lld/%lld",downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"lskdjfl=  %f",self.progress.fractionCompleted);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
