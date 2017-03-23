//
// Created by yaowang on 16/3/30.
// Copyright (c) 2016 TC. All rights reserved.
//

#import "BaseRefreshPageCollectionViewController.h"
#import "UIViewController+LoadMoreViewController.h"


@implementation BaseRefreshPageCollectionViewController {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setupLoadMore];
}


- (void)didRequest {
    if( [self isLoadData] ) {
        [self setIsLoadData:NO];
        _pageIndex = 1;
        [self setIsLoadMoreError:NO];
        [self setIsLoadMore:YES];
        [self didRequest:_pageIndex];
    }
}

- (void)didRequest:(NSInteger)pageIndex {
    
}

- (void)didStartLoadMore {
    ++_pageIndex;
    [self didRequest:_pageIndex];
}



- (void)didRequestError:(NSError *)error {
    if (!(_pageIndex == 1) ) {
        --_pageIndex;
        [self errorLoadMore];
    }
    [self setIsLoadData:YES];
    [super didRequestError:error];
}

- (void)didRequestComplete:(id)data {
    
    NSInteger count = [data count];
    if (_pageIndex == 1) {
        _dataArray = [[NSMutableArray alloc] initWithArray:data];
        [self endRefreshing];
    }
    else
    {
        if ( count > 0  ) {
            [self performSelector:@selector(endLoadMore) withObject:nil afterDelay:0.5];
            [_dataArray addObjectsFromArray:data];
            
        }
        else {
            [self performSelector:@selector(notLoadMore) withObject:nil afterDelay:0.5];
        }
    }
    [super didRequestComplete:_dataArray];
    [self setIsLoadData:YES];
}


- (void) dealloc {
    [self removeLoadMore];
}
@end
