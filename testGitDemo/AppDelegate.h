//
//  AppDelegate.h
//  testGitDemo
//
//  Created by 张炯枫 on 15/5/31.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeafMenuViewController.h"
#import "LoginAndRegistVC.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) LeafMenuViewController *leafMenu;
@property (nonatomic, assign) BOOL                   isLeftBarButtonClick;
@property (strong, nonatomic) UINavigationController *mainNav;

- (void)openMenu;
- (void)closeMenu;
- (void)setUpMenuUI;//切换主视图到menu
- (void)setupLoginRegistUI;//切换主视图到注册登录
@end

