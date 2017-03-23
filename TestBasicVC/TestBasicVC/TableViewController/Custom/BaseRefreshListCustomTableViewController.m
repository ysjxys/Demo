//
//  BaseRefreshListCustomTableViewController.m
//  mgame648
//
//  Created by yaowang on 15/12/2.
//  Copyright (c) 2015年 TC. All rights reserved.
//

#import "BaseRefreshListCustomTableViewController.h"
#import "EveryNoneView.h"
@implementation BaseRefreshListCustomTableViewController

- (void)didRequestComplete:(id)data {
    _dataArray = data;
    [super didRequestComplete:data];
    [self checkShowEmptyDataTipsView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}


- (id)tableView:(UITableView *)tableView cellDataForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_dataArray objectAtIndex:indexPath.row];
}

-(void) checkShowEmptyDataTipsView
{
    if( [_dataArray count] == 0 )
    {
        [self showEmptyDataTipsViewWithString:[self emptyDataTipsContent] btnStr:[self emptyDataBtnContent]];
    }
    else if([self.tableView.tableFooterView isKindOfClass:[EveryNoneView class]])
    {
        [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    }
}

- (NSString*) emptyDataBtnContent {
    return @"";
}


-(UIView*) showEmptyDataCustomTipsView {
    return nil;
}

-(NSString*) emptyDataTipsContent
{
    return nil;
}

-(void) showEmptyDataTipsViewWithString:(NSString*) content btnStr:(NSString*)btnStr
{
    UIView *view = [self showEmptyDataCustomTipsView];
    if ( view != nil ) {
        [self.tableView setTableFooterView:view];
    }
    else if ( content != nil)
    {
        [self.tableView setTableFooterView:[EveryNoneView everyNoneViewWith:content btnStr:btnStr myDelegate:self]];
    }
}

@end
