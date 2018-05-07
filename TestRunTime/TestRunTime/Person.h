//
//  Person.h
//  TestRunTime
//
//  Created by ysj on 2018/3/13.
//  Copyright © 2018年 ysj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) int age;

- (void)method1;
@end
