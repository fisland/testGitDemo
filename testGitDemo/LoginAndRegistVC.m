//
//  LoginAndRegistVC.m
//  testGitDemo
//
//  Created by 张炯枫 on 15/6/4.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "LoginAndRegistVC.h"
#import "LoginVC.h"
#import "RegistVC.h"
@interface LoginAndRegistVC ()

@end

@implementation LoginAndRegistVC
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - init ui
- (void)initUI{
    

    self.view.backgroundColor = ClearColor;
    self.navigationController.navigationBarHidden = YES;
    UIImageView *bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGTH )];
    bgImgView.userInteractionEnabled = YES;
    bgImgView.image = [UIImage imageNamed:@"Balloon"];
    bgImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:bgImgView];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, IPHONE_HEIGTH - 64 , 100, 40)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = Font(14);
    loginBtn.backgroundColor = default_blue_color;
    [loginBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    loginBtn.layer.borderWidth = 1.0;
    loginBtn.layer.cornerRadius = 5.0;
    loginBtn.layer.borderColor = WhiteColor.CGColor;
    loginBtn.center = CGPointMake(IPHONE_WIDTH/4, loginBtn.center.y);
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [bgImgView addSubview:loginBtn];
    
    UIButton *registBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(loginBtn.frame) +30, loginBtn.frame.origin.y, 100, 40)];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    registBtn.titleLabel.font = Font(14);
    registBtn.backgroundColor = WhiteColor;
    [registBtn setTitleColor:default_blue_color forState:UIControlStateNormal];
    registBtn.layer.borderWidth = 1.0;
    registBtn.layer.cornerRadius = 5.0;
    registBtn.center = CGPointMake(IPHONE_WIDTH/4 + IPHONE_WIDTH /2, registBtn.center.y);
    registBtn.layer.borderColor = default_blue_color.CGColor;
    [registBtn addTarget:self action:@selector(registAction) forControlEvents:UIControlEventTouchUpInside];
    [bgImgView addSubview:registBtn];
}
#pragma mark - action
- (void)loginAction{
    LoginVC *vc = [[LoginVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)registAction{
    RegistVC *vc = [[RegistVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
@end
