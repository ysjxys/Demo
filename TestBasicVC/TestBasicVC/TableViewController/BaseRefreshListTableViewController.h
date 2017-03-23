//
// Created by uss on 15/9/9.
// Copyright (c) 2015 TC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRefreshTableViewController.h"


@interface BaseRefreshListTableViewController : BaseRefreshTableViewController {
    /**
    * 列表数据
    */
@protected
    NSMutableArray *_dataArray;
}

/**
 *  默认图下面是否有按钮，返回str不为空，则有按钮
 *
 *  @return NSString
 */
-(NSString*) emptyDataBtnContent;

-(NSString*) emptyDataTipsContent;

-(void) checkShowEmptyDataTipsView:(BOOL)isSearch;

/**
 *  重设 FooterView 控制空数据是否显示
 */
-(void) checkShowEmptyDataTipsView;

@end
