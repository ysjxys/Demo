//
//  TestNSThreadVeiwController.m
//  TestNSThread
//
//  Created by ysj on 15/12/22.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "TestNSThreadVeiwController.h"
#import "MultipleNSThreadViewController.h"

@interface TestNSThreadVeiwController ()
@property (nonatomic, strong) UIImageView *imgV;
@end

@implementation TestNSThreadVeiwController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"多个线程" style:UIBarButtonItemStylePlain target:self action:@selector(multipleThreadVC)];
    //NavigationBar模糊效果是否开启
//    self.navigationController.navigationBar.translucent = NO;
    //    iOS7及以后的版本支持，self.view.frame.origin.y会下移64像素至navigationBar下方。
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIImage *img = [UIImage imageNamed:@"brc.jpg"];
    UIImageView *imgV = [[UIImageView alloc]initWithImage:img];
    imgV.frame = CGRectMake(50, 0, 240, img.size.height/img.size.width*240);
    [self.view addSubview:imgV];
    self.imgV = imgV;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(120, 400, 80, 30);
    [btn addTarget:self action:@selector(changeImg) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"换图" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.borderColor = [[UIColor blackColor] CGColor];
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 3;
    [self.view addSubview:btn];
}

- (void)multipleThreadVC{
    MultipleNSThreadViewController *multipleVC = [[MultipleNSThreadViewController alloc]init];
    multipleVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:multipleVC animated:YES];
}

- (void)changeImg{
    //方法1：使用对象方法
    //创建一个线程，第一个参数是请求的操作，第二个参数是操作方法的参数
    //    NSThread *thread=[[NSThread alloc]initWithTarget:self selector:@selector(loadImage) object:nil];
    //    //启动一个线程，注意启动一个线程并非就一定立即执行，而是处于就绪状态，当系统调度时才真正执行
    //    [thread start];
    
    //方法2：使用类方法
    [NSThread detachNewThreadSelector:@selector(loadImage) toTarget:self withObject:nil];
}

- (void)loadImage{
    //获得数据
    NSData *data = [self loadData];
    //更新UI
    /*将数据显示到UI控件,注意只能在主线程中更新UI,
     另外performSelectorOnMainThread方法是NSObject的分类方法，每个NSObject对象都有此方法，
     它调用的selector方法是当前调用控件的方法，例如使用UIImageView调用的时候selector就是UIImageView的方法
     Object：代表调用方法的参数,不过只能传递一个参数(如果有多个参数请使用对象进行封装)
     waitUntilDone:是否线程任务完成执行
     */
    [self performSelectorOnMainThread:@selector(updateImg:) withObject:data waitUntilDone:YES];
}

- (NSData *)loadData{
    //http://img5.duitang.com/uploads/item/201411/08/20141108134043_a5tJf.jpeg
    NSURL *url = [NSURL URLWithString:@"http://img5.duitang.com/uploads/item/201411/08/20141108134043_a5tJf.jpeg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return data;
}

- (void)updateImg:(NSData *)imgData{
    UIImage *img = [UIImage imageWithData:imgData];
    self.imgV.image = img;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
