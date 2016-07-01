//
//  HomePageTableViewController.m
//  UseGCDDemo
//
//  Created by ysj on 16/5/30.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "HomePageTableViewController.h"
#import "GCDDemo.h"
#import "CustomerCell.h"
#import "CommonGCDUseViewController.h"
#import "CreateDispatchQueue.h"
#import "DispatchAfter.h"
#import "DispatchGroup.h"
#import "DispatchApply.h"
#import "DispatchSemaphore.h"
#import "DispatchOnce.h"

@interface HomePageTableViewController()
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation HomePageTableViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    _dataArr = @[
                 [GCDDemo gcdDemoWithDic:@{@"name":@"CommonGCDUseViewController",@"class":[CommonGCDUseViewController class]}],
                 [GCDDemo gcdDemoWithDic:@{@"name":@"CreateDispatchQueue",@"class":[CreateDispatchQueue class]}],
                 [GCDDemo gcdDemoWithDic:@{@"name":@"DispatchAfter",@"class":[DispatchAfter class]}],
                 [GCDDemo gcdDemoWithDic:@{@"name":@"DispatchGroup",@"class":[DispatchGroup class]}],
                 [GCDDemo gcdDemoWithDic:@{@"name":@"DispatchApply",@"class":[DispatchApply class]}],
                 [GCDDemo gcdDemoWithDic:@{@"name":@"DispatchSemaphore",@"class":[DispatchSemaphore class]}],
                 [GCDDemo gcdDemoWithDic:@{@"name":@"DispatchOnce",@"class":[DispatchOnce class]}]
                 ];
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GCDDemo *demo = self.dataArr[indexPath.row];
    CustomerCell *cell = [CustomerCell cellWithTableView:tableView GCDDemo:demo];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GCDDemo *demo = self.dataArr[indexPath.row];
    UIViewController *controller = [[demo.destVcClass alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
@end
