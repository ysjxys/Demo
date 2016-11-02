//
//  ViewController.m
//  TestHandDrawMap
//
//  Created by ysj on 16/10/9.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "OffOverlay.h"
#import "CustomMapInfo.h"
#import "CustomOverlayRenderer.h"
#import "MKMapView+ZoomLevel.h"

#define MERCATOR_RADIUS 85445659.44705395

@interface ViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locManager;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) MKUserLocation *userLoc;
@property (nonatomic, strong) CustomMapInfo *mapInfo;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapInfo = [[CustomMapInfo alloc]init];
    _mapInfo.centerCoordinate = CLLocationCoordinate2DMake(30.24045,120.08128);
    
    
    _mapInfo.minLevel = 13;
    _mapInfo.maxLevel = 16;
    _mapInfo.original = CGPointMake(218086, 107493);
    
    _locManager = [[CLLocationManager alloc]init];
    [_locManager requestWhenInUseAuthorization];
    _locManager.delegate = self;
    
    _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _mapView.delegate = self;
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    //MKUserTrackingModeNone
    _mapView.mapType = MKMapTypeStandard;
    
    [_mapView setCenterCoordinate:_mapInfo.centerCoordinate zoomLevel:15 animated:NO];
    [self.view addSubview:_mapView];
    [self show3DMap];
    [_locManager startUpdatingLocation];
    [_mapView setNeedsDisplay];
}

- (void)show3DMap{
    OffOverlay *overLay = [[OffOverlay alloc]init];
    overLay.coordinate = CLLocationCoordinate2DMake(0, 0);
    overLay.boundingMapRect = MKMapRectWorld;
    overLay.customMapInfo = _mapInfo;
    [_mapView addOverlay:overLay];
}

//返回当前地图的ZoomLevel
- (int)getZoomLevel:(MKMapView*)mapView {
    int zoomLevel = 21-round(log2(mapView.region.span.longitudeDelta * MERCATOR_RADIUS * M_PI / (180.0 * mapView.bounds.size.width)))+[[UIScreen mainScreen] scale]-1;
    return zoomLevel;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    if ([overlay isKindOfClass:[OffOverlay class]]) {
        CustomOverlayRenderer *cor = [[CustomOverlayRenderer alloc]initWithOverlay:overlay];
        return cor;
    }
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *overlayRenderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        overlayRenderer.strokeColor = [UIColor blueColor];
        overlayRenderer.fillColor = [UIColor blueColor];
        overlayRenderer.lineWidth = 3;
        return overlayRenderer;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    int currentZoom = [self getZoomLevel:mapView];
    NSLog(@"currentZoom: %d",currentZoom);
    if (currentZoom > _mapInfo.maxLevel) {
        NSLog(@"%lf",[[UIScreen mainScreen] scale]);
        [_mapView setCenterCoordinate:mapView.centerCoordinate zoomLevel:(_mapInfo.maxLevel-([[UIScreen mainScreen] scale]-1)) animated:YES];
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"%f,%f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude);
    _userLoc = userLocation;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
