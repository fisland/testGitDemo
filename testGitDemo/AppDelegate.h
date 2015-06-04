//
//  AppDelegate.h
//  testGitDemo
//
//  Created by 张炯枫 on 15/5/31.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeafMenuViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) LeafMenuViewController *leafMenu;
@property (nonatomic, assign) BOOL                   isLeftBarButtonClick;

- (void)openMenu;

- (void)closeMenu;

@end

