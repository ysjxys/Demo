//
//  BaseViewController.m
//  douniwan
//
//  Created by uss on 15/9/1.
//  Copyright (c) 2015年 TC. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewController+Category.h"
#import "BaseViewController.h"
@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self conformsToProtocol:@protocol(LogPageViewProtocol)]) {
        [self beginLogPageView];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([self conformsToProtocol:@protocol(LogPageViewProtocol)]) {
        [self endLogPageView];
    }
}



- (void)beginLogPageView {
    
    [MobClick beginLogPageView:[self pageName]];
}
- (void)endLogPageView {
    [MobClick endLogPageView:[self pageName]];
}


- (NSString *)pageName {
    return self.title?self.title:@"未知页面";
}

@end
