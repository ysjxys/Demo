//
//  Person.m
//  TestCollectionView
//
//  Created by ysj on 15/11/16.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (instancetype)PersonWithName:(NSString *)name age:(int)age sex:(NSString *)sex address:(NSString *)address{
    Person *person = [[Person alloc]init];
    person.name = name;
    person.age = age;
    person.sex = sex;
    person.address = address;
    return person;
}

@end
