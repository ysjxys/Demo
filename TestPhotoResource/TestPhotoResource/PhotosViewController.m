//
//  PhotosViewController.m
//  TestPhotoResource
//
//  Created by ysj on 2017/1/17.
//  Copyright © 2017年 Harry. All rights reserved.
//

#import "PhotosViewController.h"


@interface PhotosViewController () <UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, copy) NSArray *imageURLArr;
@property (nonatomic, strong) UICollectionView *collection;

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self initData2];
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collection.delegate = self;
    collection.dataSource = self;
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    collection.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:collection];
    self.collection = collection;
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear: %@", [self getTimeNow]);
//    [self initData2];
}

- (NSMutableArray *)assetArr{
    if (!_assetArr) {
        _assetArr = [NSMutableArray array];
    }
    return _assetArr;
}

- (void)initData2{
    NSMutableOrderedSet *photos = [NSMutableOrderedSet new];
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("com.neteaseyx.xiupin", DISPATCH_QUEUE_PRIORITY_DEFAULT);
    dispatch_group_enter(dispatchGroup);
    _assetsLibrary = [[ALAssetsLibrary alloc] init];
    
    NSLog(@"beforeEnum: %@", [self getTimeNow]);
    [_assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (!group) {
            dispatch_group_leave(dispatchGroup);
            return ;
        }else{
            //图片
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            
            dispatch_group_enter(dispatchGroup);
            [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                dispatch_async(queue, ^{
                    if (result == nil) {
                        dispatch_group_leave(dispatchGroup);
                        return ;
                    }
                    if ([[result defaultRepresentation] url].absoluteString.length == 0) {
                        return;
                    }
                    
                    [photos addObject:result];
                });
            }];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"error:%@",error);
        dispatch_group_leave(dispatchGroup);
    }];
    
    dispatch_group_notify(dispatchGroup, queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"beforeReload: %@", [self getTimeNow]);
            self.assetArr = [photos array].mutableCopy;
            [self.collection reloadData];
        });
    });
    
    
}

- (void)initData{
    NSMutableOrderedSet *photos = [NSMutableOrderedSet new];
    
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("com.neteaseyx.xiupin", DISPATCH_QUEUE_PRIORITY_DEFAULT);
    
    dispatch_group_enter(dispatchGroup);
    _assetsLibrary = [[ALAssetsLibrary alloc] init];
    
    [_assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (!group) {
            dispatch_group_leave(dispatchGroup);
            return ;
        }else{
            //图片
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            
            dispatch_group_enter(dispatchGroup);
            [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                dispatch_async(queue, ^{
                    if (result == nil) {
                        dispatch_group_leave(dispatchGroup);
                        return ;
                    }
                    if ([[result defaultRepresentation] url].absoluteString.length == 0) {
                        return;
                    }
                    [photos addObject:[[result defaultRepresentation] url].absoluteString];
                });
            }];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"error:%@",error);
        dispatch_group_leave(dispatchGroup);
    }];
    
    dispatch_group_notify(dispatchGroup, queue, ^{
        NSArray *photoArr = [photos array];
        dispatch_async(dispatch_get_main_queue(), ^{
            _imageURLArr = photoArr;
            [_collection reloadData];
        });
    });
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.imageURLArr.count;
    return self.assetArr.count;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(60, 60);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ALAsset *asset = _assetArr[indexPath.row];
    cell.contentView.backgroundColor = [UIColor purpleColor];
    BOOL isAliveable = NO;
    for (UIView *view in cell.contentView.subviews) {
        if (view.tag == 100) {
            isAliveable = YES;
            UIImageView *imgView = (UIImageView *)view;
            
            imgView.image = [UIImage imageWithCGImage:asset.thumbnail];
            break;
        }
    }
    if (!isAliveable) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:cell.bounds];
        imgView.tag = 100;
        [cell.contentView addSubview:imgView];
        
        imgView.image = [UIImage imageWithCGImage:asset.thumbnail];
        
//        [self setImageView:imgView withImageURL:_imageURLArr[indexPath.row]];
    }
    NSLog(@"cell Complete,id:%ld time:%@",indexPath.row, [self getTimeNow]);
    return cell;
}

- (void)setImageView:(UIImageView *)imageView withImageURL:(NSString *)url{
    NSLog(@"%@", url);
    NSURL *imgURL = [NSURL URLWithString:url];
    [_assetsLibrary assetForURL:imgURL resultBlock:^(ALAsset *asset) {
        imageView.image = [UIImage imageWithCGImage:asset.aspectRatioThumbnail];
    } failureBlock:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSString *)getTimeNow{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm:ss:SSS"];
    NSString *timeNow = [formatter stringFromDate:[NSDate date]];
    return timeNow;
}

@end
