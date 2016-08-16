//
//  ViewController.m
//  TestChangeScreenDirection
//
//  Created by ysj on 16/8/4.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "ViewController.h"
#import "YSJNavigationController.h"
#import "YSJTabBarController.h"

@interface ViewController ()
@property (nonatomic, assign) UIInterfaceOrientationMask orientationMask;
@property (nonatomic, assign) BOOL shouldAutorotate;
@property (nonatomic, strong) YSJNavigationController *nav;
@property (nonatomic, strong) YSJTabBarController *tabBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 250, 320, 50)];
    label.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"强制横屏" forState:UIControlStateNormal];
    [btn setTintColor:self.view.tintColor];
    btn.backgroundColor = [UIColor lightGrayColor];
    btn.frame = CGRectMake(180, 100, 100, 50);
    [btn addTarget:self action:@selector(changeScreenToHorizontal) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"强制竖屏" forState:UIControlStateNormal];
    [btn2 setTintColor:self.view.tintColor];
    btn2.backgroundColor = [UIColor lightGrayColor];
    btn2.frame = CGRectMake(40, 100, 100, 50);
    [btn2 addTarget:self action:@selector(changeScreenToVertical) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"锁定/解锁屏幕" forState:UIControlStateNormal];
    [btn3 setTintColor:self.view.tintColor];
    btn3.backgroundColor = [UIColor lightGrayColor];
    btn3.frame = CGRectMake(180, 180, 100, 50);
    [btn3 addTarget:self action:@selector(lockScreen) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    _shouldAutorotate = YES;
    _orientationMask = UIInterfaceOrientationMaskAll;
    
    _nav = (YSJNavigationController *)self.navigationController;
    _tabBar = (YSJTabBarController *)self.tabBarController;
}

- (void)didRotate:(NSNotification *)notification{
    switch ([UIDevice currentDevice].orientation) {
        case UIDeviceOrientationUnknown:
            NSLog(@"UIDeviceOrientationUnknown");
            break;
        case UIDeviceOrientationPortrait:
            NSLog(@"UIDeviceOrientationPortrait");
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            NSLog(@"UIDeviceOrientationPortraitUpsideDown");
            break;
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"UIDeviceOrientationLandscapeLeft");
            break;
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"UIDeviceOrientationLandscapeRight");
            break;
        case UIDeviceOrientationFaceUp:
            NSLog(@"UIDeviceOrientationFaceUp");
            break;
        case UIDeviceOrientationFaceDown:
            NSLog(@"UIDeviceOrientationFaceDown");
            break;
        default:
            break;
    }
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

- (void)changeScreenToHorizontal{
    //ViewController
    _orientationMask = UIInterfaceOrientationMaskLandscape;
    
    //NavigationController
    [_nav setOrientationMask:_orientationMask];
    
    //TabBarController
    [_tabBar setOrientationMask:_orientationMask];
    [self changeInterfaceOrientation:UIInterfaceOrientationMaskLandscape];
}

- (void)changeScreenToVertical{
    [self changeInterfaceOrientation:UIInterfaceOrientationMaskPortraitUpsideDown];
    
    //ViewController
    _orientationMask = UIInterfaceOrientationMaskPortraitUpsideDown;
    
    //NavigationController
    if ([_nav isKindOfClass:[YSJNavigationController class]]) {
        [_nav setOrientationMask:_orientationMask];
    }
    
    //TabBarController
    if ([_tabBar isKindOfClass:[YSJTabBarController class]]) {
        [_tabBar setOrientationMask:_orientationMask];
    }
}

- (void)lockScreen{
    //ViewController
    _shouldAutorotate = !_shouldAutorotate;
    
    //NavigationController
    if ([_nav isKindOfClass:[YSJNavigationController class]]) {
        [_nav setAutorotate:_shouldAutorotate];
    }
    
    //TabBarController
    if ([_tabBar isKindOfClass:[YSJTabBarController class]]) {
        [_tabBar setAutorotate:_shouldAutorotate];
    }
}



- (void)changeDeviceOrientationSituable{
    [self changeDeviceOrientation:[UIDevice currentDevice].orientation];
}

- (void)changeInterfaceOrientation:(UIInterfaceOrientationMask)interfaceOrientationMask{
    UIDeviceOrientation deviceOrientation = UIDeviceOrientationPortrait;
    switch (interfaceOrientationMask) {
        case UIInterfaceOrientationMaskPortrait:
            deviceOrientation = UIDeviceOrientationPortrait;
            break;
        case UIInterfaceOrientationMaskLandscapeLeft:
            deviceOrientation = UIDeviceOrientationLandscapeLeft;
            break;
        case UIInterfaceOrientationMaskLandscapeRight:
            deviceOrientation = UIDeviceOrientationLandscapeRight;
            break;
        case UIInterfaceOrientationMaskPortraitUpsideDown:
            deviceOrientation = UIDeviceOrientationPortraitUpsideDown;
            break;
        case UIInterfaceOrientationMaskLandscape:
            if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
                deviceOrientation = UIDeviceOrientationLandscapeRight;
            }else{
                deviceOrientation = UIDeviceOrientationLandscapeLeft;
            }
            break;
        case UIInterfaceOrientationMaskAll:
            deviceOrientation = [UIDevice currentDevice].orientation;
            break;
        case UIInterfaceOrientationMaskAllButUpsideDown:
            if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortraitUpsideDown) {
                deviceOrientation = UIDeviceOrientationPortrait;
            }else{
                deviceOrientation = [UIDevice currentDevice].orientation;
            }
            break;
        default:
            break;
    }
    [self changeDeviceOrientation:deviceOrientation];
}

- (void)changeDeviceOrientation:(UIDeviceOrientation)deviceOrientation{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:deviceOrientation] forKey:@"orientation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
