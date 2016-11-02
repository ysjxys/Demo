//
//  CellModel.m
//  TimePusher
//
//  Created by ysj on 16/9/22.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel

+ (instancetype)modelWithTitle:(NSString *)title subTitle:(NSString *)subTitle selectedHandle:(SelectedHandle)selectedHandle{
    return [[self alloc]initWithTitle:title subTitle:subTitle selectedHandle:selectedHandle];
}

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle selectedHandle:(SelectedHandle)selectedHandle{
    if (self = [super init]) {
        self.title = title;
        self.subTitle = subTitle;
        self.selectedHandle = selectedHandle;
    }
    return self;
}
@end
