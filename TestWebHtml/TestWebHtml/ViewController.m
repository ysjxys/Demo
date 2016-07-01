//
//  ViewController.m
//  TestWebHtml
//
//  Created by ysj on 15/12/28.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#define HTML_NO_HEAD @"<img src='http://image.woshipm.com/wp-files/2015/01/3bfef6f94d663c2c8d26f8eb5dc3229a.jpg' /><br/><img src='http://devgirl.org/wp-content/uploads/2014/11/ios8.jpeg' /><br/>"
#define HTML_HAD_HEAD @"<head></head><body><img src='http://image.woshipm.com/wp-files/2015/01/3bfef6f94d663c2c8d26f8eb5dc3229a.jpg' /><br/><img src='http://devgirl.org/wp-content/uploads/2014/11/ios8.jpeg' /><br/></body>"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btnOri = [UIButton buttonWithType:UIButtonTypeSystem];
    btnOri.frame = CGRectMake(120, 80, 80, 80);
    [btnOri setTitle:@"原图" forState:UIControlStateNormal];
    [btnOri.titleLabel setTextAlignment:NSTextAlignmentCenter];
    btnOri.tag = 0;
    [btnOri addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnOri];
    
    UIButton *btnFixedWidth = [UIButton buttonWithType:UIButtonTypeSystem];
    btnFixedWidth.frame = CGRectMake(120, 160, 80, 80);
    [btnFixedWidth setTitle:@"固定宽度" forState:UIControlStateNormal];
    [btnFixedWidth.titleLabel setTextAlignment:NSTextAlignmentCenter];
    btnFixedWidth.tag = 1;
    [btnFixedWidth addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFixedWidth];
    ////max-width: 50%%; width:auto; height:auto;
    UIButton *btnOutWidth = [UIButton buttonWithType:UIButtonTypeSystem];
    btnOutWidth.frame = CGRectMake(120, 240, 80, 80);
    [btnOutWidth setTitle:@"超宽缩小" forState:UIControlStateNormal];
    [btnOutWidth.titleLabel setTextAlignment:NSTextAlignmentCenter];
    btnOutWidth.tag = 2;
    [btnOutWidth addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnOutWidth];
    
    UIButton *btnJS = [UIButton buttonWithType:UIButtonTypeSystem];
    btnJS.frame = CGRectMake(120, 320, 80, 80);
    [btnJS setTitle:@"使用JS" forState:UIControlStateNormal];
    [btnJS.titleLabel setTextAlignment:NSTextAlignmentCenter];
    btnJS.tag = 3;
    [btnJS addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnJS];
    
    UIButton *btnMiddle = [UIButton buttonWithType:UIButtonTypeSystem];
    btnMiddle.frame = CGRectMake(120, 400, 80, 80);
    [btnMiddle setTitle:@"居中" forState:UIControlStateNormal];
    [btnMiddle.titleLabel setTextAlignment:NSTextAlignmentCenter];
    btnMiddle.tag = 4;
    [btnMiddle addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnMiddle];
}

- (void)btnClicked:(UIButton *)btn{
    NSString *htmlStr;
    WebViewController *wvc = [[WebViewController alloc]init];
    if (btn.tag == 0) {
        htmlStr = HTML_NO_HEAD;
    }else if (btn.tag == 1){
        htmlStr = [NSString stringWithFormat:@"<head><style>img{width:320px !important;}</style></head>%@",HTML_NO_HEAD];
    }else if (btn.tag == 2){
        htmlStr = [NSString stringWithFormat:@"<head><style>img{max-width:320px !important;}</style></head>%@",HTML_NO_HEAD];
    }else if (btn.tag == 3){
        htmlStr = HTML_NO_HEAD;
        wvc.isUseJS = YES;
    }else if (btn.tag == 4){
        htmlStr = [NSString stringWithFormat:@"<head><style>img{display:block; margin:0 auto;max-width:300px;}</style></head>%@",HTML_HAD_HEAD];
    }
    
    wvc.html = htmlStr;
    [self.navigationController pushViewController:wvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
