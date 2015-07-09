//
//  ShareVC.m
//  testGitDemo
//
//  Created by chanWenJay on 15/6/4.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "ShareVC.h"

@interface ShareVC ()
@property (nonatomic, strong) UIButton *weiboShareBtn;
@property (nonatomic, strong) UIButton *qqShareBtn;
@property (nonatomic, strong) UIButton *wechatShareBtn;
@end

@implementation ShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"分享";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20.0],NSFontAttributeName, nil];
    
    UIButton * leftNacBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNacBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftNacBtn setBackgroundImage:[UIImage imageNamed:@"left_nav_button"] forState:UIControlStateNormal];
    [leftNacBtn addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftNacBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    // Do any additional setup after loading the view.
    [self initShareUI];
}

- (void)backButtonPressed {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - init ui
- (void)initShareUI{
    self.weiboShareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.weiboShareBtn.titleLabel.font = Font(18.0);
    [self.weiboShareBtn setTitle:@"微博分享" forState:UIControlStateNormal];
    [self.weiboShareBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [self.weiboShareBtn setBackgroundColor:BlackColor];
    self.weiboShareBtn.frame = CGRectMake(100/2, 150, IPHONE_WIDTH - 100/2*2, 44);
    self.weiboShareBtn.layer.cornerRadius = 5;
    [self.weiboShareBtn.titleLabel setFont:Font(18.0)];
    self.weiboShareBtn.tag = 100;
    [self.weiboShareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.weiboShareBtn];
    
    self.wechatShareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.wechatShareBtn.titleLabel.font = Font(18.0);
    [self.wechatShareBtn setTitle:@"微信分享" forState:UIControlStateNormal];
    [self.wechatShareBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [self.wechatShareBtn setBackgroundColor:default_blue_color];
    self.wechatShareBtn.frame = CGRectMake(100/2, CGRectGetMaxY(self.weiboShareBtn.frame) +20, IPHONE_WIDTH - 100/2*2, 44);
    self.wechatShareBtn.layer.cornerRadius = 5;
    [self.wechatShareBtn.titleLabel setFont:Font(18.0)];
    self.wechatShareBtn.tag = 101;
    [self.wechatShareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.wechatShareBtn];
    
    self.qqShareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.qqShareBtn.titleLabel.font = Font(18.0);
    [self.qqShareBtn setTitle:@"QQ分享" forState:UIControlStateNormal];
    [self.qqShareBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [self.qqShareBtn setBackgroundColor:RGB_B(78, 207, 58)];
    self.qqShareBtn.frame = CGRectMake(100/2, CGRectGetMaxY(self.wechatShareBtn.frame)+20, IPHONE_WIDTH - 100/2*2, 44);
    self.qqShareBtn.layer.cornerRadius = 5;
    self.qqShareBtn.tag = 102;
    [self.qqShareBtn.titleLabel setFont:Font(18.0)];
    [self.qqShareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.qqShareBtn];
}
#pragma mark - action
- (void)shareAction:(UIButton *)sender{
    NSString *shareStr = nil;
    switch (sender.tag) {
        case 100:
            shareStr = @"微博分享成功";
            break;
            
        case 101:
            shareStr = @"微信分享成功";
            break;
            
        case 102:
            shareStr = @"QQ分享成功";
            break;
        default:
            break;
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:shareStr delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
    [alert show];
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
