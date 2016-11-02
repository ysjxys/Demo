//
//  CellModel.h
//  TimePusher
//
//  Created by ysj on 16/9/22.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SelectedHandle)();
@interface CellModel : NSObject


@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) SelectedHandle selectedHandle;

+ (instancetype)modelWithTitle:(NSString *)title subTitle:(NSString *)subTitle selectedHandle:(SelectedHandle)selectedHandle;

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle selectedHandle:(SelectedHandle)selectedHandle;

@end
