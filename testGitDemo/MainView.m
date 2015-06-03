//
//  MainView.m
//  testGitDemo
//
//  Created by chanWenJay on 15/6/3.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "MainView.h"
#import "LeafMenuViewController.h"
#import "WJMenuView.h"
#import "IndividualVC.h"
#import "PayVC.h"
#import "SaleVC.h"
#import "ShareVC.h"
#import "HelpVC.h"

@interface MainView () 

@property (nonatomic, strong) LeafMenuViewController *leafMenu;

@end

@implementation MainView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *openItem = [[UIBarButtonItem alloc] initWithTitle:@"Open" style:UIBarButtonItemStylePlain target:self action:@selector(openButtonPressed)];
    self.navigationItem.leftBarButtonItem = openItem;
    
    WJMenuView *menu = [[WJMenuView alloc] init];
    
    IndividualVC *indivadua = [[IndividualVC alloc] init];
    UINavigationController *IndivaduaNav = [[UINavigationController alloc] initWithRootViewController:indivadua];
    
    PayVC *pay = [[PayVC alloc] init];
    UINavigationController *payNav = [[UINavigationController alloc] initWithRootViewController:pay];
    
    SaleVC *sale = [[SaleVC alloc] init];
    UINavigationController *saleNav = [[UINavigationController alloc] initWithRootViewController:sale];
    
    ShareVC *share = [[ShareVC alloc] init];
    UINavigationController *shareNav = [[UINavigationController alloc] initWithRootViewController:share];
    
    HelpVC *help = [[HelpVC alloc] init];
    UINavigationController *helpNav = [[UINavigationController alloc] initWithRootViewController:help];
    
    self.leafMenu = [[LeafMenuViewController alloc] initWithLeftVC:menu centerVCs:@[IndivaduaNav,payNav,saleNav,shareNav,helpNav]];
    
    self.leafMenu.shadow = YES;
    self.leafMenu.springAnimation = NO;
    
    [self presentViewController:self.leafMenu animated:NO completion:nil];
    
    // Do any additional setup after loading the view.
}

- (void)openButtonPressed
{
    [self.leafMenu openAtIndex:0 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
