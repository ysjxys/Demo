//
//  FamilyModel.h
//  TestJsonModel
//
//  Created by ysj on 2018/4/21.
//  Copyright © 2018年 ysj. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FamilyModel : JSONModel

@property(nonatomic, copy) NSString *familyName;
@property(nonatomic, assign) BOOL isNativeFamily;

@end
