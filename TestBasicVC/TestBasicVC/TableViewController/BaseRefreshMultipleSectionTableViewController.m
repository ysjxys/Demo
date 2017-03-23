//
//  BaseRefreshMultipleSectionTableViewController.m
//  magicbean
//
//  Created by Tiannan on 16/6/23.
//  Copyright © 2016年 TC. All rights reserved.
//

#import "BaseRefreshMultipleSectionTableViewController.h"
#include "EveryNoneView.h"

@interface BaseRefreshMultipleSectionTableViewController ()

@end

@implementation BaseRefreshMultipleSectionTableViewController

- (void)didRequestComplete:(id)data {
    _dataDictionary = data;
    [super didRequestComplete:data];
    [self checkShowEmptyDataTipsView];
}


- (id)tableView:(UITableView *)tableView cellDataForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = [_dataDictionary objectForKey:[self keyOfDataDictionaryForSection:indexPath.section]];
    return [array objectAtIndex:indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataDictionary.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_dataDictionary objectForKey:[self keyOfDataDictionaryForSection:section]] count];
}

- (id)keyOfDataDictionaryForSection:(NSInteger)section {
    return nil;
}

-(void) checkShowEmptyDataTipsView
{
    if( [_dataDictionary count] == 0 )
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
