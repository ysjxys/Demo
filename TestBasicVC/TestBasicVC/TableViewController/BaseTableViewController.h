//
//  BaseTableViewController.h
//  douniwan
//
//  Created by uss on 15/9/1.
//  Copyright (c) 2015年 TC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHttpAPI.h"

/**
* TableViewController 基类
*/
@interface BaseTableViewController : UITableViewController<OEZTableViewDelegate>

/**
 *  获取 cell Identifier
 *
 *  @param tableView tableView description
 *  @param indexPath indexPath description
 *
 *  @return cell identifier
 */
- (NSString *) tableView:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  获取cell数据
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (id) tableView:(UITableView *)tableView cellDataForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  <#Description#>
 *
 *  @param tableView <#tableView description#>
 *  @param cell      <#cell description#>
 *  @param indexPath <#indexPath description#>
 */
- (void)tableView:(UITableView *)tableView willUpdateCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  空数据时显示view
 *
 *  @param content 空数据提示
 */
-(void) showEmptyDataTipsViewWithString:(NSString*) content btnStr:(NSString*)btnStr;
/**
 *  空数据时显示的自定义提示view
 */
-(UIView*) showEmptyDataCustomTipsView;
@end
