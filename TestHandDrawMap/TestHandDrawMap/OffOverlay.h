//
//  OffOverlay.h
//  TestHandDrawMap
//
//  Created by ysj on 16/10/12.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@class CustomMapInfo;

@interface OffOverlay : NSObject<MKOverlay>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) MKMapRect boundingMapRect;
@property (nonatomic, strong) CustomMapInfo *customMapInfo;

@end
