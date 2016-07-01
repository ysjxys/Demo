//
//  MultipleNSThreadViewController.m
//  TestNSThread
//
//  Created by ysj on 15/12/22.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "MultipleNSThreadViewController.h"

@interface MultipleNSThreadViewController ()
@property (nonatomic, strong) NSArray *imgViewArr;
@property (nonatomic, strong) NSArray *urlArr;
@property (nonatomic, strong) NSArray *threadArr;
@end

@implementation MultipleNSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

- (void)initViews{
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
    [btn setTitle:@"换图" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.borderColor = [[UIColor blackColor] CGColor];
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 3;
    [self.view addSubview:btn];
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnCancel.frame = CGRectMake(220, 80+numPerLine*(height+badge), 80, 30);
    [btnCancel addTarget:self action:@selector(cancelThread) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnCancel.layer.borderColor = [[UIColor blackColor] CGColor];
    btnCancel.layer.borderWidth = 1;
    btnCancel.layer.cornerRadius = 3;
    [self.view addSubview:btnCancel];
    
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

- (void)cancelThread{
    for (int i = 0; i < self.urlArr.count; i++) {
        NSThread *thread = self.threadArr[i];
        if (!thread.isFinished) {
            [thread cancel];
            break;
        }
    }
}

- (void)changeImgs{
    NSMutableArray *threadArr = [NSMutableArray array];
    for (int i = 0; i < self.urlArr.count; i++) {
        NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(loadImage:) object:[NSNumber numberWithInt:i]];
        thread.name = [NSString stringWithFormat:@"Thread Name:%d",i];
        [threadArr addObject:thread];
        [thread start];
        //设置线程优先级，聊胜于无，感觉效果一般...
//        thread.threadPriority = i * 0.1;
    }
    self.threadArr = threadArr;
    
//    for (int i = 0; i < 9; i++) {
//        NSThread *thread = threadArr[i];
//        [thread start];
//    }
}

/**
 *  这里是子线程的地盘  这里是子线程的地盘
 */
- (void)loadImage:(NSNumber *)number{
    //设置最后一张图优先加载，其余线程先休眠2秒
    if ([number integerValue] != 8) {
        [NSThread sleepForTimeInterval:2.0];
    }
    if ([[NSThread currentThread] isCancelled]) {
        [NSThread exit];
    }
    NSLog(@"current Thread:%@",[NSThread currentThread]);
    NSURL *url = self.urlArr[[number integerValue]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (data == nil) {
        return;
    }
    NSDictionary *param = @{@"index":number,@"data":data};
    
    [self performSelectorOnMainThread:@selector(updateImgView:) withObject:param waitUntilDone:YES];
}

- (void)updateImgView:(NSDictionary *)param{
    UIImageView *imgvView = self.imgViewArr[[param[@"index"] integerValue]];
    imgvView.image = [UIImage imageWithData:param[@"data"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
