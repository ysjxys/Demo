//
//  BaseViewController.h
//  douniwan
//
//  Created by uss on 15/9/1.
//  Copyright (c) 2015年 TC. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BaseHttpAPI.h"

@protocol LogPageViewProtocol <NSObject>
@optional
- (NSString *)pageName;
@end

/**
* ViewController基类
*/
@interface BaseViewController : UIViewController

@end
