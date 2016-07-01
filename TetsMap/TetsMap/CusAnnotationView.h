//
//  CusAnnotationView.h
//  TetsMap
//
//  Created by ysj on 16/5/4.
//  Copyright © 2016年 Harry. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface CusAnnotationView : MAAnnotationView

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) UIImage *img;
@property (nonatomic, strong) UIView *callOutView;
@end
