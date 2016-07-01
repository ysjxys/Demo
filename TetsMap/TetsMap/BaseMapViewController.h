//
//  BaseMapViewController.h
//  TetsMap
//
//  Created by ysj on 16/5/6.
//  Copyright © 2016年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

@interface BaseMapViewController : UIViewController
@property (nonatomic, strong) MAMapView *mapView;


- (instancetype)initWithTitle:(NSString *)title Map:(MAMapView *)map;
@end
