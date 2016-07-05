//
//  LineChartViewCntroller.m
//  TestPNChart
//
//  Created by ysj on 16/7/4.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "LineChartViewCntroller.h"
#import "PNChart.h"

@interface LineChartViewCntroller ()

@end

@implementation LineChartViewCntroller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
//    linechart范围
    PNLineChart *lineChart = [[PNLineChart alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
    [self.view addSubview:lineChart];
    //setXLabels 前设置chartMarginLeft 调整x轴数据距离
    lineChart.chartMarginLeft = 0;//x轴坐标点距原点预留x距离
    [lineChart setXLabels:[NSArray arrayWithObjects:@"2016.1",@"2016.2",@"2016.3",@"2016.4",@"2016.5",@"2016.6", nil]];
    //setXLabels 后设置chartMarginLeft 使曲线不受位移影响
    lineChart.chartMarginLeft = 25;//x轴坐标点距原点预留x距离
    lineChart.yFixedValueMin = 20000;
    lineChart.yFixedValueMax = 40000;
    lineChart.showYGridLines = YES;//y轴辅助线
    lineChart.showCoordinateAxis = YES;//xy轴坐标线
//    lineChart.showSmoothLines = YES;//连线变柔和
    lineChart.xUnit = @"月";//x轴单位
    lineChart.yUnit = @"元";//y轴单位
    
    
    NSArray * data1Array = @[@23400, @25800, @29500, @30600, @34000, @38000];
    PNLineChartData *data1= [PNLineChartData new];
    data1.color = PNFreshGreen;
    data1.itemCount = lineChart.xLabels.count;
    data1.inflexionPointStyle = PNLineChartPointStyleTriangle;
    data1.getData = ^(NSUInteger index){
        CGFloat yValue = [data1Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    NSArray * data2Array = @[@24888, @27487, @31343, @32137, @35223, @39334];
    PNLineChartData *data2= [PNLineChartData new];
    data2.color = PNRed;
    data2.itemCount = lineChart.xLabels.count;
    data2.inflexionPointStyle = PNLineChartPointStyleCircle;
    data2.getData = ^(NSUInteger index){
        CGFloat yValue = [data2Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    
    lineChart.chartData = @[data1, data2];
    [lineChart strokeChart];
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
