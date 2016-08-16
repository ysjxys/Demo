//
//  ViewController.m
//  TestNewKnowledge
//
//  Created by ysj on 16/8/12.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

static void *const dicKey = @"dicKey";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeInfoLight];
    btn.frame = CGRectMake(140, 200, 40, 40);
    [btn addTarget:self action:@selector(btnSelected) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeInfoDark];
    btn2.frame = CGRectMake(140, 300, 40, 40);
    [btn2 addTarget:self action:@selector(btnSelected2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)btnSelected2{
    //断开单个关联
    objc_setAssociatedObject(self, dicKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //断开所有关联
    objc_removeAssociatedObjects(self);
}

- (void)btnSelected{
    NSMutableDictionary *dic = objc_getAssociatedObject(self, dicKey);
    if (!dic) {
        dic = [NSMutableDictionary dictionary];
        //创建关联
        objc_setAssociatedObject(self, dicKey, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (!dic[@"number"]) {
        dic[@"number"] = @0;
    }
    NSNumber *number = dic[@"number"];
    int intNumber = [number intValue];
    intNumber++;
    dic[@"number"] = [NSNumber numberWithInt:intNumber];
    
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@",dic[key]);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//void addMethod(id self, SEL _cmd){
//    class_addMethod([self class], @selector(testMethod), (IMP)testMethod, @"v@:");
//}

void testMethod(id self, SEL _cmd){
    NSLog(@"testMethod run");
}
