//
//  BasicPicViewController.h
//  UseGCDDemo
//
//  Created by ysj on 16/5/30.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicPicViewController : UIViewController
@property (nonatomic, copy) NSArray *imgViewArr;
@property (nonatomic, copy) NSArray *urlArr;
@property (nonatomic, strong) NSMutableArray *dataArr;

- (void)changeImgs;
@end
