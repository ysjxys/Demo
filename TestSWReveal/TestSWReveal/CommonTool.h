//
//  CommonTool.h
//  TestSWReveal
//
//  Created by ysj on 16/7/15.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWRevealViewController.h"

@interface CommonTool : NSObject

//@property (nonatomic, strong) SWRevealViewController *basicRevealVC;
@property (nonatomic, strong) UITabBarController *tabBarController;

+ (instancetype)shareTool;
@end
