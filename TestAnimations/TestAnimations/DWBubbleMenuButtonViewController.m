//
//  DWBubbleMenuButtonViewController.m
//  TestAnimations
//
//  Created by ysj on 16/7/19.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "DWBubbleMenuButtonViewController.h"
#import "SWRevealViewController.h"
#import "DWBubbleMenuButton.h"

@interface DWBubbleMenuButtonViewController ()

@end

@implementation DWBubbleMenuButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    SWRevealViewController *revealVC = self.revealViewController;
    [self.view addGestureRecognizer:revealVC.panGestureRecognizer];
    
    DWBubbleMenuButton *menuBtn = [[DWBubbleMenuButton alloc]initWithFrame:CGRectMake(20, 100, 40, 40) expansionDirection:DirectionRight];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    label.text = @"title";
    label.layer.cornerRadius = label.frame.size.width/2;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor darkGrayColor];
    label.textColor = [UIColor whiteColor];
    label.clipsToBounds = YES;
    
    menuBtn.homeButtonView = label;
    [menuBtn addButtons:[self btnArr]];
    
    [self.view addSubview:menuBtn];
}

- (NSArray *)btnArr{
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [btn setBackgroundColor:[UIColor darkGrayColor]];
        btn.frame = CGRectMake(0, 0, 30, 30);
        btn.layer.cornerRadius = btn.frame.size.width/2;
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
        [tempArr addObject:btn];
    }
    return [tempArr copy];
}

- (void)btnSelected:(UIButton *)btn{
    NSLog(@"%@",btn.titleLabel.text);
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
