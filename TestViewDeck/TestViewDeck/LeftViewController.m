//
//  LeftViewController.m
//  TestViewDeck
//
//  Created by ysj on 16/6/7.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "LeftViewController.h"
#import "IIViewDeckController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeInfoLight];
    btn.frame = CGRectMake(0, 200, 40, 40);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)btnClicked{
    NSLog(@"xx");
    IIViewDeckController *deckVC = (IIViewDeckController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    NSLog(@"%d",[deckVC canRightViewPushViewControllerOverCenterController]);
    
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
