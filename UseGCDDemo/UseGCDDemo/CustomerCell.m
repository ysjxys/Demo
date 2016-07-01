//
//  CustomerCell.m
//  UseGCDDemo
//
//  Created by ysj on 16/5/30.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "CustomerCell.h"
#import "GCDDemo.h"


@implementation CustomerCell

+ (instancetype)cellWithTableView:(UITableView *)table GCDDemo:(GCDDemo *)demo{
    NSString *identifier = @"cell";
    CustomerCell *cell = [table dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CustomerCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.text = demo.name;
    return cell;
}

@end
