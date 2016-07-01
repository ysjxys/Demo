//
//  myCell.m
//  TestCollectionView
//
//  Created by ysj on 15/11/16.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "myCell.h"
#import "Person.h"

@interface myCell()
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation myCell


+ (instancetype)cellWithCollectionView:(UICollectionView *)collection indexPath:(NSIndexPath *)indexPath{
    myCell *cell = [collection dequeueReusableCellWithReuseIdentifier:IDENTIFIER forIndexPath:indexPath];
    [cell initCellView];
    return cell;
}

- (void)initCellView{
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setPerson:(Person *)person{
    self.nameLabel.text = person.name;
}

@end
