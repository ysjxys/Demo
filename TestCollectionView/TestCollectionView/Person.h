//
//  Person.h
//  TestCollectionView
//
//  Created by ysj on 15/11/16.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, assign) int age;

+ (instancetype)PersonWithName:(NSString *)name age:(int)age sex:(NSString *)sex address:(NSString *)address;
@end
