//
//  ViewController.m
//  TestRunTime
//
//  Created by ysj on 2018/3/13.
//  Copyright © 2018年 ysj. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "objc/runtime.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *lilei = [[Person alloc]init];
    lilei.name = @"Lilei";
    lilei.age = 18;
    
    //获取类名
    //入参:类Class
    //返回:类名char数组
    const char *result1 = class_getName([Person class]);
    NSLog(@"result1: %s", result1);
    
    //获取父类
    //入参:类Class
    //返回:类Class
    Class class = class_getSuperclass([Person class]);
    NSLog(@"class: %@", class);
    
    //获取实例大小（返回size_t）
    //入参:实例的类Class
    //返回:大小size_t
    size_t size = class_getInstanceSize([Person class]);
    NSLog(@"size: %zu", size);
    
    //获取类中指定名称实例成员变量的信息
    //入参:类Class，变量名
    //返回:变量信息Ivar
    //* 1.实例变量是指变量不是属性.例如某类有个属性为:username 那么它对应的实例变量为_username
    //* 2.这个方法可以获取属性的变量,也可以获取私有变量(这点很重要)
    //* 3.如果获取的变量为空,那么 ivar_getName和 ivar_getTypeEncoding 获取的值为空,那么[NSString stringWithUTF8String:ivar1Name] 执行崩溃
    const char *nameString = [@"name" UTF8String];
    Ivar result2 = class_getInstanceVariable([Person class], nameString);
    NSLog(@"result2: %@", result2);
    
    //获取指定的属性
    //入参:类Class，属性名char数组
    //返回:属性objc_property_t
    // *  1.属性不是变量,此方法只能获取属性
    // *  2.如果属性不存在那么返回的结构体为0(可以参考下面的判断)
    // *  3.属性不存在获取property_getName 和 property_getAttributes 会崩溃
    const char *nameString2 = [@"name" UTF8String];
    objc_property_t result3 = class_getProperty([Person class], nameString2);
    NSLog(@"result3: %s", property_getName(result3));
    
    //获取方法实现
    //入参:类Class，方法名SEL
    //返回:方法实现IMP
    IMP result4 = class_getMethodImplementation([Person class], @selector(method1));
    result4();
    
    Method result5 = class_getClassMethod([Person class], @selector(method1));
    NSLog(@"result5: %@", result5);
    
    
//###class_copyIvarList:
//    拷贝变量列表。返回的一个Ivar列表的指针。获取Ivar需要遍历这个列表。
//    注意：调用copy的函数需要释放资源free();
//###class_copyPropertyList:
//    拷贝属性列表。返回的一个objc_property_t列表的指针。获取objc_property_t需要遍历这个列表。
//    注意：调用copy的函数需要释放资源free();
//    
//###class_copyMethodList:
//    拷贝方法列表。返回的一个Method列表的指针。获取Method需要遍历这个列表。
//    注意：调用copy的函数需要释放资源free();
//    此函数可以获取分类方法。
//    
//###class_copyProtocolList:
//    拷贝协议列表。返回的一个Ivar列表的指针。获取Ivar需要遍历这个列表。
//    注意：调用copy的函数需要释放资源free();
//    此函数不能获取分类中添加的协议。
//    此函数可以获取动态添加的协议。
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
