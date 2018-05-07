//
//  AppDelegate.h
//  TestJsonModel
//
//  Created by ysj on 2018/4/20.
//  Copyright © 2018年 ysj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

