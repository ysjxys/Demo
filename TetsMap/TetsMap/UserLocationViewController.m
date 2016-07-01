//
//  UserLocationViewController.m
//  TetsMap
//
//  Created by ysj on 16/5/6.
//  Copyright © 2016年 Harry. All rights reserved.
//

#import "UserLocationViewController.h"

@interface UserLocationViewController ()<MAMapViewDelegate>

@end

@implementation UserLocationViewController

- (instancetype)initWithTitle:(NSString *)title Map:(MAMapView *)map{
    self = [super initWithTitle:title Map:map];
    [map setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
    map.showsUserLocation = YES;
    map.delegate = self;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
//    NSLog(@"%lf",userLocation.heading.trueHeading);
    
//    NSLog(@"%lf  %lf",userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
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
