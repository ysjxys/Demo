//
//  ViewController.m
//  TestSearchController
//
//  Created by ysj on 16/5/19.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchControllerDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArr;
@property (nonatomic, strong) NSMutableArray *searchDataArr;
@property (nonatomic, strong) UISearchController *searvhVC;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"语文",@"数学",@"物理",@"化学",@"生物",@"英语",@"地理",@"历史",@"政治",@"体育"];
    
    CGFloat yDistance = 0;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, yDistance, self.view.frame.size.width, self.view.frame.size.height-yDistance) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UISearchController *searchVC = [[UISearchController alloc]initWithSearchResultsController:nil];
    searchVC.searchResultsUpdater = self;
    searchVC.delegate = self;
    searchVC.searchBar.delegate = self;
    
    searchVC.view.frame = CGRectMake(0, 20, self.view.frame.size.width, 40);
    searchVC.searchBar.frame = CGRectMake(searchVC.searchBar.frame.origin.x, searchVC.searchBar.frame.origin.y, searchVC.searchBar.frame.size.width, 40);
    searchVC.searchBar.placeholder = @"请输入搜索内容";
    [searchVC.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
    searchVC.searchBar.scopeButtonTitles = @[@"scope1",@"scope2"];
    searchVC.dimsBackgroundDuringPresentation = YES;
    searchVC.hidesNavigationBarDuringPresentation = YES;
    searchVC.searchBar.tintColor = [UIColor blackColor];
    searchVC.searchBar.barTintColor = [UIColor purpleColor];
    self.searvhVC = searchVC;
    tableView.tableHeaderView = searchVC.searchBar;
}

#pragma mark - UISearchBar Delegate

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    NSLog(@"%ld",selectedScope);
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *text = searchController.searchBar.text;
    [self.searchDataArr removeAllObjects];
    for (NSString *str in self.dataArr) {
        if ([str containsString:text]) {
            [self.searchDataArr addObject:str];
        }
    }
    [self.tableView reloadData];
}


#pragma mark - UISearchControllerDelegate
- (void)willPresentSearchController:(UISearchController *)searchController{
    NSLog(@"willPresentSearchController");
}
- (void)didPresentSearchController:(UISearchController *)searchController{
    NSLog(@"didPresentSearchController");
}
- (void)willDismissSearchController:(UISearchController *)searchController{
    NSLog(@"willDismissSearchController");
}
- (void)didDismissSearchController:(UISearchController *)searchController{
    NSLog(@"didDismissSearchController");
}
- (void)presentSearchController:(UISearchController *)searchController{
    NSLog(@"presentSearchController");
}

#pragma mark - UITableView delegate & datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searvhVC.active) {
        return self.searchDataArr.count;
    }else{
        return self.dataArr.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    if (self.searvhVC.active) {
        cell.textLabel.text = self.searchDataArr[indexPath.row];
    }else{
        cell.textLabel.text = self.dataArr[indexPath.row];
    }
    return cell;
}


- (NSMutableArray *)searchDataArr{
    if (!_searchDataArr) {
        _searchDataArr = [NSMutableArray array];
    }
    return _searchDataArr;
}

- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
