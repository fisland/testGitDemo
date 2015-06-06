//
//  LoginVC.m
//  testGitDemo
//
//  Created by 张炯枫 on 15/6/4.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "LoginVC.h"
#import "AppDelegate.h"

@interface LoginVC ()
@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton    *loginBtn;
@end

@implementation LoginVC
@synthesize usernameTextField, passwordTextField, loginBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLoginUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - init ui
- (void)initLoginUI{
    //create account
    self.title = @"登录";
    
    self.navigationController.navigationBarHidden = NO;

    self.view.backgroundColor = WhiteColor;
    
    //phone number textfield
    self.usernameTextField=[[UITextField alloc] initWithFrame:CGRectMake(30/2, 90, IPHONE_WIDTH - 30/2*2, 30)];
    self.usernameTextField.placeholder=@"车牌号/手机号";
    self.usernameTextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.usernameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;//取消首字母自动大写
    self.usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
//    self.usernameTextField.delegate = self;
    self.usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.usernameTextField.font=Font(14.0);
    [self.view addSubview:self.usernameTextField];
    
    //validate code textfield
    self.passwordTextField=[[UITextField alloc] initWithFrame:CGRectMake(30/2, CGRectGetMaxY(usernameTextField.frame)+20, IPHONE_WIDTH - 30/2*2, 30)];
    self.passwordTextField.placeholder=@"登录密码";
    self.passwordTextField.secureTextEntry=YES;
    self.passwordTextField.borderStyle=UITextBorderStyleRoundedRect;
    self.passwordTextField.secureTextEntry=YES;
//    self.passwordTextField.delegate = self;
    self.passwordTextField.font=Font(14.0);
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.passwordTextField];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.titleLabel.font = Font(18.0);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:default_blue_color];
    self.loginBtn.frame = CGRectMake(30/2, CGRectGetMinY(self.passwordTextField.frame)+60, IPHONE_WIDTH - 30/2*2, 44);
    self.loginBtn.layer.cornerRadius = 5;
    [self.loginBtn.titleLabel setFont:Font(18.0)];
    [self.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
}
#pragma mark - action
- (void)loginAction{
    
    if (self.usernameTextField.text == nil ||[self.usernameTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"车牌号/手机号不能为空" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (self.passwordTextField.text == nil ||[self.passwordTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码不能为空" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
        return;
    }
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:self.usernameTextField.text forKey:CurrentLoginUser];
    
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    [appdelegate setUpMenuUI];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
