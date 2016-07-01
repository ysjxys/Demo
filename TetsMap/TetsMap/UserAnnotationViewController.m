//
//  UserAnnotationViewController.m
//  TetsMap
//
//  Created by ysj on 16/5/6.
//  Copyright © 2016年 Harry. All rights reserved.
//

#import "UserAnnotationViewController.h"

@interface UserAnnotationViewController ()<MAMapViewDelegate>
@property (nonatomic, strong) NSMutableArray *annotations;
@end

@implementation UserAnnotationViewController

- (instancetype)initWithTitle:(NSString *)title Map:(MAMapView *)map{
    self = [super initWithTitle:title Map:map];
    [map setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
    [map addAnnotations:self.annotations];
    [map showAnnotations:self.annotations edgePadding:UIEdgeInsetsMake(20, 20, 20, 80) animated:YES];
    map.delegate = self;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    static NSString *identifier = @"pointReuseIndetifier";
    MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
        annotationView = [[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    annotationView.canShowCallout = YES;
    annotationView.animatesDrop = YES;
    annotationView.draggable = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    annotationView.pinColor = [self.annotations indexOfObject:annotation] % 3;
    
    return annotationView;
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"accessory view :%@", view);
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState{
    NSLog(@"old :%ld - new :%ld", (long)oldState, (long)newState);
}

- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view{
    NSLog(@"callout view :%@", view);
}

- (NSMutableArray *)annotations{
    if (!_annotations) {
        CLLocationCoordinate2D locations[10] = {
            {39.992520, 116.336170},
            {39.992520, 116.336170},
            {39.998293, 116.352343},
            {40.004087, 116.348904},
            {40.001442, 116.353915},
            {39.989105, 116.353915},
            {39.989098, 116.360200},
            {39.998439, 116.360201},
            {39.979590, 116.324219},
            {39.978234, 116.352792}};
        _annotations = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            MAPointAnnotation *annotation = [[MAPointAnnotation alloc]init];
            annotation.coordinate = locations[i];
            annotation.title = [NSString stringWithFormat:@"hotPoint No.%d",i+1];
            annotation.subtitle = @"sub title";
            [_annotations addObject:annotation];
        }
    }
    return _annotations;
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
