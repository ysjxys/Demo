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
//    [self testAddObjectInMutableArray];
//    [self testDeepCopy];
//    [self testMoreDeepCopy];
    [self testCompleteCopy];
    
//    [self testCopyString];
//    [self testCopyVessel];
}

//容器类不可变对象拷贝
- (void)testCopyVessel {
    NSMutableString *string = [NSMutableString stringWithFormat:@"ludashi"];
    //第二种：容器类不可变对象拷贝
    NSLog(@"容器类不可变对象拷贝");
    NSArray *array = [NSArray arrayWithObjects:string, @"b", nil];
    NSLog(@" array[0] = %@", array[0]);
    
    //把array通过copy的方式把值赋给array2
    NSArray *array2 = [array copy];
    NSLog(@"array2[0] = %@", array2[0]);
    
    //把array通过mutableCopy方式把值赋给array3
    NSArray *array3 = [array mutableCopy];
    NSLog(@"array3[0] = %@", array3[0]);
    
    //分别输出每个地址
    NSLog(@"分别输出每个地址");
    NSLog(@" array_p = %p", array);
    NSLog(@"array2_p = %p", array2);
    NSLog(@"array3_p = %p", array3);
    
    //分别输出每个地址
    NSLog(@"分别输出拷贝后数组中第一个元素的地址");
    NSLog(@" array_p[0] = %p", array[0]);
    NSLog(@"array2_p[0] = %p", array2[0]);
    NSLog(@"array3_p[0] = %p", array3[0]);
}

//非容器类不可变对象拷贝NSString
- (void)testCopyString {
    NSLog(@"非容器类不可变对象拷贝NSString");
    NSString *str = @"ludashi";
    NSLog(@" str = %@", str);
    
    //把str通过静态方法的方式把值赋给str2
    NSString *str1 = [NSString stringWithString:str];
    NSLog(@"str1 = %@", str1);
    
    //把str通过copy的方式把值赋给str2
    NSString *str2 = [str copy];
    NSLog(@"str2 = %@", str2);
    
    //把str通过mutableCopy的方式把值赋给str3
    NSString *str3 = [str mutableCopy];
    NSLog(@"str3 = %@", str3);
    
    //分别输出每个字符串的内存地址
    NSLog(@" str-p = %p", str);
    NSLog(@"str1-p = %p", str1);
    NSLog(@"str2-p = %p", str2);
    NSLog(@"str3-p = %p", str3);
}

//mutbleCopy 是深拷贝，但仅对对象进行深处理，子内容仍为指针复制
- (void)testDeepCopy{
    NSMutableArray *dataArray1 = [NSMutableArray arrayWithObjects:
                                 [NSMutableString stringWithString:@"1"],
                                 [NSMutableString stringWithString:@"2"],
                                 [NSMutableString stringWithString:@"3"],
                                 [NSMutableString stringWithString:@"4"],
                                 nil
                                 ];
    NSMutableArray *dataArray2 = [NSMutableArray arrayWithObjects:
                                 [NSMutableString stringWithString:@"one"],
                                 [NSMutableString stringWithString:@"two"],
                                 [NSMutableString stringWithString:@"three"],
                                 [NSMutableString stringWithString:@"four"],
                                 dataArray1,
                                 nil
                                 ];
    NSMutableArray *dataArray3 = [dataArray2 mutableCopy];
    NSMutableString *mStr = dataArray2[0];
    [mStr appendString:@"--ONE"];
    
    NSLog(@"==:%d",dataArray2 == dataArray3);
    NSLog(@"equal:%d",[dataArray2 isEqualToArray:dataArray3]);
    NSLog(@"dataArray3：%@",dataArray3);
    NSLog(@"dataArray2：%@",dataArray2);
}

//initWithArray:copyItem:   单层深复制，对于多层深复制无效
- (void)testMoreDeepCopy{
    NSMutableArray *dataArray1 = [NSMutableArray arrayWithObjects:
                                [NSMutableString stringWithString:@"1"],
                                [NSMutableString stringWithString:@"2"],
                                [NSMutableString stringWithString:@"3"],
                                [NSMutableString stringWithString:@"4"],
                                nil];
    NSMutableArray *dataArray2 = [NSMutableArray arrayWithObjects:
                                [NSMutableString stringWithString:@"one"],
                                [NSMutableString stringWithString:@"two"],
                                [NSMutableString stringWithString:@"three"],
                                [NSMutableString stringWithString:@"four"],
                                dataArray1,nil];
    NSMutableArray *dataArray3 = [[NSMutableArray alloc]initWithArray:dataArray2 copyItems:YES];
    NSMutableString *mStr = dataArray2[0];
    [mStr appendString:@"--ONE"];
    NSLog(@"dataArray3：%@",dataArray3);
    NSLog(@"dataArray2：%@",dataArray2);
    
    NSMutableArray *mArr = (NSMutableArray *)dataArray2[4];
    NSMutableString *mStr2 = mArr[0];
    [mStr2 appendString:@"--ONE"];
    NSLog(@"dataArray3：%@",dataArray3);
    NSLog(@"dataArray2：%@",dataArray2);
}

//利用归档解档进行完全复制
- (void)testCompleteCopy{
    NSMutableArray *dataArray1 = [NSMutableArray arrayWithObjects:
                                [NSMutableString stringWithString:@"1"],
                                [NSMutableString stringWithString:@"2"],
                                [NSMutableString stringWithString:@"3"],
                                [NSMutableString stringWithString:@"4"],
                                  nil];
    NSMutableArray *dataArray2 = [NSMutableArray arrayWithObjects:
                                [NSMutableString stringWithString:@"one"],
                                [NSMutableString stringWithString:@"two"],
                                [NSMutableString stringWithString:@"three"],
                                [NSMutableString stringWithString:@"four"],
                                  dataArray1,nil];
//    NSKeyedArchiver   归档数据
//    NSKeyedUnarchiver 解档数据
    NSMutableArray *dataArray3 = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:dataArray2]];
    
    NSMutableArray *mArr = (NSMutableArray *)dataArray2[4];
    NSMutableString *mStr2 = mArr[0];
    [mStr2 appendString:@"--ONE"];
    NSLog(@"dataArray3：%@",dataArray3);
    NSLog(@"dataArray2：%@",dataArray2);
    NSLog(@"isEqual:%d",[dataArray2 isEqualToArray:dataArray3]);
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
