//
//  YSJScrollView.m
//  YSJScrollView
//
//  Created by ysj on 15/11/12.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "YSJScrollView.h"
@interface YSJScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *viewArr;
@property (nonatomic, assign) NSInteger nowPicNum;
@property (nonatomic, strong) NSArray *imgsArr;
@property (nonatomic, assign) CGFloat frameWidth;

@property (nonatomic, strong) UIImageView *imgViewLeft;
@property (nonatomic, strong) UIImageView *imgViewCenter;
@property (nonatomic, strong) UIImageView *imgViewRight;
@end
@implementation YSJScrollView

+ (instancetype)scrollViewWithRect:(CGRect)rect imgsStrArr:(NSArray *)imgsStrArr{
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 0; i < imgsStrArr.count; i++) {
        UIImage *image = [UIImage imageNamed:imgsStrArr[i]];
        [tempArr addObject:image];
    }
    return [self scrollViewWithRect:rect imgsArr:tempArr];
}

+ (instancetype)scrollViewWithRect:(CGRect)rect imgsArr:(NSArray *)imgsArr{
    YSJScrollView *scroll = [[YSJScrollView alloc]initWithFrame:rect];
    scroll.imgsArr = imgsArr;
    scroll.viewArr = [scroll viewArrInit:rect.size imgsArr:imgsArr];
    scroll.frameWidth = rect.size.width;
    scroll.contentSize = CGSizeMake(scroll.frameWidth*3, 0);
    scroll.contentOffset = CGPointMake(scroll.frameWidth, 0);
    scroll.pagingEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    return scroll;
}



- (NSMutableArray *)viewArrInit:(CGSize)size imgsArr:(NSArray *)imgsArr{
    if (imgsArr.count < 1) {
        return nil;
    }
    NSMutableArray *viewArr = [NSMutableArray array];
    
    UIImageView *imgViewLeft = [[UIImageView alloc]initWithImage:imgsArr[imgsArr.count-1]];
    imgViewLeft.frame = CGRectMake(0, 0, size.width, size.height);
    [viewArr addObject:imgViewLeft];
    [self addSubview:imgViewLeft];
    self.imgViewLeft = imgViewLeft;
    
    UIImageView *imgViewCenter = [[UIImageView alloc]initWithImage:imgsArr[0]];
    imgViewCenter.frame = CGRectMake(size.width, 0, size.width, size.height);
    [viewArr addObject:imgViewCenter];
    [self addSubview:imgViewCenter];
    self.imgViewCenter = imgViewCenter;
    
    UIImage *rightImg = imgsArr.count>1?imgsArr[1]:imgsArr[0];
    UIImageView *imgViewRight = [[UIImageView alloc]initWithImage:rightImg];
    imgViewRight.frame = CGRectMake(2*size.width, 0, size.width, size.height);
    [viewArr addObject:imgViewRight];
    [self addSubview:imgViewRight];
    self.imgViewRight = imgViewRight;
    
    return viewArr;
}

- (void)changePic{
//    if (self.imgsArr.count < 3) {
//        return;
//    }
//    
//    if (self.contentOffset.x/self.frameWidth == 0) {
//        self.nowPicNum = self.nowPicNum==0?(self.imgsArr.count-1):(self.nowPicNum-1);
//    }else if(self.contentOffset.x/self.frameWidth == 2){
//        self.nowPicNum = self.nowPicNum==(self.imgsArr.count-1)?0:(self.nowPicNum+1);
//    }
//    
//    for (UIImageView *imgView in self.viewArr) {
//        imgView.image = self.imgsArr[self.nowPicNum];
//    }
//    
//    self.contentOffset = CGPointMake(self.frameWidth, 0);
//    
//    UIImageView *before = self.viewArr[0];
//    NSInteger beforeImgNum = self.nowPicNum==0?(self.imgsArr.count-1):(self.nowPicNum-1);
//    before.image = self.imgsArr[beforeImgNum];
//    
//    UIImageView *after = self.viewArr[2];
//    NSInteger afterImgNum = self.nowPicNum==(self.imgsArr.count-1)?0:(self.nowPicNum+1);
//    after.image = self.imgsArr[afterImgNum];
//    
//    self.scrollEnabled = YES;
    
    
    if (self.contentOffset.x == 0) {
        UIImage *showImg = self.imgViewLeft.image;
        NSUInteger showIndex = [self.imgsArr indexOfObject:showImg];
        self.imgViewCenter.image = showImg;
        if (showIndex+1 < self.imgsArr.count) {
            self.imgViewRight.image = self.imgsArr[showIndex+1];
        }else{
            self.imgViewRight.image = self.imgsArr[0];
        }
        self.contentOffset = CGPointMake(self.frameWidth, 0);
        if (showIndex == 0) {
            self.imgViewLeft.image = self.imgsArr[self.imgsArr.count-1];
        }else{
            self.imgViewLeft.image = self.imgsArr[showIndex-1];
        }
    }
    if (self.contentOffset.x == self.frameWidth*2) {
        UIImage *showImg = self.imgViewRight.image;
        NSUInteger showIndex = [self.imgsArr indexOfObject:showImg];
        self.imgViewCenter.image = showImg;
        if (showIndex == 0) {
            self.imgViewLeft.image = self.imgsArr[self.imgsArr.count-1];
        }else{
            self.imgViewLeft.image = self.imgsArr[showIndex-1];
        }
        self.contentOffset = CGPointMake(self.frameWidth, 0);
        if (showIndex+1 < self.imgsArr.count) {
            self.imgViewRight.image = self.imgsArr[showIndex+1];
        }else{
            self.imgViewRight.image = self.imgsArr[0];
        }
    }
    self.scrollEnabled = YES;
}

- (void)scrollEnabled:(BOOL)enable{
    self.scrollEnabled = enable;
}



@end
