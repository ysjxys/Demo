//
//  SJScrollView.h
//  SJScrollView
//
//  Created by ysj on 15/11/12.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJScrollView : UIScrollView


+ (instancetype)SJScrollViewWithRect:(CGRect)rect imgsStrArr:(NSArray *)imgsStrArr;
+ (instancetype)SJScrollViewWithRect:(CGRect)rect imgsArr:(NSArray *)imgsArr;

- (void)changePic;


@end
