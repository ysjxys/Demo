//
// Created by yaowang on 16/3/30.
// Copyright (c) 2016 TC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BaseCollectionViewController : UICollectionViewController

- (NSString *)collectionView:(UICollectionView *)collectionView cellIdentifierForItemAtIndexPath:(NSIndexPath *)indexPath;
- (id) collectionView:(UICollectionView *)collectionView cellDataForItemAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  <#Description#>
 *
 *  @param tableView <#tableView description#>
 *  @param cell      <#cell description#>
 *  @param indexPath <#indexPath description#>
 */
- (void)collectionView:(UICollectionView *)collectionView willUpdateCell:(UICollectionViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
@end
