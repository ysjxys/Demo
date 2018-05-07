//
//  ViewController.m
//  TestJsonModel
//
//  Created by ysj on 2018/4/20.
//  Copyright © 2018年 ysj. All rights reserved.
//

#import "ViewController.h"
#import "JSONModel.h"
#import "TestModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *jsonString = @"{\"name\":\"it's name\",\"age\":18,\"family\":{\"familyName\":\"it's fmilyName\", \"isNativeFamily\":true},\"familiers\":[{\"familyName\": \"fmilyName1\",\"isNativeFamily\":false},{\"familyName\": \"fmilyName2\",\"isNativeFamily\":false},{\"familyName\": \"fmilyName3\",\"isNativeFamily\":false}]}";
    
//    NSString *jsonString = @"{\"name\":\"it's name\",\"age\":18,\"family\":{\"familyName\":\"it's fmilyName\",\"isNativeFamily\":true},\"familiers\":[{\"familyName\":\"fmilyName1\",\"isNativeFamily\":false},{\"familyName\":\"fmilyName2\",\"isNativeFamily\":false},{\"familyName\":\"fmilyName3\",\"isNativeFamily\":false}]}";

    NSError *error;
    TestModel *testModel = [[TestModel alloc]initWithString:jsonString error:&error];
    NSLog(@"json:%@\n error:%@", testModel, error);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
