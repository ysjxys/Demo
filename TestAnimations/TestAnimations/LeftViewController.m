//
//  LeftViewController.m
//  TestAnimations
//
//  Created by ysj on 16/7/19.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "LeftViewController.h"
#import "DWBubbleMenuButtonViewController.h"
#import "SWRevealViewController.h"
#import "MCFireworksButtonViewController.h"

@interface LeftViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *dataArr;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArr = @[
                 @{@"title":@"DWBubbleMenuButtonViewController",@"pushClass":[DWBubbleMenuButtonViewController class]},
                 @{@"title":@"MCFireworksButtonViewController",@"pushClass":[MCFireworksButtonViewController class]}];
    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20) style:UITableViewStylePlain];
    table.rowHeight = 50;
    table.tableFooterView = [[UIView alloc]init];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    NSDictionary *dic = _dataArr[indexPath.row];
    cell.textLabel.text = dic[@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _dataArr[indexPath.row];
    Class pushClass = dic[@"pushClass"];
    
    SWRevealViewController *revealVC = self.revealViewController;
    [revealVC pushFrontViewController:[[pushClass alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
