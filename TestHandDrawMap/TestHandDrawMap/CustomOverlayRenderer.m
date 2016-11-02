//
//  CustomerOverlayRenderer.m
//  TestHandDrawMap
//
//  Created by ysj on 16/10/12.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "CustomOverlayRenderer.h"
#import "OffOverlay.h"
#import "CustomMapInfo.h"

@implementation CustomOverlayRenderer

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale
          inContext:(CGContextRef)context{
    
//    MKMapPoint p1 = MKMapPointForCoordinate(CLLocationCoordinate2DMake(30.332318,120.407182));
//    MKMapPoint p2 = MKMapPointForCoordinate(CLLocationCoordinate2DMake(30.242758,119.991246));
//    MKMapRect allRect = MKMapRectMake(fmin(p1.x,p2.x), fmin(p1.y, p2.y), fabs(p1.x-p2.x), fabs(p1.y-p2.y));
    
    MKMapPoint p = MKMapPointForCoordinate(CLLocationCoordinate2DMake(30.24045,120.08128));
    MKMapRect allRect = MKMapRectMake(p.x, p.y, 3*powf(2, 16), 4*powf(2, 16));
    
    //x轴不及
    if (mapRect.origin.x < allRect.origin.x) {
        return;
    }
    //x轴超出
    if (allRect.origin.x+allRect.size.width < mapRect.origin.x) {
        return;
    }
    //y轴不及
    if (mapRect.origin.y < allRect.origin.y) {
        return;
    }
    //y轴超出
    if (allRect.origin.y+allRect.size.height < mapRect.origin.y) {
        return;
    }
    
    UIGraphicsPushContext(context);
    CustomMapInfo *mapInfo = [(OffOverlay *)self.overlay customMapInfo];
    int level = [self zoomLevelForZoomScale:zoomScale]-mapInfo.minLevel;
    
    double width = mapRect.size.width;
    MKMapPoint mapPoint = mapRect.origin;
    CGPoint point = [self pointForMapPoint:mapPoint];
    point = CGPointMake(fabs(point.x-allRect.origin.x)/width, fabs(point.y-allRect.origin.y)/width);
    
    UIImage *image = nil;
    NSString *imgPathJPG = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] bundlePath], [NSString stringWithFormat:@"xs_%d-%d,%d.jpg",level, (int)point.x, (int)point.y]];
    NSLog(@"imgPathJPG------  :%@",imgPathJPG);
    if([[NSFileManager defaultManager] fileExistsAtPath:imgPathJPG]){
        image = [UIImage imageWithContentsOfFile:imgPathJPG];
    }
    [image drawInRect:[self rectForMapRect:mapRect] blendMode:kCGBlendModeNormal alpha:1.0];
    UIGraphicsPopContext();
}

- (int)zoomLevelForZoomScale:(MKZoomScale)zoomScale{
    CGFloat realScale = zoomScale / [[UIScreen mainScreen] scale];
    int z = (log(realScale)/log(2.0)+20);
    
    z += ([[UIScreen mainScreen] scale] -1.0);
    NSLog(@"zoomScale:%f,screenScale:%f,zoomScale----->level:%d",zoomScale,[[UIScreen mainScreen] scale],z);
    return z;
}

@end
