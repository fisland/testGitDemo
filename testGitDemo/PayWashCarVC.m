//
//  PayWashCarVC.m
//  testGitDemo
//
//  Created by 张炯枫 on 15/6/10.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "PayWashCarVC.h"

@implementation PayWashCarVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"付款";
    
    UIBarButtonItem *openItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
    self.navigationItem.leftBarButtonItem = openItem;
    [self initPayUI];
    // Do any additional setup after loading the view.
}

- (void)backButtonPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initPayUI{
    UIButton *zhifubaoBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    zhifubaoBtn.frame = CGRectMake(100/2, 140, IPHONE_WIDTH - 100/2*2, 44);
    zhifubaoBtn.backgroundColor = BlackColor;
    [zhifubaoBtn setTitle:@"支付宝支付" forState:UIControlStateNormal];
    [zhifubaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zhifubaoBtn.layer.cornerRadius = 5;
    zhifubaoBtn.clipsToBounds = YES;
    [self.view addSubview:zhifubaoBtn];
    zhifubaoBtn.tag = 100;
    [zhifubaoBtn addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *wechatPayBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    wechatPayBtn.frame = CGRectMake(100/2, CGRectGetMaxY(zhifubaoBtn.frame) +30, IPHONE_WIDTH - 100/2*2, 44);
    wechatPayBtn.backgroundColor = default_blue_color;
    wechatPayBtn.layer.cornerRadius = 5;
    wechatPayBtn.clipsToBounds = YES;
    [wechatPayBtn setTitle:@"微信支付" forState:UIControlStateNormal];
    [wechatPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:wechatPayBtn];
    wechatPayBtn.tag = 101;
    [wechatPayBtn addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *bankBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    bankBtn.layer.cornerRadius = 5;
    bankBtn.clipsToBounds = YES;
    bankBtn.frame = CGRectMake(100/2, CGRectGetMaxY(wechatPayBtn.frame) +30, IPHONE_WIDTH - 100/2*2, 44);
    bankBtn.backgroundColor = RGB_B(78, 207, 58);
    [bankBtn setTitle:@"银联卡支付" forState:UIControlStateNormal];
    [bankBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:bankBtn];
    bankBtn.tag = 102;
    [bankBtn addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - action
- (void)payBtnAction:(UIButton *)sender{
    
}
@end
