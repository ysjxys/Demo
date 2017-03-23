//
// Created by uss on 15/9/9.
// Copyright (c) 2015 TC. All rights reserved.
//

#import "BaseRefreshListTableViewController.h"
#include "EveryNoneView.h"

@implementation BaseRefreshListTableViewController {

}

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

-(void) checkShowEmptyDataTipsView:(BOOL)isSearch {
    if (isSearch) {
        [self checkShowEmptyDataTipsView];
    }
    else {
        [self.tableView setTableFooterView:[[UIView alloc] init]];
    }
}

- (NSString*) emptyDataBtnContent {
    return @"";
}
-(NSString*) emptyDataTipsContent {
    return nil;
}

@end
