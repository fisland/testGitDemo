//
//  AppDelegate.m
//  testGitDemo
//
//  Created by 张炯枫 on 15/5/31.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "AppDelegate.h"
#import "MainView.h"
#import "WJMenuView.h"
#import "MAAPIKey.h"
#import <MAMapKit/MAMapKit.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)configureAPIKey
{
    if ([APIKey length] == 0)
    {
        NSString *reason = [NSString stringWithFormat:@"apiKey为空，请检查key是否正确设置。"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:reason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    [MAMapServices sharedServices].apiKey = (NSString *)APIKey;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    NSString * currentUser = [userdefault objectForKey:CurrentLoginUser];
    [self configureAPIKey];
    if (currentUser == nil || [currentUser isEqualToString:@""]) {
        [self setupLoginRegistUI];
    }
    else
    {
        [self setUpMenuUI];
    }
    
    return YES;
}
- (void)setUpMenuUI{
    MainView *main = [[MainView alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:main];
    WJMenuView *menu = [[WJMenuView alloc] init];
    UINavigationController *menuNav = [[UINavigationController alloc] initWithRootViewController:menu];
    
    self.leafMenu = [[LeafMenuViewController alloc] initWithLeftVC:menuNav centerVCs:@[nav]];
    self.leafMenu.shadow = YES;
    self.leafMenu.springAnimation = NO;
    
    self.window.rootViewController = self.leafMenu;
}
- (void)setupLoginRegistUI{
    LoginAndRegistVC * loginRegistVC = [[LoginAndRegistVC alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:loginRegistVC];
    self.window.rootViewController = nav;
}
- (void)openMenu {
    [self.leafMenu closeWithAnimation:YES];
}

- (void)closeMenu {
    [self.leafMenu openAtIndex:0 animated:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
