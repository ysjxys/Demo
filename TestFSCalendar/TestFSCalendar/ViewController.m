//
//  ViewController.m
//  TestFSCalendar
//
//  Created by ysj on 16/8/23.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import "ViewController.h"
#import "FSCalendar.h"
#import "NSDate+YSJ.h"

@interface ViewController ()<FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance>
@property (nonatomic, strong) FSCalendar *calendar;
@property (nonatomic, strong) NSCalendar *lunarCalendar;
@property (nonatomic, copy) NSArray<NSString *> *lunarChars;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FSCalendar *calendar = [[FSCalendar alloc]initWithFrame:CGRectMake(0, 100, 320, 300)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.appearance.headerDateFormat = @"yyyy.MM";
    calendar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
    self.lunarCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    self.lunarChars = @[@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",@"二一",@"二二",@"二三",@"二四",@"二五",@"二六",@"二七",@"二八",@"二九",@"三十"];
    
    NSLog(@"%@", calendar.today);
}

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date{
    return [date compareTimeToAnotherDate:calendar.today]<0?NO:YES;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date{
    NSLog(@"%@",date);
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    NSLog(@"%@", localeDate);
    [self.calendar reloadData];
}

- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date{
    NSDate *compareDate = calendar.selectedDate?calendar.selectedDate:calendar.today;
    
    return [date compareTimeToAnotherDate:compareDate]<0?calendar.appearance.titlePlaceholderColor:calendar.appearance.titleDefaultColor;
}

- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date{
    //显示农历
    NSInteger day = [self.lunarCalendar components:NSCalendarUnitDay fromDate:date].day;
    return self.lunarChars[day-1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
