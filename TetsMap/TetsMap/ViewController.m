//
//  ViewController.m
//  TetsMap
//
//  Created by ysj on 15/12/18.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "BaseMapViewController.h"

#define kPushVCName @"kPushVCName"
#define kDescribe @"kDescribe"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *annotations;

@property (nonatomic, strong) MAMapView *map;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) BaseMapViewController *baseVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(30.2765, 120.1649);
    annotation.title = @"name";
    _annotations = @[annotation];
//    [self.map addAnnotations:self.annotations];
    
    
    [self initDataArr];
    UITableView *tableView = [[UITableView alloc]initWithFrame:[self.view bounds] style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.tableFooterView = [[UIView alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearMap) name:@"clearMap" object:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSDictionary *dic = [self.dataArr objectAtIndex:indexPath.row];
    NSString *className = [dic objectForKey:kPushVCName];
    NSString *classDescribe = [dic objectForKey:kDescribe];
    cell.textLabel.text = classDescribe;
    cell.detailTextLabel.text = className;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.dataArr objectAtIndex:indexPath.row];
    NSString *className = [dic objectForKey:kPushVCName];
    BaseMapViewController *vc = [[NSClassFromString(className) alloc]initWithTitle:className Map:self.map];
    self.baseVC = vc;
    [self.navigationController pushViewController:vc animated:YES];
}


- (MAMapView *)map{
    if (!_map) {
        _map = [[MAMapView alloc]initWithFrame:self.view.frame];
    }
    return _map;
}

- (void)clearMap{
    _map = nil;
}

- (void)initDataArr{
    NSMutableArray *dataArr = [NSMutableArray array];
    self.dataArr = dataArr;
    
    NSArray *tempArr = @[
  @{kPushVCName:@"UserLocationViewController",kDescribe:@"定位"},
  @{kPushVCName:@"UserAnnotationViewController",kDescribe:@"热点"}];
    [dataArr addObjectsFromArray:tempArr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
