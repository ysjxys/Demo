//
//  ViewController.m
//  TestCollectionView
//
//  Created by ysj on 15/11/16.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "myCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *array;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //初始化
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 20, 300, 400)collectionViewLayout:flowLayout];
    //注册cell类
    [collection registerClass:[myCell class] forCellWithReuseIdentifier:IDENTIFIER];
    //代理
    collection.delegate = self;
    collection.dataSource = self;
    [self.view addSubview:collection];
    
    collection.backgroundColor = [UIColor purpleColor];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"num:%lu",self.array.count);
    return self.array.count;
//    return 10;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 60);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    /*
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionTest" forIndexPath:indexPath];
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    tempView.backgroundColor = [UIColor grayColor];
    [cell.contentView addSubview:tempView];
    return cell;
     */
    
    myCell *cell = [myCell cellWithCollectionView:collectionView indexPath:indexPath];
    cell.person = self.array[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (NSArray *)array{
    if (!_array) {
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            Person *person = [Person PersonWithName:@"myname" age:18 sex:@"male" address:@"xxxxx"];
            [arr addObject:person];
        }
        _array = arr;
    }
    return _array;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
