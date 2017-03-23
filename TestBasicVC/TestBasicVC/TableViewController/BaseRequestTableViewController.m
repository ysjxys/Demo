//
//  BaseTableViewController.m
//  douniwan
//
//  Created by uss on 15/9/1.
//  Copyright (c) 2015年 TC. All rights reserved.
//

#import "BaseRequestTableViewController.h"
#import "UIViewController+Category.h"

@implementation BaseRequestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initRequestBlock];
}

- (void)initRequestBlock {
    __weak id SELF = self;
    _errorBlock = ^(NSError *error) {
        [SELF didRequestError:error];
    };
    _completeBlock = ^(id data) {
        [SELF didRequestComplete:data];
    };
}

- (void)didRequestComplete:(id)data {
    [self hiddenProgress];
}

- (void)didRequestError:(NSError *)error {
    [self showError:error];
}

- (void)didRequest {
    [self showLoader:@"加载中..."];
}




@end
