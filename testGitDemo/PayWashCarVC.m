//
//  PayWashCarVC.m
//  testGitDemo
//
//  Created by 张炯枫 on 15/6/10.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "PayWashCarVC.h"
#import "QRCodeViewController.h"

@implementation PayWashCarVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"付款";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20.0],NSFontAttributeName, nil];
    
    UIButton * leftNacBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNacBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftNacBtn setBackgroundImage:[UIImage imageNamed:@"left_nav_button"] forState:UIControlStateNormal];
    [leftNacBtn addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftNacBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
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
    NSArray *titleArray = @[@"支付宝支付",@"微信支付",@"银行卡支付"];
    NSInteger num = 1;
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, 100+150*i, 100, 100)];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"payBtn%ld.png",num++]];
        [self.view addSubview:imgView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imgView.frame.origin.x-40, CGRectGetMaxY(imgView.frame)+5, 180, 20)];
        titleLabel.text = titleArray[i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor colorWithRed:0 green:148/255.0f blue:170/255.0f alpha:1.0f];
        titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        [self.view addSubview:titleLabel];
        
        if (i == 2) {
            UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, CGRectGetMaxY(titleLabel.frame), titleLabel.frame.size.width, titleLabel.frame.size.height)];
            detailLabel.text = @"(目前仅支持银联支付)";
            detailLabel.textAlignment = NSTextAlignmentCenter;
            detailLabel.textColor = [UIColor colorWithRed:0 green:148/255.0f blue:170/255.0f alpha:1.0f];
            detailLabel.font = [UIFont systemFontOfSize:12.0f];
            [self.view addSubview:detailLabel];
        }
        
        UIControl *payControl = [[UIControl alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, imgView.frame.origin.y-10, titleLabel.frame.size.width, 150)];
        payControl.backgroundColor = [UIColor clearColor];
        payControl.tag = 200+i;
        [payControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:payControl];
    }
    
//    UIButton *zhifubaoBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    zhifubaoBtn.frame = CGRectMake(100/2, 140, IPHONE_WIDTH - 100/2*2, 44);
//    zhifubaoBtn.backgroundColor = BlackColor;
//    [zhifubaoBtn setTitle:@"支付宝支付" forState:UIControlStateNormal];
//    [zhifubaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    zhifubaoBtn.layer.cornerRadius = 5;
//    zhifubaoBtn.clipsToBounds = YES;
//    [self.view addSubview:zhifubaoBtn];
//    zhifubaoBtn.tag = 100;
//    [zhifubaoBtn addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton *wechatPayBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    wechatPayBtn.frame = CGRectMake(100/2, CGRectGetMaxY(zhifubaoBtn.frame) +30, IPHONE_WIDTH - 100/2*2, 44);
//    wechatPayBtn.backgroundColor = default_blue_color;
//    wechatPayBtn.layer.cornerRadius = 5;
//    wechatPayBtn.clipsToBounds = YES;
//    [wechatPayBtn setTitle:@"微信支付" forState:UIControlStateNormal];
//    [wechatPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.view addSubview:wechatPayBtn];
//    wechatPayBtn.tag = 101;
//    [wechatPayBtn addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton *bankBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    bankBtn.layer.cornerRadius = 5;
//    bankBtn.clipsToBounds = YES;
//    bankBtn.frame = CGRectMake(100/2, CGRectGetMaxY(wechatPayBtn.frame) +30, IPHONE_WIDTH - 100/2*2, 44);
//    bankBtn.backgroundColor = RGB_B(78, 207, 58);
//    [bankBtn setTitle:@"银联卡支付" forState:UIControlStateNormal];
//    [bankBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.view addSubview:bankBtn];
//    bankBtn.tag = 102;
//    [bankBtn addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - action
- (void)payBtnAction:(UIButton *)sender{
    if (sender.tag == 100) {
        QRCodeViewController *qrVC = [[QRCodeViewController alloc]initWithNibName:@"QRCodeViewController" bundle:nil];
        [self.navigationController pushViewController:qrVC animated:YES];
    } else if (sender.tag == 101) {
        QRCodeViewController *qrVC = [[QRCodeViewController alloc]initWithNibName:@"QRCodeViewController" bundle:nil];
        [self.navigationController pushViewController:qrVC animated:YES];
    } else if (sender.tag == 102) {
        QRCodeViewController *qrVC = [[QRCodeViewController alloc]initWithNibName:@"QRCodeViewController" bundle:nil];
        [self.navigationController pushViewController:qrVC animated:YES];
    }
}

- (void)controlAction:(UIControl *)sender {
    if (sender.tag == 200) {
        QRCodeViewController *qrVC = [[QRCodeViewController alloc]initWithNibName:@"QRCodeViewController" bundle:nil];
        [self.navigationController pushViewController:qrVC animated:YES];
    } else if (sender.tag == 201) {
        QRCodeViewController *qrVC = [[QRCodeViewController alloc]initWithNibName:@"QRCodeViewController" bundle:nil];
        [self.navigationController pushViewController:qrVC animated:YES];
    } else if (sender.tag == 202) {
        QRCodeViewController *qrVC = [[QRCodeViewController alloc]initWithNibName:@"QRCodeViewController" bundle:nil];
        [self.navigationController pushViewController:qrVC animated:YES];
    }
}

@end
