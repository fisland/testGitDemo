//
//  HelpVC.m
//  testGitDemo
//
//  Created by chanWenJay on 15/6/4.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "HelpVC.h"

@interface HelpVC ()

@end

@implementation HelpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"帮助";
    [self initHelpUI];
//    UIBarButtonItem *openItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
//    self.navigationItem.leftBarButtonItem = openItem;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backButtonPressed {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)initHelpUI{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"nav_bg" ofType:@"png"]] forBarMetrics:UIBarMetricsDefault];
    
    UIButton * leftNacBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNacBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftNacBtn setBackgroundImage:[UIImage imageNamed:@"left_nav_button"] forState:UIControlStateNormal];
    [leftNacBtn addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftNacBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    videoBtn.titleLabel.font = Font(18.0);
    [videoBtn setTitle:@"教学视频" forState:UIControlStateNormal];
    [videoBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
//    [videoBtn setBackgroundColor:default_blue_color];
    [videoBtn setBackgroundImage:[UIImage imageNamed:@"normal_button"] forState:UIControlStateNormal];
    videoBtn.frame = CGRectMake(100/2, 60, IPHONE_WIDTH - 100/2*2, 44);
    videoBtn.layer.cornerRadius = 5;
    [videoBtn.titleLabel setFont:Font(18.0)];
    videoBtn.tag = 100;
    [videoBtn addTarget:self action:@selector(helpActionClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:videoBtn];
    
    UIButton *question = [UIButton buttonWithType:UIButtonTypeCustom];
    question.titleLabel.font = Font(18.0);
    [question setTitle:@"常见问题" forState:UIControlStateNormal];
    [question setTitleColor:WhiteColor forState:UIControlStateNormal];
    [question setBackgroundImage:[UIImage imageNamed:@"normal_button"] forState:UIControlStateNormal];
    question.frame = CGRectMake(100/2, CGRectGetMaxY(videoBtn.frame) +30, IPHONE_WIDTH - 100/2*2, 44);
    question.layer.cornerRadius = 5;
    [question.titleLabel setFont:Font(18.0)];
    question.tag = 101;
    [question addTarget:self action:@selector(helpActionClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:question];
}

#pragma mark - action
- (void)helpActionClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:
            
            break;
            
        case 101:
            
            break;
        default:
            break;
    }
}


@end
