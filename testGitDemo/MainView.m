//
//  MainView.m
//  testGitDemo
//
//  Created by chanWenJay on 15/6/3.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "MainView.h"
#import "LeafMenuViewController.h"
#import "AppDelegate.h"
#import "VideoPlayerVC.h"
#import "QRCodeViewController.h"
#import "PayWashCarVC.h"
#import "User.h"

@interface MainView () <UIAlertViewDelegate> {
    UIView  *freeWashBgView;
    UIImageView *freeWashView;
    UILabel *freeWashLabel;
    UIButton *freeWashYesBtn;
    UIButton *freeWashNoBtn;
    
    UIView *vedioBgView;
    UIImageView *vedioView;
    UILabel *vedioTitleLabel;
    UIButton *vedioContinueBtn;
    UIButton *vedioBackBtn;
    UIButton *vedioAwokeBtn;
    UILabel *vedioAwokeLabel;
    UIControl *vedioControl;
    
}

@end

@implementation MainView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"企 鹅 洗 车";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20.0],NSFontAttributeName, nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UIBarButtonItem *openItem = [[UIBarButtonItem alloc] initWithTitle:@"Open" style:UIBarButtonItemStylePlain target:self action:@selector(openButtonPressed)];
    UIButton *leftMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftMenuBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftMenuBtn addTarget:self action:@selector(openButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [leftMenuBtn setBackgroundImage:[UIImage imageNamed:@"nav_list"] forState:UIControlStateNormal];
    UIBarButtonItem *leftMenuBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftMenuBtn];
    self.navigationItem.leftBarButtonItem = leftMenuBarButton;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"nav_bg" ofType:@"png"]] forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self initButton];
    [self initCustomAlertView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRightAnswer:) name:@"rightAnswer" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToPayWashVC:) name:@"goToPayWashVC" object:nil];
    // Do any additional setup after loading the view.
}

