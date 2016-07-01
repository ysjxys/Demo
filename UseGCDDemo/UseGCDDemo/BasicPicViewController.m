//
//  BasicPicViewController.m
//  UseGCDDemo
//
//  Created by ysj on 16/5/30.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "BasicPicViewController.h"
@interface BasicPicViewController()

@end

@implementation BasicPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    NSString *title = [NSString stringWithUTF8String:object_getClassName(self)];
    self.navigationItem.title = title;
    NSLog(@"%@",title);
}

- (void)initViews{
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat width = 90;
    CGFloat height = 120;
    CGFloat badge = 10;
    NSInteger numPerLine = 3;
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 0; i < 9; i++) {
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.frame = CGRectMake(10+i%numPerLine*(width+badge), 80+i/numPerLine*(height+badge), width, height);
        imgView.backgroundColor = [UIColor purpleColor];
        [self.view addSubview:imgView];
        [tempArr addObject:imgView];
    }
    self.imgViewArr = tempArr;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(120, 80+numPerLine*(height+badge), 80, 30);
    [btn addTarget:self action:@selector(changeImgs) forControlEvents:UIControlEventTouchUpInside];
    //        [btn addTarget:self action:@selector(NSInvocationOperation) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"换图" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.borderColor = [[UIColor blackColor] CGColor];
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 3;
    [self.view addSubview:btn];
    
    self.urlArr = @[[NSURL URLWithString:@"http://img5.duitang.com/uploads/item/201411/08/20141108134043_a5tJf.jpeg"],
                    [NSURL URLWithString:@"http://img4.duitang.com/uploads/item/201207/31/20120731235203_R8GAn.thumb.700_0.jpeg"],
                    [NSURL URLWithString:@"http://img5.duitang.com/uploads/item/201408/16/20140816081801_X2kMM.png"],
                    [NSURL URLWithString:@"http://img4.duitang.com/uploads/item/201402/18/20140218232806_v4ZQ2.thumb.600_0.jpeg"],
                    [NSURL URLWithString:@"http://img4.duitang.com/uploads/item/201309/20/20130920191950_WeKXv.thumb.600_0.jpeg"],
                    [NSURL URLWithString:@"http://img5.duitang.com/uploads/item/201409/14/20140914230635_xfSv2.thumb.700_0.jpeg"],
                    [NSURL URLWithString:@"http://img5.duitang.com/uploads/item/201408/10/20140810091609_Kdj4c.thumb.700_0.jpeg"],
                    [NSURL URLWithString:@"http://img4.duitang.com/uploads/blog/201405/01/20140501180906_fNPFF.thumb.600_0.jpeg"],
                    [NSURL URLWithString:@"http://img4.duitang.com/uploads/item/201408/25/20140825231450_NTdRK.jpeg"]];
}

- (void)changeImgs{
    
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
