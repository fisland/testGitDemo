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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init ui
- (void)initNavButton
{
    UIButton * leftNacBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNacBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftNacBtn setBackgroundImage:[UIImage imageNamed:@"left_nav_button"] forState:UIControlStateNormal];
    [leftNacBtn addTarget:self action:@selector(gotoback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftNacBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton * rightNacBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNacBtn.frame = CGRectMake(0, 0, 30, 30);
    [rightNacBtn setBackgroundImage:[UIImage imageNamed:@"right_nav_button"] forState:UIControlStateNormal];
    [rightNacBtn addTarget:self action:@selector(registAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightNacBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)initUI{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"nav_bg" ofType:@"png"]] forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self initNavButton];
    self.title = @"个人资料";
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = WhiteColor;

    UIImageView *headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 100, 100 )];
    headerImgView.center = CGPointMake(self.view.center.x, headerImgView.center.y);
    headerImgView.image = [UIImage imageNamed:@"header"];
    headerImgView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:headerImgView];
    
    UIView *nameView =[self createNormaelTextFieldView:@"姓名" andPointY:CGRectGetMaxY(headerImgView.frame) + 20 andTextfield:nameTextField];
    [self.view addSubview:nameView];
    
    UIView *phoneView =[self createNormaelTextFieldView:@"车牌号" andPointY:CGRectGetMaxY(nameView.frame) + 10 andTextfield:phoneTextField];
    [self.view addSubview:phoneView];

    
    UIView *carNoView =[self createNormaelTextFieldView:@"品牌" andPointY:CGRectGetMaxY(phoneView.frame) + 10 andTextfield:carNoTextField];
    [self.view addSubview:carNoView];

    
    UIView *carTypeView =[self createNormaelTextFieldView:@"车型" andPointY:CGRectGetMaxY(carNoView.frame) + 10 andTextfield:carTypeTextField];
    [self.view addSubview:carTypeView];
    
    UIView *passwordView =[self createNormaelTextFieldView:@"密码" andPointY:CGRectGetMaxY(carTypeView.frame) + 10 andTextfield:self.passwordTextField];
    [self.view addSubview:passwordView];
//    
//    registBtn = [[UIButton alloc]initWithFrame:CGRectMake((IPHONE_WIDTH - 300)/2, CGRectGetMaxY(passwordView.frame)+25, 300, 40)];
//    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
//    [registBtn setBackgroundImage:[UIImage imageNamed:@"normal_button"] forState:UIControlStateNormal];
//    registBtn.titleLabel.font = Font(18);
//    [registBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
//    
//    [registBtn addTarget:self action:@selector(registAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:registBtn];
}
#pragma mark - action
- (void)registAction{
//    if (![[self judgeRegsitInfo]isEqualToString:@""]) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提醒" message:[self judgeRegsitInfo] delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
//        [alert show];
//        return;
//    }
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:@"企鹅" forKey:CurrentLoginUser];
    
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
- (void)gotoback{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - ui factory
- (UIView *)createNormaelTextFieldView:(NSString *)textType andPointY:(CGFloat)pointY andTextfield:(UITextField *)textfield
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake((IPHONE_WIDTH - 300)/2, pointY, 300, 45)];
    
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
    textfield = field;
    field.borderStyle = UITextBorderStyleNone;
    [view addSubview:field];
    
    return view;
}
@end
