//
//  GCDDemo.h
//  UseGCDDemo
//
//  Created by ysj on 16/5/30.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void (^);
@interface GCDDemo : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) Class destVcClass;
//@property (nonatomic, strong)

+ (instancetype)gcdDemoWithDic:(NSDictionary *)dic;

@end
