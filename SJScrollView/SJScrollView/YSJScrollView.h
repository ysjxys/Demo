//
//  YSJScrollView.h
//  YSJScrollView
//
//  Created by ysj on 15/11/12.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSJScrollView : UIScrollView


+ (instancetype)scrollViewWithRect:(CGRect)rect imgsStrArr:(NSArray *)imgsStrArr;
+ (instancetype)scrollViewWithRect:(CGRect)rect imgsArr:(NSArray *)imgsArr;

- (void)changePic;
- (void)scrollEnabled:(BOOL)enable;


@end
