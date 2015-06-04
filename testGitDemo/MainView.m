//
//  MainView.m
//  testGitDemo
//
//  Created by chanWenJay on 15/6/3.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "MainView.h"
#import "LeafMenuViewController.h"
#import "AppDelegate.h"

@interface MainView () {

    
}

@end

@implementation MainView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *openItem = [[UIBarButtonItem alloc] initWithTitle:@"Open" style:UIBarButtonItemStylePlain target:self action:@selector(openButtonPressed)];
    self.navigationItem.leftBarButtonItem = openItem;
    
    [self initButton];
    // Do any additional setup after loading the view.
}

- (void)openButtonPressed
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (!appDelegate.isLeftBarButtonClick) {
        [appDelegate openMenu];
    } else {
        [appDelegate closeMenu];
    }
//    [self.leafMenuViewController closeWithAnimation:YES];
}

- (void)initButton {
    UIButton *freeWashBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    freeWashBtn.frame = CGRectMake(self.view.frame.size.width/2-70, 140, 140, 40);
    freeWashBtn.backgroundColor = [UIColor redColor];
    [freeWashBtn setTitle:@"免费洗车" forState:UIControlStateNormal];
    [freeWashBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:freeWashBtn];
    freeWashBtn.tag = 100;
    [freeWashBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *payWashBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    payWashBtn.frame = CGRectMake(self.view.frame.size.width/2-70, 220, 140, 40);
    payWashBtn.backgroundColor = [UIColor redColor];
    [payWashBtn setTitle:@"付费洗车" forState:UIControlStateNormal];
    [payWashBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:payWashBtn];
    payWashBtn.tag = 101;
    [payWashBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *QRBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    QRBtn.frame = CGRectMake(self.view.frame.size.width/2-70, 300, 140, 40);
    QRBtn.backgroundColor = [UIColor redColor];
    [QRBtn setTitle:@"二维码图标" forState:UIControlStateNormal];
    [QRBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:QRBtn];
    QRBtn.tag = 102;
    [QRBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnAction:(UIButton *)sender {
    if (sender.tag == 100) {
        
    } else if (sender.tag == 101) {
        
    } else if (sender.tag == 102) {
        
    }
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
