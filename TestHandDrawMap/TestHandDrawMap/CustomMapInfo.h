//
//  CustomerMapInfo.h
//  TestHandDrawMap
//
//  Created by ysj on 16/10/12.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CustomMapInfo : NSObject

@property (nonatomic, assign) int minLevel;//最小缩放等级
@property (nonatomic, assign) int maxLevel;//最大缩放等级
@property (nonatomic, assign) CGPoint original;//地图起点坐标
@property (nonatomic, assign) CLLocationCoordinate2D centerCoordinate;//中心点经纬度
//@property (nonatomic, assign) CGPoint

@end
