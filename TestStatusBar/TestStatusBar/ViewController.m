//
//  ViewController.m
//  TestStatusBar
//
//  Created by ysj on 16/7/20.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "ViewController.h"
#import "CustomerNavigationController.h"
#import "CustomerTabbarController.h"

@interface ViewController ()
@property (nonatomic, strong) UISegmentedControl *segmentColor;
@property (nonatomic, strong) UISegmentedControl *segmentHide;
@property (nonatomic, strong) UISegmentedControl *segmentAnimation;

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@property (nonatomic, assign) BOOL statusBarHidden;
@property (nonatomic, assign) UIStatusBarAnimation statusBarAnimation;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    CGFloat width = 50;
    UISegmentedControl *segmentColor = [[UISegmentedControl alloc]initWithItems:@[@"White",@"Black"]];
    segmentColor.frame = CGRectMake((self.view.frame.size.width-width*2)/2, 200, width*2, 40);
    [self.view addSubview:segmentColor];
    [segmentColor addTarget:self action:@selector(segmentColorSelected:) forControlEvents:UIControlEventValueChanged];
    self.segmentColor = segmentColor;
    
    UISegmentedControl *segmentHide = [[UISegmentedControl alloc]initWithItems:@[@"Show",@"Hide"]];
    segmentHide.frame = CGRectMake((self.view.frame.size.width-width*2)/2, 300, width*2, 40);
    [self.view addSubview:segmentHide];
    [segmentHide addTarget:self action:@selector(segmentHideSelected:) forControlEvents:UIControlEventValueChanged];
    self.segmentHide = segmentHide;
    
    UISegmentedControl *segmentAnimation = [[UISegmentedControl alloc]initWithItems:@[@"None",@"Fade",@"Slide"]];
    segmentAnimation.frame = CGRectMake((self.view.frame.size.width-width*3)/2, 400, width*3, 40);
    [self.view addSubview:segmentAnimation];
    [segmentAnimation addTarget:self action:@selector(segmentAnimationSelected:) forControlEvents:UIControlEventValueChanged];
    self.segmentAnimation = segmentAnimation;
    
    segmentColor.selectedSegmentIndex = 0;
    segmentHide.selectedSegmentIndex = 0;
    segmentAnimation.selectedSegmentIndex = 0;
    
    [self segmentColorSelected:_segmentColor];
    [self segmentColorSelected:_segmentHide];
    [self segmentAnimationSelected:_segmentAnimation];
}

- (void)segmentColorSelected:(UISegmentedControl *)segmentColor{
    CustomerNavigationController *nav = (CustomerNavigationController *)self.navigationController;
    if (segmentColor.selectedSegmentIndex == 0) {
        _statusBarStyle = UIStatusBarStyleLightContent;
        nav.statusBarStyle = UIStatusBarStyleLightContent;
    }else{
        _statusBarStyle = UIStatusBarStyleDefault;
        
        nav.statusBarStyle = UIStatusBarStyleDefault;
    }
    [self setNeedsStatusBarAppearanceUpdate];
    [nav setNeedsStatusBarAppearanceUpdate];
}

- (void)segmentHideSelected:(UISegmentedControl *)segmentHide{
    if (segmentHide.selectedSegmentIndex == 0) {
        _statusBarHidden = NO;
    }else{
        _statusBarHidden = YES;
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self setNeedsStatusBarAppearanceUpdate];
    }];
}

- (void)segmentAnimationSelected:(UISegmentedControl *)segmentAnimation{
    if (segmentAnimation.selectedSegmentIndex == 0) {
        _statusBarAnimation = UIStatusBarAnimationNone;
    }else if (segmentAnimation.selectedSegmentIndex == 1){
        _statusBarAnimation = UIStatusBarAnimationFade;
    }else{
        _statusBarAnimation = UIStatusBarAnimationSlide;
    }
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma statusBarMethod

- (UIStatusBarStyle)preferredStatusBarStyle{
    return _statusBarStyle;
}

- (BOOL)prefersStatusBarHidden{
    return _statusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    return _statusBarAnimation;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
