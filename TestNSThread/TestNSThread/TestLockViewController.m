//
//  TestLockViewController.m
//  TestNSThread
//
//  Created by ysj on 15/12/25.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "TestLockViewController.h"

@interface TestLockViewController ()
@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, strong) NSMutableArray *numArr;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) UILabel *numLabel;
@end

@implementation TestLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

- (void)initViews{
    self.lock = [[NSLock alloc]init];
    self.numArr = [NSMutableArray array];
    self.num = 5;
    CGFloat height = 120;
    CGFloat badge = 10;
    NSInteger numPerLine = 3;
    
    UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, height, 320, 40)];
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.font = [UIFont systemFontOfSize:20];
    numLabel.text = [NSString stringWithFormat:@"%ld",self.num];
    self.numLabel = numLabel;
    [self.view addSubview:numLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(120, 80+numPerLine*(height+badge), 80, 30);
    [btn addTarget:self action:@selector(startBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"开跑" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.borderColor = [[UIColor blackColor] CGColor];
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 3;
    [self.view addSubview:btn];
    
}

- (void)startBtnClicked{
    for (int i = 0; i < 100; i++) {
//        [self performSelector:@selector(startThread) withObject:nil afterDelay:0.5];
        [self startThread];
    }
}



- (void)startThread{
    self.num = 10;
    self.numLabel.text = [NSString stringWithFormat:@"%ld",self.num];
    for (int i = 0; i < 20; i++) {
        NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(threadMethod:) object:[NSNumber numberWithInt:i]];
        [thread start];
    }
}

- (void)threadMethod:(NSNumber *)number{
    NSLog(@"%@",[NSThread currentThread]);
    
    /**
     *  无任何措施，线程竞速
     */
//    if (self.num > 0) {
//        [NSThread sleepForTimeInterval:0.1];
//        self.num--;
//    }
    
    /**
     * NSLock
     */
//    [self.lock lock];
//    if (self.num > 0) {
//        [NSThread sleepForTimeInterval:0.1];
//        self.num--;
//    }
//    [self.lock unlock];
    
    /**
     *  @synchronized
     */
    @synchronized(self) {
        if (self.num > 0) {
            [NSThread sleepForTimeInterval:0.1];
            self.num--;
        }
    }
    
    [self performSelectorOnMainThread:@selector(updateLabel) withObject:nil waitUntilDone:YES];
}

- (void)updateLabel{
    if (self.num < 0) {
        NSLog(@"%ld",self.num);
    }
    self.numLabel.text = [NSString stringWithFormat:@"%ld",self.num];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
