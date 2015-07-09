//
//  LoginAndRegistVC.m
//  testGitDemo
//
//  Created by 张炯枫 on 15/6/4.
//  Copyright (c) 2015年 fisland. All rights reserved.
//
#import "AppDelegate.h"
#import "LoginAndRegistVC.h"
#import "LoginVC.h"
#import "RegistVC.h"
#import "ForgetVC.h"
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
    bgImgView.image = [UIImage imageNamed:@"login_regist_backimage"];
    bgImgView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:bgImgView];
    
    UIImageView *headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 100, 100 )];
    headerImgView.center = CGPointMake(self.view.center.x, headerImgView.center.y);
    headerImgView.image = [UIImage imageNamed:@"header"];
    headerImgView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:headerImgView];
    
    UIView *nameView = [self createNormaelTextFieldView:@"手机" andPoint:CGPointMake(0, CGRectGetMaxY(headerImgView.frame)+20) andIsSecure:NO];
    [self.view addSubview:nameView];
    
    UIView *passwordView = [self createNormaelTextFieldView:@"密码" andPoint:CGPointMake(0, CGRectGetMaxY(nameView.frame)+10) andIsSecure :YES];
    [self.view addSubview:passwordView];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake((IPHONE_WIDTH - 300)/2, CGRectGetMaxY(passwordView.frame)+10, 300, 40)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"normal_button"] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = Font(18);
    [loginBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [bgImgView addSubview:loginBtn];
    
    UIButton *forgetBtn = [[UIButton alloc]initWithFrame:CGRectMake(270, CGRectGetMaxY(loginBtn.frame), 100, 40)];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = Font(16);
    [forgetBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    [bgImgView addSubview:forgetBtn];
    
    UIButton *registBtn = [[UIButton alloc]initWithFrame:CGRectMake((IPHONE_WIDTH - 300)/2, CGRectGetMaxY(forgetBtn.frame)+25, 300, 40)];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"normal_button"] forState:UIControlStateNormal];
    registBtn.titleLabel.font = Font(18);
    [registBtn setTitleColor:WhiteColor forState:UIControlStateNormal];

    [registBtn addTarget:self action:@selector(forgetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    [bgImgView addSubview:registBtn];
}
#pragma mark - action
- (void)loginAction{
//    
//    if (self.usernameTextField.text == nil ||[self.usernameTextField.text isEqualToString:@""]) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"车牌号/手机号不能为空" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
//    
//    if (self.passwordTextField.text == nil ||[self.passwordTextField.text isEqualToString:@""]) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码不能为空" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:@"企鹅" forKey:CurrentLoginUser];
    
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    [appdelegate setUpMenuUI];
}
- (void)forgetPasswordAction{
    ForgetVC *vc = [[ForgetVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)registAction{
    RegistVC *vc = [[RegistVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)createNormaelTextFieldView:(NSString *)textType andPoint:(CGPoint)point andIsSecure:(BOOL)secure
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake((IPHONE_WIDTH - 300)/2, point.y, 300, 45)];
    
    UIImageView *imgview = [[UIImageView alloc]initWithFrame:view.bounds];
    imgview.userInteractionEnabled = YES;
    imgview.image = [UIImage imageNamed:@"normal_textfield"];
    [view addSubview:imgview];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 50, 30)];
    label.text = textType;
    label.font = Font(16);
    label.textColor = RGB_B(60, 160, 180);
    [view addSubview:label];
    
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(60, 8, 140, 30)];
    field.borderStyle = UITextBorderStyleNone;
    if (secure) {
        field.secureTextEntry = YES;
    }
    [view addSubview:field];
    
    return view;
}
@end
