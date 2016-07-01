//
//  ViewController.m
//  TestFMDB
//
//  Created by ysj on 16/1/6.
//  Copyright © 2016年 Harry. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"

@interface ViewController ()
@property (nonatomic, strong) FMDatabase *fmdb;
@property (nonatomic, strong) FMDatabaseQueue *fmdbQueue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //获得数据库文件路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES)lastObject];
    NSLog(@"%@",path);
    //判断 caches 文件夹是否存在.不存在则创建
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL ifPathExist = [fileManager fileExistsAtPath:path isDirectory:NULL];
    if (!ifPathExist) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //获得数据库
    NSString *fileName = [path stringByAppendingPathComponent:@"student.sqlite"];
    NSLog(@"%@",fileName);
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    self.fmdb = db;
    
    FMDatabaseQueue *fmdbQueue = [FMDatabaseQueue databaseQueueWithPath:fileName];
//    [fmdbQueue inDatabase:^(FMDatabase *db) {
//        [db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);",@"ha",@(13)];
//        [db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);",@"haha",13];
//        [db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);",@"hahaha",@(15)];
//    }];
    
    [fmdbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        BOOL result1 = [db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);",@"yy",@(13)];
        BOOL result2 = [db executeUpdate:@"INSERT INTO t_student (name, age2) VALUES (?, ?);",@"yyyy",@(14)];
        BOOL result3 = [db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);",@"yyyyyy",@(15)];
        if (!(result1 && result2 && result3)) {
            //block结束方执行回滚
            *rollback = YES;
        }
        FMResultSet *resultSet = [db executeQuery:@"select * from t_student"];
        while ([resultSet next]) {
            NSLog(@"%@",[resultSet stringForColumn:@"name"]);
        }
    }];
    
    [fmdbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *resultSet = [db executeQuery:@"select * from t_student"];
        NSLog(@"-------------");
        while ([resultSet next]) {
            NSLog(@"%@",[resultSet stringForColumn:@"name"]);
        }
    }];
    
//    [self.fmdb open];
//    [self createTable];
//    [self insertData];
//    [self query];
//    [self deleteData];
//    [self createTable];
//    [self testSpecial];
//    [self query];
//    [self.fmdb close];
}

- (void)testSpecial{
//    [self.fmdb executeUpdate:@"INSERT INTO t_student VALUES (?,?)", @"this has " lots of ' bizarre " quotes '"];
    [self.fmdb executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);", @"this has \" lots of ' bizarre \" quotes '",@(arc4random_uniform(60))];
}

- (void)deleteData{
    [self.fmdb executeUpdate:@"DELETE FROM t_student where t_student.name like '%Lily%';"];
    [self.fmdb executeUpdate:@"DROP TABLE IF EXISTS t_student;"];
}

- (void)insertData{
    for (int i = 0; i < 10; i++) {
//        NSString *name = [NSString stringWithFormat:@"Lucy%d",i];
//        // executeUpdate : 不确定的参数用?来占位
//        [self.fmdb executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);",name,@(arc4random_uniform(60))];
        
        NSString *name2 = [NSString stringWithFormat:@"Lily%d",i];
         //executeUpdateWithFormat : 不确定的参数用%@、%d等来占位
        [self.fmdb executeUpdateWithFormat:@"insert into t_student (name, age) values(%@, %d);",name2,arc4random_uniform(60)];
    }
}

- (void)query{
    FMResultSet *resultSet = [self.fmdb executeQuery:@"select * from t_student"];
    while ([resultSet next]) {
        int ID = [resultSet intForColumn:@"id"];
        NSString *name = [resultSet stringForColumn:@"name"];
        int age = [resultSet intForColumn:@"age"];
        NSLog(@"%d %@ %d",ID, name, age);
    }
}

- (void)createTable{
    BOOL result = [self.fmdb executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
    if (result) {
        NSLog(@"建表成功");
    }else{
        NSLog(@"建表失败");
    }
}

- (void)cleanCache{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    [manager removeItemAtPath:path error:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
