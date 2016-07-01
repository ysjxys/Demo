//
//  ViewController.m
//  TestMutable
//
//  Created by ysj on 16/5/19.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Test about mutable copy mutablecopy
    
//    [self testModifyObjectInMutableArray];
//    [self testReplaceObjectInMutableArray];
//    [self testDeleteObjectInMutableArray];
    [self testAddObjectInMutableArray];
}

/**
 *  数组内保存的实际为对象的地址，mutableCopy与copy方法均复制了一份指向相同地址的不同NSArray/NSMutableArray对象
 *  修改了内容，但未修改地址，各个衍生数组指向的地址还是原来的地址，因此显示的内容均为修改后的原地址内容
 */
- (void)testModifyObjectInMutableArray{
    NSMutableArray *marr1 = [NSMutableArray arrayWithObjects:
                             [NSMutableString stringWithFormat:@"1"],@"2",@"3", nil];
    NSMutableArray *marr2 = [marr1 mutableCopy];
    NSArray *arr3 = [marr1 copy];
    NSArray *arr4 = [marr1 mutableCopy];
    
    NSMutableString *mstr = marr1[0];
    [mstr appendString:@"-1"];
    
    NSLog(@"%@",marr1);
    NSLog(@"%@",marr2);
    NSLog(@"%@",arr3);
    NSLog(@"%@",arr4);
}


/**
 *  数组内保存的实际为对象的地址，mutableCopy与copy方法均复制了一份指向相同地址的不同NSArray/NSMutableArray对象
 *  修改了地址，各个衍生数组指向的地址还是原来的地址，因此marr1显示的内容为修改后的新地址内容，其余衍生数组为原地址内容
 */
- (void)testReplaceObjectInMutableArray{
    NSMutableArray *marr1 = [NSMutableArray arrayWithObjects:
                             [NSMutableString stringWithFormat:@"1"],@"2",@"3", nil];
    NSMutableArray *marr2 = [marr1 mutableCopy];
    NSArray *arr3 = [marr1 copy];
    NSArray *arr4 = [marr1 mutableCopy];
    
    NSString *str = @"0";
    [marr1 replaceObjectAtIndex:0 withObject:str];
    
    NSLog(@"%@",marr1);
    NSLog(@"%@",marr2);
    NSLog(@"%@",arr3);
    NSLog(@"%@",arr4);
}

/**
 *  同testReplaceObjectInMutableArray
 */
- (void)testDeleteObjectInMutableArray{
    NSMutableArray *marr1 = [NSMutableArray arrayWithObjects:
                             [NSMutableString stringWithFormat:@"1"],@"2",@"3", nil];
    NSMutableArray *marr2 = [marr1 mutableCopy];
    NSArray *arr3 = [marr1 copy];
    NSArray *arr4 = [marr1 mutableCopy];
    
    [marr1 removeLastObject];
    
    NSLog(@"%@",marr1);
    NSLog(@"%@",marr2);
    NSLog(@"%@",arr3);
    NSLog(@"%@",arr4);
}

/**
 *  同testReplaceObjectInMutableArray
 */
- (void)testAddObjectInMutableArray{
    NSMutableArray *marr1 = [NSMutableArray arrayWithObjects:
                             [NSMutableString stringWithFormat:@"1"],@"2",@"3", nil];
    NSMutableArray *marr2 = [marr1 mutableCopy];
    NSArray *arr3 = [marr1 copy];
    NSArray *arr4 = [marr1 mutableCopy];
    
    [marr1 addObject:@"4"];
    
    NSLog(@"%@",marr1);
    NSLog(@"%@",marr2);
    NSLog(@"%@",arr3);
    NSLog(@"%@",arr4);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
