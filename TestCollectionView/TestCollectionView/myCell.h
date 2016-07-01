//
//  myCell.h
//  TestCollectionView
//
//  Created by ysj on 15/11/16.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IDENTIFIER  @"mycell"

@class Person;

@interface myCell : UICollectionViewCell

@property (nonatomic, strong) Person *person;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collection indexPath:(NSIndexPath *)indexPath;

@end
