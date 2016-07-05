//
//  ViewController.m
//  TestPNChart
//
//  Created by ysj on 16/7/4.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "ViewController.h"

#import "PNChartType.h"
#import "LineChartViewCntroller.h"
#import "BarChartViewController.h"
#import "CircleChartViewController.h"
#import "PieChartViewController.h"
#import "ScatterChartViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    _dataArr = [NSMutableArray array];
    
    PNChartType *type0 = [[PNChartType alloc]init];
    type0.title = @"line chart";
    type0.pushClass = [LineChartViewCntroller class];
    [_dataArr addObject:type0];
    
    PNChartType *type1 = [[PNChartType alloc]init];
    type1.title = @"bar chart";
    type1.pushClass = [BarChartViewController class];
    [_dataArr addObject:type1];
    
    PNChartType *type2 = [[PNChartType alloc]init];
    type2.title = @"circle chart";
    type2.pushClass = [CircleChartViewController class];
    [_dataArr addObject:type2];
    
    PNChartType *type3 = [[PNChartType alloc]init];
    type3.title = @"pie chart";
    type3.pushClass = [PieChartViewController class];
    [_dataArr addObject:type3];
    
    PNChartType *type4 = [[PNChartType alloc]init];
    type4.title = @"scatter chart";
    type4.pushClass = [ScatterChartViewController class];
    [_dataArr addObject:type4];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    PNChartType *type = _dataArr[indexPath.row];
    cell.textLabel.text = type.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PNChartType *type = _dataArr[indexPath.row];
    [self.navigationController pushViewController:[[type.pushClass alloc]init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
