//
//  BaseMapViewController.m
//  TetsMap
//
//  Created by ysj on 16/5/6.
//  Copyright © 2016年 Harry. All rights reserved.
//

#import "BaseMapViewController.h"

@interface BaseMapViewController ()

@end

@implementation BaseMapViewController

- (instancetype)initWithTitle:(NSString *)title Map:(MAMapView *)map{
    self = [super init];
    self.title = title;
    self.mapView = map;
    [self.view addSubview:map];
    return self;
}

- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clearMap" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.mapView.showsLabels = YES;
    self.mapView.showsCompass = YES;
    self.mapView.showsScale = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
