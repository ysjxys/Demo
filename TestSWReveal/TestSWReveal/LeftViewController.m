//
//  LeftViewController.m
//  TestSWReveal
//
//  Created by ysj on 16/7/15.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftViewController2.h"
#import "LeftViewController3.h"
#import "LeftViewController1.h"
#import "SWRevealViewController.h"
#import "CommonTool.h"

@interface LeftViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSArray *dataArr;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.rowHeight = 44;
    [self.view addSubview:table];
    
    
    
    _dataArr = @[
  @{@"title":@"left 1", @"class":[LeftViewController1 class]},
  @{@"title":@"left 2", @"class":[LeftViewController2 class]},
  @{@"title":@"left 3", @"class":[LeftViewController3 class]}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    NSDictionary *dic = _dataArr[indexPath.row];
    cell.textLabel.text = dic[@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _dataArr[indexPath.row];
    
    Class pushClass = dic[@"class"];
    UIViewController *vc = [[pushClass alloc]init];
    
    NSMutableArray *navArr = [[CommonTool shareTool].tabBarController.viewControllers mutableCopy];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [navArr replaceObjectAtIndex:0 withObject:nav];
    [CommonTool shareTool].tabBarController.viewControllers = navArr;
    
    SWRevealViewController *revealVC = self.revealViewController;
    [revealVC pushFrontViewController:[CommonTool shareTool].tabBarController animated:YES];
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
