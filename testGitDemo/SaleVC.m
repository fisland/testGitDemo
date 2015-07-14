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
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSaleUI{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"nav_bg" ofType:@"png"]] forBarMetrics:UIBarMetricsDefault];
    
    UIButton * leftNacBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNacBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftNacBtn setBackgroundImage:[UIImage imageNamed:@"left_nav_button"] forState:UIControlStateNormal];
    [leftNacBtn addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftNacBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIImageView *cardImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 120, 120)];
    cardImgView.center = CGPointMake(self.view.center.x, cardImgView.center.y);
    cardImgView.image = [UIImage imageNamed:@"washCarQRCode"];
    [self.view addSubview:cardImgView];
    
    
    UILabel *detailChangeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(cardImgView.frame), IPHONE_WIDTH - 30, 35)];
    detailChangeLabel.textColor = RGB_B(60, 160, 180);
    detailChangeLabel.font = Font(14);
    detailChangeLabel.numberOfLines = 2;
    detailChangeLabel.textAlignment = NSTextAlignmentCenter;
    detailChangeLabel.text = @"向朋友发送免费洗车邀请，您也将获得优惠洗车机会";
    [self.view addSubview:detailChangeLabel];

    NSArray *imgArr = [NSArray arrayWithObjects:@"invist_mail", @"invist_message",@"invist_social",nil];
    NSArray *nameArr = [NSArray arrayWithObjects:@"邮箱邀请", @"短信邀请",@"社交平台邀请",nil];
    for (NSInteger i = 0;i<3; i ++) {
        CGRect imgRect = CGRectMake(80 + i*90, CGRectGetMaxY(detailChangeLabel.frame)+20, 80 , 80);
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:imgRect];
        imgView.image = [UIImage imageNamed:imgArr[i]];
        [self.view addSubview:imgView];
        
        
        CGRect nameRect = CGRectMake(75 + i*90 , CGRectGetMaxY(imgView.frame)+10,90 , 30);
        UILabel *label = [[UILabel alloc]initWithFrame:nameRect];
        label.text = nameArr[i];
        label.font = Font(14);
        label.textColor = RGB_B(60, 160, 180);
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
    }
    
//    UIButton *emailButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    emailButton.titleLabel.font = Font(18.0);
//    [emailButton setTitle:@"邮箱邀请" forState:UIControlStateNormal];
//    [emailButton setTitleColor:WhiteColor forState:UIControlStateNormal];
//    [emailButton setBackgroundColor:BlackColor];
//    emailButton.frame = CGRectMake(100/2, CGRectGetMaxY(detailChangeLabel.frame)+15, IPHONE_WIDTH - 100/2*2, 44);
//    emailButton.layer.cornerRadius = 5;
//    [emailButton.titleLabel setFont:Font(18.0)];
//    emailButton.tag = 100;
//    [emailButton addTarget:self action:@selector(inviteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:emailButton];
//    
//    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    messageBtn.titleLabel.font = Font(18.0);
//    [messageBtn setTitle:@"短信邀请" forState:UIControlStateNormal];
//    [messageBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
//    [messageBtn setBackgroundColor:default_blue_color];
//    messageBtn.frame = CGRectMake(100/2, CGRectGetMaxY(emailButton.frame)+5, IPHONE_WIDTH - 100/2*2, 44);
//    messageBtn.layer.cornerRadius = 5;
//    [messageBtn.titleLabel setFont:Font(18.0)];
//    messageBtn.tag = 101;
//    [messageBtn addTarget:self action:@selector(inviteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:messageBtn];
//    
//    UIButton *socialBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    socialBtn.titleLabel.font = Font(18.0);
//    [socialBtn setTitle:@"社交平台邀请" forState:UIControlStateNormal];
//    [socialBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
//    [socialBtn setBackgroundColor:RGB_B(78, 207, 58)];
//    socialBtn.frame = CGRectMake(100/2, CGRectGetMaxY(messageBtn.frame)+5, IPHONE_WIDTH - 100/2*2, 44);
//    socialBtn.layer.cornerRadius = 5;
//    [socialBtn.titleLabel setFont:Font(18.0)];
//    socialBtn.tag = 102;
//    [socialBtn addTarget:self action:@selector(inviteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:socialBtn];
    
}
#pragma mark - action
- (void)inviteBtnAction:(UIButton *)sender{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提醒" message:@"邀请成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alert show];
}
@end
