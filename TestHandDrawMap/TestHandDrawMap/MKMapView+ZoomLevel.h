//
//  MKMapView+ZoomLevel.h
//  TestHandDrawMap
//
//  Created by ysj on 16/10/14.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)

-(void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate zoomLevel:(NSUInteger)zoomLevel animated:(BOOL)animated;

@end
