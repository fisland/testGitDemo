//
//  ForgetVC.m
//  testGitDemo
//
//  Created by 张炯枫 on 15/7/9.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "ForgetVC.h"
#import "AppDelegate.h"
@implementation ForgetVC

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
    self.title = @"验证手机";
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = WhiteColor;
    
    UIView *nameView =[self createNormaelTextFieldView:@"手机号码" andPointY:50 andType:@""];
    [self.view addSubview:nameView];
    
    UIView *codeView =[self createNormaelTextFieldView:@"验证码" andPointY:105 andType:@"验证码"];
    [self.view addSubview:codeView];

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

- (void)gotoback{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)createNormaelTextFieldView:(NSString *)textType andPointY:(CGFloat)pointY andType:(NSString *)type
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake((IPHONE_WIDTH - 300)/2, pointY, 300, 45)];
    
    UIImageView *imgview = [[UIImageView alloc]initWithFrame:view.bounds];
    imgview.userInteractionEnabled = YES;
    
    [view addSubview:imgview];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 80, 30)];
    label.text = textType;
    label.font = Font(16);
    label.textColor = RGB_B(60, 160, 180);
    [view addSubview:label];
    
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(100, 8, 140, 30)];
    field.borderStyle = UITextBorderStyleNone;
    [view addSubview:field];
    if ([type isEqualToString:@"验证码"]) {
        imgview.image = [UIImage imageNamed:@"checkCode"];
        UILabel *codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(210, 8, 80, 30)];
        codeLabel.text = @"获取验证码";
        codeLabel.font = Font(16);
        codeLabel.textColor = WhiteColor;
        [view addSubview:codeLabel];
    }
    else{
        imgview.image = [UIImage imageNamed:@"normal_textfield"];
        
    }
    return view;
}

@end
