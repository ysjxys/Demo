//
//  CustomerCell.h
//  UseGCDDemo
//
//  Created by ysj on 16/5/30.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCDDemo;

@interface CustomerCell : UITableViewCell

@property (nonatomic, strong) GCDDemo *demo;

+ (instancetype)cellWithTableView:(UITableView *)table GCDDemo:(GCDDemo *)demo;
@end
