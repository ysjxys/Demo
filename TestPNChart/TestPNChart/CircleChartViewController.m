//
//  CircleChartViewController.m
//  TestPNChart
//
//  Created by ysj on 16/7/5.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "CircleChartViewController.h"
#import "PNChart.h"

@interface CircleChartViewController ()

@end

@implementation CircleChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    //clocwise 是否按时钟方向/顺时针
    //shadow 未填满部分书否显示
    //displayCountingLabel 占比
    PNCircleChart * circleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width) total:@100 current:@60 clockwise:YES shadow:YES shadowColor:[UIColor purpleColor] displayCountingLabel:YES overrideLineWidth:@5];
    [self.view addSubview:circleChart];
    
    circleChart.backgroundColor = [UIColor clearColor];
    
    
    [circleChart setStrokeColor:PNGreen];
    [circleChart strokeChart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
