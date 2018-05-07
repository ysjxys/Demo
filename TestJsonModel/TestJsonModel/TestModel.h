//
//  TestModel.h
//  TestJsonModel
//
//  Created by ysj on 2018/4/21.
//  Copyright © 2018年 ysj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "FamilyModel.h"

@interface TestModel : JSONModel

@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) NSInteger age;
@property(nonatomic, strong) FamilyModel *family;
@property(nonatomic, copy) NSArray<FamilyModel *> *familiers;

@end

