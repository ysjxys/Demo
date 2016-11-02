//
//  ViewController.m
//  TimePusher
//
//  Created by ysj on 16/9/22.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "ViewController.h"
#import "CellModel.h"
#import "MBProgressHUD.h"
#import <UserNotifications/UserNotifications.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArr;
@property (nonatomic, strong) UIDatePicker *startTimePicker;
@property (nonatomic, strong) UIDatePicker *intervalTimePicker;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) CellModel *modelSetStartTime;
@property (nonatomic, strong) CellModel *modelSetInterValTime;
@property (nonatomic, assign) NSTimeInterval durationSeconds;
@property (nonatomic, strong) NSDate *fireDate;
@property (nonatomic, strong) UILocalNotification *localNotification;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initData];
    [self initView];
}

- (void)initData{
    _modelSetStartTime = [CellModel modelWithTitle:@"定点后每小时提醒" subTitle:@"" selectedHandle:^{
        [self changeIntervalTimePickerStatusShouldShow:NO];
        [self changeStartTimePickerStatusShouldShow:YES];
        [self startDatePickerValueChanged:_startTimePicker];
    }];
    
    _modelSetInterValTime = [CellModel modelWithTitle:@"即时起指定时间间隔提醒" subTitle:@"" selectedHandle:^{
        [self changeStartTimePickerStatusShouldShow:NO];
        [self changeIntervalTimePickerStatusShouldShow:YES];
        [self intervalTimePickerValueChanged:_intervalTimePicker];
    }];
    
    CellModel *modelStart = [CellModel modelWithTitle:@"开始" subTitle:@"" selectedHandle:^{
        if (!_fireDate && !_durationSeconds) {
            [self showHudWithTarget:self title:@"请选择一种提醒模式"];
            return;
        }
        if (!_durationSeconds && _fireDate) {
            [self startLocalNotification];
            [self showHudWithTarget:self title:@"定时开启成功"];
            return;
        }
        if (!_fireDate && _durationSeconds) {
            [self initUNUserNotificationCenter];
            [self showHudWithTarget:self title:@"定时开启成功"];
            return;
        }
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"选择模式" message:@"请选择一种提醒模式" delegate:self cancelButtonTitle:nil otherButtonTitles:@"定点每小时",@"定间隔", nil];
        [alert show];
    }];
    
    CellModel *modelEnd = [CellModel modelWithTitle:@"结束" subTitle:@"" selectedHandle:^{
        [self endLocalNotification];
        [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
        [self showHudWithTarget:self title:@"定时关闭成功"];
        
    }];
    
    _dataArr = @[_modelSetStartTime, _modelSetInterValTime, modelStart, modelEnd];
}

- (void)initView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 50;
    _tableView = tableView;
    [self.view addSubview:tableView];
    
    UIView *coverView = [[UIView alloc]initWithFrame:tableView.frame];
    coverView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:coverView];
    coverView.hidden = YES;
    _coverView = coverView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverTap)];
    [coverView addGestureRecognizer:tap];
    
    
    _startTimePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 216)];
    _startTimePicker.datePickerMode = UIDatePickerModeDateAndTime;
    _startTimePicker.minimumDate = [NSDate date];
    [_startTimePicker addTarget:self action:@selector(startDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_startTimePicker];
    
    
    _intervalTimePicker = [[UIDatePicker alloc]initWithFrame:_startTimePicker.frame];
    _intervalTimePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    [_intervalTimePicker addTarget:self action:@selector(intervalTimePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_intervalTimePicker];
    
    [self initLocalNotification];
}



- (void)intervalTimePickerValueChanged:(UIDatePicker *)datePicker{
    _durationSeconds = datePicker.countDownDuration;
    int hour = datePicker.countDownDuration/3600;
    int min = ((int)(datePicker.countDownDuration/60))%60;
    NSString *duration = [NSString stringWithFormat:@"%dh %dmin",hour,min];
    NSLog(@"%@",duration);
    _modelSetInterValTime.subTitle = duration;
    [_tableView reloadData];
}

- (void)startDatePickerValueChanged:(UIDatePicker *)datePicker{
    _fireDate = datePicker.date;
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"MM-dd HH:mm";
    NSString *dateStr = [format stringFromDate:datePicker.date];
    NSLog(@"%@",dateStr);
    _modelSetStartTime.subTitle = dateStr;
    [_tableView reloadData];
}

- (void)coverTap{
    [self changeStartTimePickerStatusShouldShow:NO];
    [self changeIntervalTimePickerStatusShouldShow:NO];
}

- (void)changeIntervalTimePickerStatusShouldShow:(BOOL)shouldShow{
    CGFloat degree = 0.0f;
    if (shouldShow) {
        degree = -216.0f;
        _coverView.hidden = NO;
    }else{
        _coverView.hidden = YES;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _intervalTimePicker.frame = CGRectMake(0, self.view.frame.size.height+degree, self.view.frame.size.width, 216);
    }];
}

- (void)changeStartTimePickerStatusShouldShow:(BOOL)shouldShow{
    CGFloat degree = 0.0f;
    if (shouldShow) {
        degree = -216.0f;
        _coverView.hidden = NO;
    }else{
        _coverView.hidden = YES;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _startTimePicker.frame = CGRectMake(0, self.view.frame.size.height+degree, self.view.frame.size.width, 216);
    }];
}

- (void)showHudWithTarget:(id)target title:(NSString *)title{
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:[(UIViewController *)target view]];
    HUD.labelText = title;
    HUD.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"X"]];
    HUD.mode = MBProgressHUDModeCustomView;
    [[(UIViewController *)target view] addSubview:HUD];
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(1.5f);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
}

#pragma  mark UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self startLocalNotification];
        [self showHudWithTarget:self title:@"定时开启成功"];
    }else{
        [self initUNUserNotificationCenter];
        [self showHudWithTarget:self title:@"定时开启成功"];
    }
}

#pragma mark - UNUserNotificationCenter
- (void)initUNUserNotificationCenter{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title = @"我是title";
    content.subtitle = @"我是subtitle";
    content.body = @"我是body 该做事了~喂~~";
    content.badge = @1;
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:_durationSeconds repeats:YES];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"identifier" content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark - LocalNotification
- (void)startLocalNotification{
    _localNotification.fireDate = _fireDate;
    [[UIApplication sharedApplication] scheduleLocalNotification:_localNotification];
}

- (void)endLocalNotification{
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    for (UILocalNotification *notification in localNotifications) {
        NSString *notMsg = [notification.userInfo objectForKey:@"key"];
        NSLog(@"key:%@",notMsg);
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)initLocalNotification{
    _localNotification = [[UILocalNotification alloc]init];
    _localNotification.timeZone = [NSTimeZone localTimeZone];
    _localNotification.alertBody = @"时间到啦~刷刷刷酒馆啊~~~";
    _localNotification.soundName = UILocalNotificationDefaultSoundName;
    _localNotification.alertAction = NSLocalizedString(@"这货是alertAction", nil);
    
    //通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"赶紧刷酒馆~" forKey:@"我是通知"];
    _localNotification.userInfo = userDict;
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
        _localNotification.repeatInterval = NSCalendarUnitHour;
    }
}

#pragma mark - tableView delegate & dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    CellModel *cellModel = _dataArr[indexPath.section];
    cell.textLabel.text = cellModel.title;
    cell.detailTextLabel.text = cellModel.subTitle;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CellModel *cellModel = _dataArr[indexPath.section];
    cellModel.selectedHandle();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
