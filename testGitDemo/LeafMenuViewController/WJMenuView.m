//
//  WJMenuView.m
//  testGitDemo
//
//  Created by chanWenJay on 15/6/3.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "WJMenuView.h"
#import "IndividualVC.h"
#import "PayBindVC.h"
#import "SaleVC.h"
#import "ShareVC.h"
#import "HelpVC.h"

@interface WJMenuView ()
{
    UITableView * leftTableView;
    NSArray * names;
    NSArray * imgNames;
    NSInteger currentRow;
    
    UIImageView *imgView;
}

@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation WJMenuView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    [self initUI];
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateData) name:@"updateData" object:nil];
    // Do any additional setup after loading the view.
}

- (void)initUI {
    UIImageView *bgImageView =[[UIImageView alloc] initWithFrame:self.view.frame];
    bgImageView.image = [UIImage imageNamed:@"cela_bg"];
    [self.view addSubview:bgImageView];
    
    imgView = [[UIImageView alloc]initWithFrame:CGRectMake(90, 60, 80, 80)];
    imgView.layer.cornerRadius = 20;
    imgView.clipsToBounds = YES;
    imgView.image = [UIImage imageWithContentsOfFile:self.user.headerPath];
    [self.view addSubview:imgView];
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 150, 80, 20)];
    nameLabel.text = @"个人资料";
    nameLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:nameLabel];
    
    UIControl *infoControl = [[UIControl alloc] initWithFrame:CGRectMake(70, 45, 120, 140)];
    infoControl.tag = 100;
    [infoControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:infoControl];
    
    UIView *lineView =[[UIView alloc] initWithFrame:CGRectMake(40, 200, 170, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.5f];
    [self.view addSubview:lineView];
    
    UIImageView *payImageView = [[UIImageView alloc] initWithFrame:CGRectMake(90, 250, 30, 25)];
    payImageView.image = [UIImage imageNamed:@"pay_icon"];
    [self.view addSubview:payImageView];
    UILabel *payLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 247, 50, 30)];
    payLabel.text = @"付款";
    payLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    payLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:payLabel];
    UIControl *payControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 235, 320, 60)];
    payControl.tag = 101;
    [payControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payControl];
    
    UIImageView *saleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(90, 310, 30, 25)];
    saleImageView.image = [UIImage imageNamed:@"sale_icon"];
    [self.view addSubview:saleImageView];
    UILabel *saleLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 307, 50, 30)];
    saleLabel.text = @"优惠";
    saleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    saleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:saleLabel];
    UIControl *saleControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 295, 320, 60)];
    saleControl.tag = 102;
    [saleControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saleControl];
    
    UIImageView *shareImageView = [[UIImageView alloc] initWithFrame:CGRectMake(90, 370, 30, 25)];
    shareImageView.image = [UIImage imageNamed:@"share_icon"];
    [self.view addSubview:shareImageView];
    UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 367, 50, 30)];
    shareLabel.text = @"分享";
    shareLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    shareLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:shareLabel];
    UIControl *shareControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 355, 320, 60)];
    shareControl.tag = 103;
    [shareControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareControl];
    
    UIImageView *helpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(90, 430, 30, 25)];
    helpImageView.image = [UIImage imageNamed:@"help_icon"];
    [self.view addSubview:helpImageView];
    UILabel *helpLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 427, 50, 30)];
    helpLabel.text = @"帮助";
    helpLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    helpLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:helpLabel];
    UIControl *helpControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 415, 320, 60)];
    helpControl.tag = 104;
    [helpControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:helpControl];
}

- (void)controlAction:(UIControl *)sender {
    if (sender.tag == 100) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        IndividualVC *individualVC = [story instantiateViewControllerWithIdentifier:@"Individual"];
        individualVC.user = self.user;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:individualVC];
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"nav_bg" ofType:@"png"]] forBarMetrics:UIBarMetricsDefault];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    } else if (sender.tag == 101) {
        PayBindVC *payVC = [[PayBindVC alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:payVC];
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"nav_bg" ofType:@"png"]] forBarMetrics:UIBarMetricsDefault];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    } else if (sender.tag == 102) {
        SaleVC *saleVC = [[SaleVC alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:saleVC];
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"nav_bg" ofType:@"png"]] forBarMetrics:UIBarMetricsDefault];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    } else if (sender.tag == 103) {
        ShareVC *shareVC = [[ShareVC alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:shareVC];
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"nav_bg" ofType:@"png"]] forBarMetrics:UIBarMetricsDefault];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    } else if (sender.tag == 104) {
        HelpVC *helpVC = [[HelpVC alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:helpVC];
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"nav_bg" ofType:@"png"]] forBarMetrics:UIBarMetricsDefault];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
}

-(void)loadData
{
    names = @[@"个人资料",@"付款",@"优惠",@"分享",@"帮助"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)updateData {
    imgView.image = [UIImage imageWithContentsOfFile:self.user.headerPath];
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
