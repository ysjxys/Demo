//
//  CommonTool.m
//  TestSWReveal
//
//  Created by ysj on 16/7/15.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "CommonTool.h"

@implementation CommonTool

+ (instancetype)shareTool{
    static CommonTool *commonTool = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        commonTool = [[self alloc] init];
    });
    return commonTool;
}

@end
