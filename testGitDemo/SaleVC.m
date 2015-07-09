//
//  SaleVC.m
//  testGitDemo
//
//  Created by chanWenJay on 15/6/4.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "SaleVC.h"

@interface SaleVC ()

@end

@implementation SaleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"优惠";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20.0],NSFontAttributeName, nil];
    
    UIButton * leftNacBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNacBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftNacBtn setBackgroundImage:[UIImage imageNamed:@"left_nav_button"] forState:UIControlStateNormal];
    [leftNacBtn addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftNacBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    // Do any additional setup after loading the view.
    [self initSaleUI];
}

- (void)backButtonPressed {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSaleUI{
    UIImageView *cardImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64+50, 170, 100)];
    cardImgView.center = CGPointMake(self.view.center.x, cardImgView.center.y);
    cardImgView.image = [UIImage imageNamed:@"black_envelope_reflected"];
    [self.view addSubview:cardImgView];
    
    UILabel *changeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(cardImgView.frame)+10, IPHONE_WIDTH, 20)];
    changeLabel.textColor = BlackColor;
    changeLabel.font = Font(16.0);
    changeLabel.textAlignment = NSTextAlignmentCenter;
    changeLabel.text = @"获得优惠洗车机会";
    [self.view addSubview:changeLabel];
    
    UILabel *detailChangeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(changeLabel.frame)+10, IPHONE_WIDTH - 30, 35)];
    detailChangeLabel.textColor = RGB_A(140);
    detailChangeLabel.font = Font(13);
    detailChangeLabel.numberOfLines = 2;
    detailChangeLabel.textAlignment = NSTextAlignmentCenter;
    detailChangeLabel.text = @"向朋友发送优惠洗车邀请，您也将获得优惠洗车机会，价值￥XX。";
    [self.view addSubview:detailChangeLabel];
    
    UILabel *couponLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(detailChangeLabel.frame)+40, IPHONE_WIDTH, 15)];
    couponLabel.text = @"发送您的优惠码";
    couponLabel.textAlignment = NSTextAlignmentCenter;
    couponLabel.textColor = RGB_A(202);
    couponLabel.font = Font(12);
    [self.view addSubview:couponLabel];
    
    UILabel *codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(couponLabel.frame)+5, IPHONE_WIDTH, 20)];
    codeLabel.text = @"UFK89isn";
    codeLabel.textAlignment = NSTextAlignmentCenter;
    codeLabel.textColor = BlackColor;
    codeLabel.font = Font(15);
    [self.view addSubview:codeLabel];
    
    UIButton *emailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    emailButton.titleLabel.font = Font(18.0);
    [emailButton setTitle:@"邮箱邀请" forState:UIControlStateNormal];
    [emailButton setTitleColor:WhiteColor forState:UIControlStateNormal];
    [emailButton setBackgroundColor:BlackColor];
    emailButton.frame = CGRectMake(100/2, CGRectGetMaxY(codeLabel.frame)+15, IPHONE_WIDTH - 100/2*2, 44);
    emailButton.layer.cornerRadius = 5;
    [emailButton.titleLabel setFont:Font(18.0)];
    emailButton.tag = 100;
    [emailButton addTarget:self action:@selector(inviteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:emailButton];
    
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.titleLabel.font = Font(18.0);
    [messageBtn setTitle:@"短信邀请" forState:UIControlStateNormal];
    [messageBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [messageBtn setBackgroundColor:default_blue_color];
    messageBtn.frame = CGRectMake(100/2, CGRectGetMaxY(emailButton.frame)+5, IPHONE_WIDTH - 100/2*2, 44);
    messageBtn.layer.cornerRadius = 5;
    [messageBtn.titleLabel setFont:Font(18.0)];
    messageBtn.tag = 101;
    [messageBtn addTarget:self action:@selector(inviteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:messageBtn];
    
    UIButton *socialBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    socialBtn.titleLabel.font = Font(18.0);
    [socialBtn setTitle:@"社交平台邀请" forState:UIControlStateNormal];
    [socialBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [socialBtn setBackgroundColor:RGB_B(78, 207, 58)];
    socialBtn.frame = CGRectMake(100/2, CGRectGetMaxY(messageBtn.frame)+5, IPHONE_WIDTH - 100/2*2, 44);
    socialBtn.layer.cornerRadius = 5;
    [socialBtn.titleLabel setFont:Font(18.0)];
    socialBtn.tag = 102;
    [socialBtn addTarget:self action:@selector(inviteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:socialBtn];
    
}
#pragma mark - action
- (void)inviteBtnAction:(UIButton *)sender{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提醒" message:@"邀请成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alert show];
}
@end
