//
//  BarChartViewController.m
//  TestPNChart
//
//  Created by ysj on 16/7/4.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "BarChartViewController.h"
#import "PNChart.h"

@interface BarChartViewController ()

@end

@implementation BarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 200.0)];
    [self.view addSubview:barChart];
    
    barChart.yChartLabelWidth = 20.0;
    barChart.chartMarginLeft = 30.0;
    barChart.chartMarginRight = 10.0;
    barChart.chartMarginTop = 5.0;
    barChart.chartMarginBottom = 10.0;
    
    barChart.yMaxValue = 40000;
    barChart.yLabelSum = 5;//y轴刻度值的数量
    barChart.isShowNumbers = NO;//是否显示具体值
    barChart.labelFont = [UIFont systemFontOfSize:10];//x轴labelFont
    barChart.labelTextColor = [UIColor purpleColor];
    [barChart setXLabels:@[@"2016.1",@"2016.2",@"2016.3",@"2016.4",@"2016.5",@"2016.6"]];
    
    
    [barChart setYValues:@[@23400, @25800, @29500, @30600, @34000, @38000]];
    
    barChart.yLabelFormatter = ^(CGFloat yValue){
        return [NSString stringWithFormat:@"%f", yValue];
    };
    [barChart setStrokeColors:@[PNGreen,PNGreen,PNRed,PNGreen,PNGreen,PNGreen,PNRed,PNGreen,PNGreen,PNRed]];
    
    [barChart strokeChart];
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
