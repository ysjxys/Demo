//
//  ViewController.m
//  SJScrollView
//
//  Created by ysj on 15/11/12.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "ViewController.h"
#import "SJScrollView.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *viewArr;
@property (nonatomic, strong) SJScrollView *scroll;
@property (nonatomic, assign) NSInteger nowPicNum;
@property (nonatomic ,strong) NSArray *imgArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr = @[@"0首页-3景点门票.jpg",@"0首页-2旅游攻略.jpg",@"0首页-1杭州风貌.jpg",@"0首页-4杭州住宿.jpg"];
    
    SJScrollView *sjs = [SJScrollView SJScrollViewWithRect:CGRectMake(0, 0, 320, 400) imgsStrArr:arr];
    [self.view addSubview:sjs];
    sjs.delegate = self;
    self.scroll = sjs;
    
//    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 400)];
//    scroll.contentSize = CGSizeMake(960, 0);
//    scroll.backgroundColor = [UIColor grayColor];
//    scroll.pagingEnabled = YES;
//    scroll.delegate = self;
//    scroll.contentOffset = CGPointMake(320, 0);
//    self.scroll = scroll;
//    
//    [self.view addSubview:scroll];
//    
//    self.imgArr = arr;
//    
//    NSMutableArray *tempArr = [NSMutableArray array];
//    UIImageView *imgV1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:arr[0]]];
//    imgV1.frame = CGRectMake(0, 0, 320, 400);
//    [scroll addSubview:imgV1];
//    [tempArr addObject:imgV1];
//    
//    UIImageView *imgV2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:arr[1]]];
//    imgV2.frame = CGRectMake(320, 0, 320, 400);
//    [scroll addSubview:imgV2];
//    [tempArr addObject:imgV2];
//    self.nowPicNum = 1;
//    
//    UIImageView *imgV3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:arr[2]]];
//    imgV3.frame = CGRectMake(640, 0, 320, 400);
//    [scroll addSubview:imgV3];
//    [tempArr addObject:imgV3];
//    
//    self.viewArr = tempArr;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.scroll changePic];
//    if (self.scroll.contentOffset.x/320 == 0) {
//        self.nowPicNum = self.nowPicNum==0?(self.imgArr.count-1):(self.nowPicNum-1);
//    }else if(self.scroll.contentOffset.x/320 == 2){
//        self.nowPicNum = self.nowPicNum==(self.imgArr.count-1)?0:(self.nowPicNum+1);
//    }
//    
//    for (UIImageView *imgView in self.viewArr) {
//        imgView.image = [UIImage imageNamed:self.imgArr[self.nowPicNum]];
//    }
//    
//    self.scroll.contentOffset = CGPointMake(320, 0);
//    
//    UIImageView *before = self.viewArr[0];
//    NSInteger beforeImgNum = self.nowPicNum==0?(self.imgArr.count-1):(self.nowPicNum-1);
//    before.image = [UIImage imageNamed:self.imgArr[beforeImgNum]];
//    
//    UIImageView *after = self.viewArr[2];
//    NSInteger afterImgNum = self.nowPicNum==(self.imgArr.count-1)?0:(self.nowPicNum+1);
//    after.image = [UIImage imageNamed:self.imgArr[afterImgNum]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
