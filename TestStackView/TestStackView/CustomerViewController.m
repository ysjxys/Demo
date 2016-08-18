//
//  CustomerViewController.m
//  TestStackView
//
//  Created by ysj on 16/8/17.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "CustomerViewController.h"

@interface CustomerViewController ()

@end

@implementation CustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIStackView *stackView = [[UIStackView alloc]initWithFrame:CGRectMake(50, 100, 200, 200)];
    //子控件的布局方向，水平或者垂直
    stackView.axis = UILayoutConstraintAxisVertical;
    //子控件间的间距
    stackView.spacing = 10;
    //类似于 UILabel 的 Alignment 属性
    stackView.alignment = UIStackViewAlignmentCenter;
    //子控件的大小
    stackView.distribution = UIStackViewDistributionFillEqually;
    [self.view addSubview:stackView];
    
    
    UIImageView *imgView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"搜索"]];
    [stackView addArrangedSubview:imgView1];
    
    UIImageView *imgView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"搜索1"]];
    [stackView addArrangedSubview:imgView2];
    
    UIImageView *imgView3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"搜索2"]];
    [stackView addArrangedSubview:imgView3];
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
