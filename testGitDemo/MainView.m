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
#import "VideoPlayerVC.h"
#import "QRCodeViewController.h"

@interface MainView () <UIAlertViewDelegate> {

    
}

@end

@implementation MainView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
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
    
    freeWashBtn.frame = CGRectMake(100/2, 140, IPHONE_WIDTH - 100/2*2, 44);
    freeWashBtn.backgroundColor = BlackColor;
    [freeWashBtn setTitle:@"免费洗车" forState:UIControlStateNormal];
    [freeWashBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    freeWashBtn.layer.cornerRadius = 5;
    freeWashBtn.clipsToBounds = YES;
    [self.view addSubview:freeWashBtn];
    freeWashBtn.tag = 100;
    [freeWashBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *payWashBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    payWashBtn.frame = CGRectMake(100/2, CGRectGetMaxY(freeWashBtn.frame) +30, IPHONE_WIDTH - 100/2*2, 44);
    payWashBtn.backgroundColor = default_blue_color;
    payWashBtn.layer.cornerRadius = 5;
    payWashBtn.clipsToBounds = YES;
    [payWashBtn setTitle:@"付费洗车" forState:UIControlStateNormal];
    [payWashBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:payWashBtn];
    payWashBtn.tag = 101;
    [payWashBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *QRBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    QRBtn.layer.cornerRadius = 5;
    QRBtn.clipsToBounds = YES;
    QRBtn.frame = CGRectMake(100/2, CGRectGetMaxY(payWashBtn.frame) +30, IPHONE_WIDTH - 100/2*2, 44);
    QRBtn.backgroundColor = RGB_B(78, 207, 58);
    [QRBtn setTitle:@"二维码图标" forState:UIControlStateNormal];
    [QRBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:QRBtn];
    QRBtn.tag = 102;
    [QRBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnAction:(UIButton *)sender {
    if (sender.tag == 100) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您接下来需要观看100秒视频，建议您在WIFI环境下打开" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        alert.tag = 10086;
        [alert show];
        
    } else if (sender.tag == 101) {
        
    } else if (sender.tag == 102) {
        QRCodeViewController *qrVC = [[QRCodeViewController alloc]initWithNibName:@"QRCodeViewController" bundle:nil];
        [self.navigationController pushViewController:qrVC animated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10086) {
        if (buttonIndex == 1) {
            VideoPlayerVC *videoPlayer = [[VideoPlayerVC alloc] init];
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:videoPlayer];
            [self presentViewController:videoPlayer animated:YES completion:^{
                
            }];
        }
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
