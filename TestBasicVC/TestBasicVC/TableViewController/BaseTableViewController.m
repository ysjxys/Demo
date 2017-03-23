
//
//  BaseTableViewController.m
//  douniwan
//
//  Created by uss on 15/9/1.
//  Copyright (c) 2015年 TC. All rights reserved.
//

#import "BaseTableViewController.h"
#import "EveryNoneView.h"
#import "UIViewController+Category.h"

@implementation BaseTableViewController
-(void) viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = kAppBackgroundColor;
    if ( [self.tableView tableFooterView] == nil ) {
        UIView *view = [UIView new];
        [self.tableView setTableFooterView:view];
        view.backgroundColor = [UIColor clearColor];
    }
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeMBProgressHUD];
}


- (NSString *)tableView:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *identifier = nil;
//    if (identifier == nil) {
//        identifier = [NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"Controller" withString:@"Cell"];
//    }
//    return identifier;
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [self tableView:tableView cellIdentifierForRowAtIndexPath:indexPath];
    if ( cellIdentifier ) {
        Class<OEZTableViewCellProtocol> viewClass = NSClassFromString(cellIdentifier);
        if ( [viewClass respondsToSelector:@selector(calculateHeightWithData:)]) {
            return [viewClass calculateHeightWithData:[self tableView:tableView cellDataForRowAtIndexPath:indexPath]];
        }
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor clearColor];
}

- (id)tableView:(UITableView *)tableView cellDataForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [self tableView:tableView cellIdentifierForRowAtIndexPath:indexPath];
    UITableViewCell *cell = nil;
    if (identifier != nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    }
    else {
       cell =  [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    if ([cell conformsToProtocol:@protocol(OEZUpdateProtocol)]) {
        [self tableView:tableView willUpdateCell:cell forRowAtIndexPath:indexPath];
        id data = [self tableView:tableView cellDataForRowAtIndexPath:indexPath];
        [(id <OEZUpdateProtocol>) cell update:data];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willUpdateCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait ;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
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

- (UIView*)showEmptyDataCustomTipsView {
    return nil;
}

@end
