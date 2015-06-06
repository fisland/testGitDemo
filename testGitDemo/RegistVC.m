//
//  RegistVC.m
//  testGitDemo
//
//  Created by 张炯枫 on 15/6/4.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "RegistVC.h"
#import "AppDelegate.h"
@interface RegistVC ()
@property (nonatomic ,strong) UITextField *nameTextField;
@property (nonatomic ,strong) UITextField *passwordTextField;
@property (nonatomic ,strong) UITextField *phoneTextField;
@property (nonatomic ,strong) UITextField *carNoTextField;
@property (nonatomic ,strong) UITextField *carTypeTextField;
@property (nonatomic ,strong) UIButton    *registBtn;
@end

@implementation RegistVC
@synthesize nameTextField, passwordTextField, phoneTextField, carNoTextField, carTypeTextField, registBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - init ui

- (void)initUI{
    self.title = @"注册";
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = WhiteColor;
    nameTextField=[[UITextField alloc] initWithFrame:CGRectMake(30/2, 90, IPHONE_WIDTH - 30/2*2, 30)];
    nameTextField.placeholder=@"姓名";
    nameTextField.keyboardType = UIKeyboardTypeEmailAddress;
    nameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;//取消首字母自动大写
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    //    self.usernameTextField.delegate = self;
    nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameTextField.font=Font(14.0);
    [self.view addSubview:self.nameTextField];
    
    phoneTextField=[[UITextField alloc] initWithFrame:CGRectMake(30/2, CGRectGetMaxY(nameTextField.frame) + 20, IPHONE_WIDTH - 30/2*2, 30)];
    phoneTextField.placeholder=@"手机号";
    phoneTextField.keyboardType = UIKeyboardTypeEmailAddress;
    phoneTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;//取消首字母自动大写
    phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    //    self.usernameTextField.delegate = self;
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.font=Font(14.0);
    [self.view addSubview:self.phoneTextField];
    
    carNoTextField=[[UITextField alloc] initWithFrame:CGRectMake(30/2, CGRectGetMaxY(phoneTextField.frame) + 20, IPHONE_WIDTH - 30/2*2, 30)];
    carNoTextField.placeholder=@"车牌号";
    carNoTextField.keyboardType = UIKeyboardTypeEmailAddress;
    carNoTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;//取消首字母自动大写
    carNoTextField.borderStyle = UITextBorderStyleRoundedRect;
    //    self.usernameTextField.delegate = self;
    carNoTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    carNoTextField.font=Font(14.0);
    [self.view addSubview:self.carNoTextField];
    
    carTypeTextField=[[UITextField alloc] initWithFrame:CGRectMake(30/2, CGRectGetMaxY(carNoTextField.frame) + 20, IPHONE_WIDTH - 30/2*2, 30)];
    carTypeTextField.placeholder=@"车型";
    carTypeTextField.keyboardType = UIKeyboardTypeEmailAddress;
    carTypeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;//取消首字母自动大写
    carTypeTextField.borderStyle = UITextBorderStyleRoundedRect;
    //    self.usernameTextField.delegate = self;
    carTypeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    carTypeTextField.font=Font(14.0);
    [self.view addSubview:self.carTypeTextField];
    
    self.passwordTextField=[[UITextField alloc] initWithFrame:CGRectMake(30/2,  CGRectGetMaxY(carTypeTextField.frame) + 20, IPHONE_WIDTH - 30/2*2, 30)];
    self.passwordTextField.placeholder=@"登录密码";
    self.passwordTextField.secureTextEntry=YES;
    self.passwordTextField.borderStyle=UITextBorderStyleRoundedRect;
    self.passwordTextField.secureTextEntry=YES;
    //    self.passwordTextField.delegate = self;
    self.passwordTextField.font=Font(14.0);
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.passwordTextField];
    
    registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.titleLabel.font = Font(18.0);
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [registBtn setBackgroundColor:default_blue_color];
    self.registBtn.frame = CGRectMake(30/2, CGRectGetMinY(self.passwordTextField.frame)+60, IPHONE_WIDTH - 30/2*2, 44);
    self.registBtn.layer.cornerRadius = 5;
    [self.registBtn.titleLabel setFont:Font(18.0)];
    [self.registBtn addTarget:self action:@selector(registAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registBtn];
}
#pragma mark - action
- (void)registAction{
    if (![[self judgeRegsitInfo]isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提醒" message:[self judgeRegsitInfo] delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        return;
    }
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:self.nameTextField.text forKey:CurrentLoginUser];
    
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    [appdelegate setUpMenuUI];
}

- (NSString *)judgeRegsitInfo{
    if ([nameTextField.text isEqualToString:@""]) {
        return @"姓名不能为空";
    }
    if ([phoneTextField.text isEqualToString:@""]) {
        return @"手机号不能为空";
    }
    if ([carNoTextField.text isEqualToString:@""]) {
        return @"车牌号不能为空";
    }
    if ([carTypeTextField.text isEqualToString:@""]) {
        return @"车型不能为空";
    }
    if ([passwordTextField.text isEqualToString:@""]) {
        return @"密码不能为空";
    }
    return @"";
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
