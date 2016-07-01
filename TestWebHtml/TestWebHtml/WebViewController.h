//
//  WebViewController.h
//  TestWebHtml
//
//  Created by ysj on 15/12/29.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (nonatomic, copy) NSString *html;
@property (nonatomic, assign) BOOL isUseJS;
@end
