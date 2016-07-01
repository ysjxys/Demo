//
//  TestGCDViewController.m
//  TestNSThread
//
//  Created by ysj on 15/12/22.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "TestGCDViewController.h"

@interface TestGCDViewController ()
@property (nonatomic, strong) NSArray *imgViewArr;
@property (nonatomic, strong) NSArray *urlArr;
@end

@implementation TestGCDViewController

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
    [btn addTarget:self action:@selector(changeImgsSerialAsync) forControlEvents:UIControlEventTouchUpInside];
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

//串行异步
- (void)changeImgsSerialAsync{
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i < self.urlArr.count; i++) {
        dispatch_async(serialQueue, ^{
            [self loadImage:[NSNumber numberWithInt:i]];
        });
    }
}

//并行异步
- (void)changeImgsConcurrentAsync{
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < self.urlArr.count; i++) {
        dispatch_async(concurrentQueue, ^{
            [self loadImage:[NSNumber numberWithInt:i]];
        });
    }
}

/**
 *  这里是子线程的地盘  这里是子线程的地盘
 */
- (void)loadImage:(NSNumber *)number{
    NSLog(@"current Thread:%@",[NSThread currentThread]);
    NSURL *url = self.urlArr[[number integerValue]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_sync(mainQueue, ^{
        NSDictionary *param = @{@"index":number,@"data":data};
        [self updateImgView:param];
    });
}

- (void)updateImgView:(NSDictionary *)param{
    NSLog(@"UI current Thread:%@",[NSThread currentThread]);
    UIImageView *imgvView = self.imgViewArr[[param[@"index"] integerValue]];
    imgvView.image = [UIImage imageWithData:param[@"data"]];
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
