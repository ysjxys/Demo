//
//  BaseRefreshMultipleSectionTableViewController.h
//  magicbean
//
//  Created by Tiannan on 16/6/23.
//  Copyright © 2016年 TC. All rights reserved.
//

#import "BaseRefreshTableViewController.h"

@interface BaseRefreshMultipleSectionTableViewController : BaseRefreshTableViewController{
/**
 * 数据源：字典
 */
@protected
    NSMutableDictionary *_dataDictionary;
}

/**
 *  每个Section在数据源中对应的Key，子类需重写
 *
 *  @param section <#section description#>
 *
 */
- (id)keyOfDataDictionaryForSection:(NSInteger)section;

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