- (void)initCustomAlertView {
    //check user qr
    freeWashBgView = [[UIView alloc] initWithFrame:CGRectMake(70, (self.view.frame.size.height-200)/2-64, self.view.frame.size.width-70*2, 200)];
    [self.view addSubview:freeWashBgView];
    
    freeWashView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, freeWashBgView.frame.size.width, freeWashBgView.frame.size.height)];
    freeWashView.image = [UIImage imageNamed:@"alert_bg.png"];
    [freeWashBgView addSubview:freeWashView];
    
    freeWashLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 10, freeWashView.frame.size.width-46, 90)];
    freeWashLabel.text = @"是否使用二维码免费洗车";
    freeWashLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    freeWashLabel.textAlignment = NSTextAlignmentCenter;
    freeWashLabel.textColor = [UIColor whiteColor];
    freeWashLabel.numberOfLines = 3;
    [freeWashBgView addSubview:freeWashLabel];
    
    freeWashYesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    freeWashYesBtn.frame = CGRectMake(30, freeWashLabel.frame.origin.y+freeWashLabel.frame.size.height,80, 80);
    [freeWashYesBtn setBackgroundImage:[UIImage imageNamed:@"YES button1"] forState:UIControlStateNormal];
    freeWashYesBtn.showsTouchWhenHighlighted = YES;
    freeWashYesBtn.tag = 200;
    [freeWashBgView addSubview:freeWashYesBtn];
    [freeWashYesBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    freeWashNoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    freeWashNoBtn.frame = CGRectMake(freeWashView.frame.size.width-30-freeWashYesBtn.frame.size.width, freeWashYesBtn.frame.origin.y,freeWashYesBtn.frame.size.width, freeWashYesBtn.frame.size.height);
    [freeWashNoBtn setBackgroundImage:[UIImage imageNamed:@"NO button1"] forState:UIControlStateNormal];
    freeWashNoBtn.showsTouchWhenHighlighted = YES;
    freeWashNoBtn.tag = 201;
    [freeWashBgView addSubview:freeWashNoBtn];
    [freeWashNoBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //vedio
    vedioBgView = [[UIView alloc] initWithFrame:CGRectMake(70, (self.view.frame.size.height-200)/2-64, self.view.frame.size.width-70*2, 200)];
    [self.view addSubview:vedioBgView];
    
    vedioView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, vedioBgView.frame.size.width, vedioBgView.frame.size.height)];
    vedioView.image = [UIImage imageNamed:@"alert_bg.png"];
    [vedioBgView addSubview:vedioView];
    
    vedioTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 10, freeWashView.frame.size.width-46, 90)];
    vedioTitleLabel.text = @"免费洗车您观看 15秒 视频并正确回答两道问题后使用(建议您再WIFI环境下打开)";
    vedioTitleLabel.font = [UIFont boldSystemFontOfSize:19.0f];
    vedioTitleLabel.textColor = [UIColor whiteColor];
    vedioTitleLabel.numberOfLines = 3;
    [vedioBgView addSubview:vedioTitleLabel];
    
    vedioContinueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    vedioContinueBtn.frame = CGRectMake(30, freeWashLabel.frame.origin.y+freeWashLabel.frame.size.height,80, 80);
    [vedioContinueBtn setBackgroundImage:[UIImage imageNamed:@"YES button2"] forState:UIControlStateNormal];
    vedioContinueBtn.showsTouchWhenHighlighted = YES;
    vedioContinueBtn.tag = 300;
    [vedioBgView addSubview:vedioContinueBtn];
    [vedioContinueBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    vedioBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    vedioBackBtn.frame = CGRectMake(freeWashView.frame.size.width-30-freeWashYesBtn.frame.size.width, freeWashYesBtn.frame.origin.y,freeWashYesBtn.frame.size.width, freeWashYesBtn.frame.size.height);
    [vedioBackBtn setBackgroundImage:[UIImage imageNamed:@"NO button2"] forState:UIControlStateNormal];
    vedioBackBtn.showsTouchWhenHighlighted = YES;
    vedioBackBtn.tag = 301;
    [vedioBgView addSubview:vedioBackBtn];
    [vedioBackBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    vedioAwokeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    vedioAwokeBtn.frame = CGRectMake(vedioContinueBtn.frame.origin.x+vedioContinueBtn.frame.size.width-5,
                                     vedioContinueBtn.frame.origin.y+vedioContinueBtn.frame.size.height-5,
                                     15,
                                     15);
    [vedioAwokeBtn setBackgroundImage:[UIImage imageNamed:@"awoke.png"] forState:UIControlStateNormal];
    [vedioAwokeBtn setBackgroundImage:[UIImage imageNamed:@"awoke_select.png"] forState:UIControlStateSelected];
    [vedioBgView addSubview:vedioAwokeBtn];
    
    vedioAwokeLabel = [[UILabel alloc] initWithFrame:CGRectMake(vedioAwokeBtn.frame.origin.x+vedioAwokeBtn.frame.size.width+5,
                                                                vedioAwokeBtn.frame.origin.y,
                                                                60,
                                                                15)];
    vedioAwokeLabel.text = @"不再提示";
    vedioAwokeLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    vedioAwokeLabel.textColor = [UIColor whiteColor];
    [vedioBgView addSubview:vedioAwokeLabel];
    
    vedioControl = [[UIControl alloc] initWithFrame:CGRectMake(vedioAwokeBtn.frame.origin.x,
                                                              vedioAwokeBtn.frame.origin.y,
                                                              vedioAwokeBtn.frame.size.width+vedioAwokeLabel.frame.size.width,
                                                              vedioAwokeBtn.frame.size.height+vedioAwokeLabel.frame.size.height)];
    vedioControl.tag = 302;
    [vedioControl addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [vedioBgView addSubview:vedioControl];
    
    vedioBgView.hidden = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)openButtonPressed
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (!appDelegate.isLeftBarButtonClick) {
        [appDelegate openMenu];
    } else {
        [appDelegate closeMenu];
    }
//    [self.leafMenuViewController closeWithAnimation:YES];
}

- (void)initButton {
    UIButton *freeWashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    freeWashBtn.frame = CGRectMake((IPHONE_WIDTH-140)/2, 50, 140, 140);
    [freeWashBtn setBackgroundImage:[UIImage imageNamed:@"main_btn1"] forState:UIControlStateNormal];
    freeWashBtn.showsTouchWhenHighlighted = YES;
    freeWashBtn.clipsToBounds = YES;
    [self.view addSubview:freeWashBtn];
    freeWashBtn.tag = 100;
    [freeWashBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *payWashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payWashBtn.frame = CGRectMake((IPHONE_WIDTH-140)/2, 230, 140, 140);
    [payWashBtn setBackgroundImage:[UIImage imageNamed:@"main_btn2"] forState:UIControlStateNormal];
    payWashBtn.showsTouchWhenHighlighted = YES;
    [self.view addSubview:payWashBtn];
    payWashBtn.tag = 101;
    [payWashBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *QRBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    QRBtn.clipsToBounds = YES;
    QRBtn.frame = CGRectMake((IPHONE_WIDTH-140)/2, 410, 140, 140);
    [QRBtn setBackgroundImage:[UIImage imageNamed:@"main_btn3"] forState:UIControlStateNormal];
    freeWashBtn.showsTouchWhenHighlighted = YES;
    [self.view addSubview:QRBtn];
    QRBtn.tag = 102;
    [QRBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnAction:(UIButton *)sender {
    if (sender.tag == 100) {
        if (vedioAwokeBtn.selected) {
            vedioBgView.hidden = YES;
            
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            VideoPlayerVC *videoPlayer = [story instantiateViewControllerWithIdentifier:@"PlayerView"];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:videoPlayer];
            [self.navigationController presentViewController:nav animated:YES completion:^{
                
            }];
        }
        else
            vedioBgView.hidden = NO;
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"免费洗车功能需要您观看100秒的视频和正确回答两道选择题后才能使用。（接下来需要观在线视频，建议您在WIFI环境下打开）" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"继续", nil];
//        alert.tag = 10086;
//        [alert show];
        
    } else if (sender.tag == 101) {
        PayWashCarVC *payWashCarVC = [[PayWashCarVC alloc]init];
        [self.navigationController pushViewController:payWashCarVC animated:YES];
    } else if (sender.tag == 102) {
        QRCodeViewController *qrVC = [[QRCodeViewController alloc]initWithNibName:@"QRCodeViewController" bundle:nil];
        [self.navigationController pushViewController:qrVC animated:YES];
    } else if (sender.tag == 200) {
        QRCodeViewController *qrVC = [[QRCodeViewController alloc]initWithNibName:@"QRCodeViewController" bundle:nil];
        [self.navigationController pushViewController:qrVC animated:YES];
        freeWashBgView.hidden = YES;
    } else if (sender.tag == 201) {
        freeWashBgView.hidden = YES;
    } else if (sender.tag == 300) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        VideoPlayerVC *videoPlayer = [story instantiateViewControllerWithIdentifier:@"PlayerView"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:videoPlayer];
        [self.navigationController presentViewController:nav animated:YES completion:^{
            vedioBgView.hidden = YES;
        }];
    } else if (sender.tag == 301) {
        vedioBgView.hidden = YES;
    } else if (sender.tag == 302) {
        vedioAwokeBtn.selected = !vedioAwokeBtn.selected;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10086) {
        if (buttonIndex == 1) {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            VideoPlayerVC *videoPlayer = [story instantiateViewControllerWithIdentifier:@"PlayerView"];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:videoPlayer];
            [self.navigationController presentViewController:nav animated:YES completion:^{
                
            }];
        }
    }
}

- (void)didRightAnswer:(NSNotification *)noti {
    QRCodeViewController *qrVC = [[QRCodeViewController alloc]initWithNibName:@"QRCodeViewController" bundle:nil];
    [self.navigationController pushViewController:qrVC animated:YES];
}

- (void)goToPayWashVC:(NSNotification *)noti {
    PayWashCarVC *payWashCarVC = [[PayWashCarVC alloc]init];
    [self.navigationController pushViewController:payWashCarVC animated:YES];
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
