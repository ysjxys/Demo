//
//  SJScrollView.m
//  SJScrollView
//
//  Created by ysj on 15/11/12.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SJScrollView.h"
@interface SJScrollView()
@property (nonatomic, strong) NSArray *viewArr;
@property (nonatomic, assign) NSInteger nowPicNum;
@property (nonatomic, strong) NSArray *imgsArr;
@property (nonatomic, assign) CGFloat frameWidth;
@end
@implementation SJScrollView

+ (instancetype)SJScrollViewWithRect:(CGRect)rect imgsStrArr:(NSArray *)imgsStrArr{
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 0; i < imgsStrArr.count; i++) {
        UIImage *image = [UIImage imageNamed:imgsStrArr[i]];
        [tempArr addObject:image];
    }
    return [self SJScrollViewWithRect:rect imgsArr:tempArr];
}

+ (instancetype)SJScrollViewWithRect:(CGRect)rect imgsArr:(NSArray *)imgsArr{
    SJScrollView *scroll = [[SJScrollView alloc]initWithFrame:rect];
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
    if (imgsArr.count < 3) {
        return nil;
    }
    NSMutableArray *viewArr = [NSMutableArray array];
    
    UIImageView *imgViewLeft = [[UIImageView alloc]initWithImage:imgsArr[imgsArr.count-1]];
    imgViewLeft.frame = CGRectMake(0, 0, size.width, size.height);
    [viewArr addObject:imgViewLeft];
    [self addSubview:imgViewLeft];
    
    UIImageView *imgViewMiddle = [[UIImageView alloc]initWithImage:imgsArr[0]];
    imgViewMiddle.frame = CGRectMake(size.width, 0, size.width, size.height);
    [viewArr addObject:imgViewMiddle];
    [self addSubview:imgViewMiddle];
    
    UIImageView *imgViewRight = [[UIImageView alloc]initWithImage:imgsArr[1]];
    imgViewRight.frame = CGRectMake(2*size.width, 0, size.width, size.height);
    [viewArr addObject:imgViewRight];
    [self addSubview:imgViewRight];
    
    return viewArr;
}

- (void)changePic{
    if (self.imgsArr.count < 3) {
        return;
    }
    
    if (self.contentOffset.x/self.frameWidth == 0) {
        self.nowPicNum = self.nowPicNum==0?(self.imgsArr.count-1):(self.nowPicNum-1);
    }else if(self.contentOffset.x/self.frameWidth == 2){
        self.nowPicNum = self.nowPicNum==(self.imgsArr.count-1)?0:(self.nowPicNum+1);
    }
    
    for (UIImageView *imgView in self.viewArr) {
        imgView.image = self.imgsArr[self.nowPicNum];
    }
    
    self.contentOffset = CGPointMake(self.frameWidth, 0);
    
    UIImageView *before = self.viewArr[0];
    NSInteger beforeImgNum = self.nowPicNum==0?(self.imgsArr.count-1):(self.nowPicNum-1);
    before.image = self.imgsArr[beforeImgNum];
    
    UIImageView *after = self.viewArr[2];
    NSInteger afterImgNum = self.nowPicNum==(self.imgsArr.count-1)?0:(self.nowPicNum+1);
    after.image = self.imgsArr[afterImgNum];
}


@end
