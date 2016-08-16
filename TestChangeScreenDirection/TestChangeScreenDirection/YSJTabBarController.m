//
//  YSJTabBarController.m
//  TestChangeScreenDirection
//
//  Created by ysj on 16/8/5.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "YSJTabBarController.h"
@interface YSJTabBarController()
@property (nonatomic, assign) UIInterfaceOrientationMask orientationMask;
@property (nonatomic, assign) BOOL shouldAutorotate;
@end

@implementation YSJTabBarController

- (void)viewDidLoad{
    [super viewDidLoad];
    _orientationMask = UIInterfaceOrientationMaskAllButUpsideDown;
    _shouldAutorotate = YES;
}


- (void)setOrientationMask:(UIInterfaceOrientationMask)orientationMask{
    _orientationMask = orientationMask;
}

- (void)setAutorotate:(BOOL)shouldAutorotate{
    _shouldAutorotate = shouldAutorotate;
}

//是否允许自动旋转
- (BOOL)shouldAutorotate{
    return _shouldAutorotate;
}

//支持哪些方向的旋转
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return _orientationMask;
}

@end
