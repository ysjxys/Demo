//
//  ViewController.m
//  AFNetworkingDemo
//
//  Created by ysj on 15/12/7.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "Reachability.h"

typedef void(^CompleteHandle)(id response);
typedef void(^ErrorHandle)(NSString *errorMsg);

@interface ViewController ()
@property (nonatomic, strong) Reachability *reachability;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Reachabilty
    self.reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    NSLog(@"the net is OK? %d",[self checkNet]);
    [self checkNetStatus];
    
    //AFNetworkReachabilityManager
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        AFNetworkReachabilityStatusUnknown          = -1,  // 未知
//        AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
//        AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
//        AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
        NSLog(@"%ld",status);
    }];
    
    NSDictionary *dict = @{@"":@""};
//    NSString *urlStr = @"http://pub-web.leziyou.com/leziyou-web-new/api/v2/topic!types.action";
    
    NSString *urlStr = @"http://pub-web.leziyou.com/leziyou-web-new/api/v2/channel!childChannel.action?appId=129&id=1503312&appCode=VLG5CFXZ";
    [ViewController postJSONWithUrl:urlStr parameters:dict success:^(id response) {
        NSLog(@"%@",response);
    } fail:^(NSString *errorMsg) {
        NSLog(@"xx");
    }];
}

+ (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(CompleteHandle)success fail:(ErrorHandle)fail{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/javascript", @"text/json",@"text/plain", nil];
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"ss");
    }];
}


- (void)checkNetStatus{
    switch ([self.reachability currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"no net here");
            break;
        case ReachableViaWiFi:
            NSLog(@"wifi net");
            break;
        case ReachableViaWWAN:
            NSLog(@"wan net");
            break;
        default:
            break;
    }
}

- (BOOL)checkNet{
    self.reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    if (self.reachability.isReachable) {
        return YES;
    }
    return NO;
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
