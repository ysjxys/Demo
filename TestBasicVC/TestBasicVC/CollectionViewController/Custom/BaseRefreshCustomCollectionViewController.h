//
//  BaseRefreshCustomCollectionViewController.h
//  magicbean
//
//  Created by yaowang on 16/4/12.
//  Copyright © 2016年 TC. All rights reserved.
//

#import "BaseRequestViewController.h"
@interface BaseRefreshCustomCollectionViewController : BaseRequestViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



- (NSString *)collectionView:(UICollectionView *)collectionView cellIdentifierForItemAtIndexPath:(NSIndexPath *)indexPath;
- (id) collectionView:(UICollectionView *)collectionView cellDataForItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView willUpdateCell:(UICollectionViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
@end
