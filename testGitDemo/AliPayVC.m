//
//  AliPayVC.m
//  testGitDemo
//
//  Created by chanWenJay on 15/6/13.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "AliPayVC.h"
#import "Card.h"

@interface AliPayVC () {
    UITextField *textField;
}

@end

@implementation AliPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"支付宝";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20.0],NSFontAttributeName, nil];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightBtn.frame = CGRectMake(0, 0, 40, 20);
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(rightBarButtonClick)];
    self.navigationItem.rightBarButtonItem.customView = rightBtn;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    UIButton * leftNacBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNacBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftNacBtn setBackgroundImage:[UIImage imageNamed:@"left_nav_button"] forState:UIControlStateNormal];
    [leftNacBtn addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftNacBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChangeText) name:UITextFieldTextDidChangeNotification object:nil];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)backButtonPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarButtonClick {
    Card *card = [[Card alloc] init];
    card.num = textField.text;
    card.type = 1;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:card,@"card", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addCard" object:nil userInfo:dic];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)initUI {
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20+64, self.view.frame.size.width, 20)];
    label1.text = @"输入和您的支付宝账号关联的邮箱地址或者手机号";
    label1.font = [UIFont systemFontOfSize:12.0f];
    label1.textColor = [UIColor darkGrayColor];
    label1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label1];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, label1.frame.origin.y+label1.frame.size.height+10, self.view.frame.size.width-20, 40)];
    bgView.layer.borderWidth = 1.0f;
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderColor = [UIColor colorWithWhite:0.777f alpha:1.0f].CGColor;
    [self.view addSubview:bgView];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    label2.text = @"支付宝账户";
    label2.textColor = [UIColor darkGrayColor];
    label2.font = [UIFont systemFontOfSize:16.0f];
    [bgView addSubview:label2];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(label2.frame.origin.x+label2.frame.size.width+10, label2.frame.origin.y, bgView.frame.size.width-100, 20)];
    textField.placeholder = @"邮箱地址/手机号码";
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [bgView addSubview:textField];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, bgView.frame.origin.y+bgView.frame.size.height+10, self.view.frame.size.width, 20)];
    label3.textColor = [UIColor darkGrayColor];
    label3.font = [UIFont systemFontOfSize:10.0f];
    label3.text = @"         点击保存按键，表示我已经阅读并同意支付宝协议";
    [self.view addSubview:label3];
}

- (void)textFieldChangeText {
    if (textField.text.length >= 1) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else if (textField.text.length == 0){
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
