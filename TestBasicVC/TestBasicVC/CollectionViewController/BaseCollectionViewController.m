//
// Created by yaowang on 16/3/30.
// Copyright (c) 2016 TC. All rights reserved.
//

#import "BaseCollectionViewController.h"


@implementation BaseCollectionViewController {

}

- (NSString *)collectionView:(UICollectionView *)collectionView cellIdentifierForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (id)collectionView:(UICollectionView *)collectionView cellDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [self collectionView:collectionView cellIdentifierForItemAtIndexPath:indexPath];
    UICollectionViewCell *cell = nil;
    if (identifier != nil) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    }
    else {
        cell =  [super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    }

    if ([cell conformsToProtocol:@protocol(OEZUpdateProtocol)]) {
        [self collectionView:collectionView willUpdateCell:cell forRowAtIndexPath:indexPath];
        id data = [self collectionView:collectionView cellDataForItemAtIndexPath:indexPath];
        [(id <OEZUpdateProtocol>) cell update:data];
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView willUpdateCell:(UICollectionViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
