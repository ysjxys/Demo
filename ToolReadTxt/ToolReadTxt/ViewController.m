//
//  ViewController.m
//  ToolReadTxt
//
//  Created by ysj on 16/10/31.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"txt"];
    
    NSString *str = [[NSString alloc]initWithContentsOfFile:pathStr encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *arr =[str componentsSeparatedByString:NSLocalizedString(@"CN10", nil)];
    
    NSLog(@"%@",arr);
    
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSString *cityAll in arr) {
        if (![cityAll containsString:@"\t"]) {
            continue;
        }
        NSString *changeStr = [NSString stringWithFormat:@"CN10%@",[cityAll stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
        NSArray *singleCity = [changeStr componentsSeparatedByString:@"\t"];
        [tempArr addObject:singleCity];
    }
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:@{@"A":[NSMutableArray array],@"B":[NSMutableArray array],@"C":[NSMutableArray array],@"D":[NSMutableArray array],@"E":[NSMutableArray array],@"F":[NSMutableArray array],@"G":[NSMutableArray array],@"H":[NSMutableArray array],@"I":[NSMutableArray array],@"J":[NSMutableArray array],@"K":[NSMutableArray array],@"L":[NSMutableArray array],@"M":[NSMutableArray array],@"N":[NSMutableArray array],@"O":[NSMutableArray array],@"P":[NSMutableArray array],@"Q":[NSMutableArray array],@"R":[NSMutableArray array],@"S":[NSMutableArray array],@"T":[NSMutableArray array],@"U":[NSMutableArray array],@"V":[NSMutableArray array],@"W":[NSMutableArray array],@"X":[NSMutableArray array],@"Y":[NSMutableArray array],@"Z":[NSMutableArray array],}];
    
    for (NSArray *arr in tempArr) {
        NSDictionary *dic = @{@"id":arr[0],@"pinyin":arr[1],@"town":arr[2],@"city":arr[3],@"province":arr[4]};
        
        NSString *mark = [[arr[1] substringToIndex:1] uppercaseString];
        NSMutableArray *markArr = [tempDic objectForKey:mark];
        if (markArr) {
            [markArr addObject:dic];
        }
    }
    
    NSMutableArray *resultArr = [NSMutableArray array];
    NSArray *tempArr2 = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    for (int i = 0; i < tempArr2.count; i++) {
        NSArray *arr = tempDic[tempArr2[i]];
        if (arr.count == 0) {
            continue;
        }
        [resultArr addObject:@{@"key":tempArr2[i],@"citys":arr}];
    }
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"city.plist"];
    
    NSLog(@"%@",path);
    [resultArr writeToFile:path atomically:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
