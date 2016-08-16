//
//  YSJTabBarController.h
//  TestChangeScreenDirection
//
//  Created by ysj on 16/8/5.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSJTabBarController : UITabBarController

- (void)setOrientationMask:(UIInterfaceOrientationMask)orientationMask;
- (void)setAutorotate:(BOOL)shouldAutorotate;

@end
