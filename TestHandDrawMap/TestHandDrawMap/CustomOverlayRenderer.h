//
//  CustomerOverlayRenderer.h
//  TestHandDrawMap
//
//  Created by ysj on 16/10/12.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface CustomOverlayRenderer : MKOverlayRenderer

- (int)zoomLevelForZoomScale:(MKZoomScale)zoomScale;

@end
