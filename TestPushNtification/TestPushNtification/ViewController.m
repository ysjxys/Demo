//
//  ViewController.m
//  TestPushNtification
//
//  Created by ysj on 16/1/7.
//  Copyright © 2016年 Harry. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 100, 50, 20)];
    textField.placeholder = @"试试kvc";
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:textField];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"本地通知" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(120, 150, 80, 30);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(localNotification) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"推送通知" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.frame = CGRectMake(120, 250, 80, 30);
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(pushNotification) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"取消本地通知" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn3.frame = CGRectMake(100, 350, 120, 30);
    [self.view addSubview:btn3];
    [btn3 addTarget:self action:@selector(cancelLocalNotification) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cancelLocalNotification{
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    for (UILocalNotification *notification in localNotifications) {
        NSString *notMsg = [notification.userInfo objectForKey:@"key"];
        NSLog(@"key:%@",notMsg);
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)localNotification{
    NSLog(@"local Notification");
    UILocalNotification *localNotification = [[UILocalNotification alloc]init];
    //从现在起3秒后启动通知
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
    localNotification.timeZone = [NSTimeZone localTimeZone];
    localNotification.alertBody = @"这货是alertBody";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.alertAction = NSLocalizedString(@"这货是alertAction", nil);
    NSInteger badgeNum = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badgeNum++;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badgeNum;
    
    //通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"key的value" forKey:@"key"];
    localNotification.userInfo = userDict;
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
        localNotification.repeatInterval = NSCalendarUnitMinute;
    }else{
        localNotification.repeatInterval = NSCalendarUnitYear;
    }
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void)pushNotification{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
