//
//  VideoPlayerVC.m
//  testGitDemo
//
//  Created by chanWenJay on 15/6/7.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "VideoPlayerVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ChoiceQuestionView.h"
#import <AVFoundation/AVFoundation.h>
#import "MyPlayerView.h"

@interface VideoPlayerVC () <ChoiceQuestionViewDelegate, UIAlertViewDelegate>
{
    BOOL isHide;
    
    UIView *alertBgView;
    
    UIView  *choice1BgView;
    UIImageView *choice1View;
    UILabel *choice1Label;
    UIButton *choice1Btn1;
    UIButton *choice1Btn2;
    
    UIView  *choice2BgView;
    UIImageView *choice2View;
    UILabel *choice2Label;
    UIButton *choice2Btn1;
    UIButton *choice2Btn2;
    
    UIView  *faultBgView;
    UIImageView *faultView;
    UILabel *faultLabel;
    UIButton *faultPlayBackBtn;
    UIButton *faultPayWashBtn;
    
    UIView  *rightBgView;
    UIImageView *rightView;
    UILabel *rightLabel;
    UIImageView *rightQRImage;
}

//播放器对象（只能安放到AVPlayerLayer才能显示）
@property (nonatomic,strong) AVPlayer *player;
//保存视频的信息
@property (nonatomic,strong) AVPlayerItem *playerItem;

//总时间
@property (nonatomic,assign) CGFloat totalSecond;

@property (nonatomic, strong) MPMoviePlayerController *movieVC;

@property (nonatomic, strong) NSMutableArray *resultArray;
@property (nonatomic, strong) NSArray        *keyArray;

@property (nonatomic, strong) id            observer;

@end

@implementation VideoPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.resultArray = [NSMutableArray array];
    self.keyArray = [NSArray arrayWithObjects:[NSNumber numberWithInteger:1],[NSNumber numberWithInteger:3], nil];
    self.navigationController.navigationBarHidden = YES;
    [self.timeSlider setThumbImage:[UIImage imageNamed:@"clarity"] forState:UIControlStateNormal];
    [self.timeSlider setMaximumTrackTintColor:[UIColor blackColor]];
    
    self.titleLabel.center = CGPointMake(self.view.center.x, self.titleLabel.center.y);
    
    [self playMoview:@"welcome_video"];
    //观察当前视频的状态，如果当前状态处于可以播放状态，才能获取总时间
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    [self initCustomAlertView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didPlayToEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];

    // Do any additional setup after loading the view.
}

- (void)initCustomAlertView {
    
    alertBgView = [[UIView alloc] initWithFrame:self.view.frame];
    alertBgView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
    [self.view addSubview:alertBgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alertViewTapAction)];
    [alertBgView addGestureRecognizer:tap];
    
    //choice 1
    choice1BgView = [[UIView alloc] initWithFrame:CGRectMake(70, (self.view.frame.size.height-200)/2-64, self.view.frame.size.width-70*2, 200)];
    [self.view addSubview:choice1BgView];
    
    choice1View = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, choice1BgView.frame.size.width, choice1BgView.frame.size.height)];
    choice1View.image = [UIImage imageNamed:@"alert_bg.png"];
    [choice1BgView addSubview:choice1View];
    
    choice1Label = [[UILabel alloc] initWithFrame:CGRectMake(23, 10, choice1View.frame.size.width-46, 90)];
    choice1Label.text = @"视频中司机驾驶的是哪个牌子的汽车?";
    choice1Label.font = [UIFont boldSystemFontOfSize:20.0f];
    choice1Label.textAlignment = NSTextAlignmentCenter;
    choice1Label.textColor = [UIColor whiteColor];
    choice1Label.numberOfLines = 3;
    [choice1BgView addSubview:choice1Label];
    
    choice1Btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    choice1Btn1.frame = CGRectMake(30, choice1Label.frame.origin.y+choice1Label.frame.size.height,80, 80);
    [choice1Btn1 setBackgroundImage:[UIImage imageNamed:@"choiceBtn1.png"] forState:UIControlStateNormal];
    choice1Btn1.showsTouchWhenHighlighted = YES;
    choice1Btn1.tag = 200;
    [choice1BgView addSubview:choice1Btn1];
    [choice1Btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    choice1Btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    choice1Btn2.frame = CGRectMake(choice1View.frame.size.width-30-choice1Btn1.frame.size.width, choice1Btn1.frame.origin.y,choice1Btn1.frame.size.width, choice1Btn1.frame.size.height);
    [choice1Btn2 setBackgroundImage:[UIImage imageNamed:@"choiceBtn2.png"] forState:UIControlStateNormal];
    choice1Btn2.showsTouchWhenHighlighted = YES;
    choice1Btn2.tag = 201;
    [choice1BgView addSubview:choice1Btn2];
    [choice1Btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //choice 2
    choice2BgView = [[UIView alloc] initWithFrame:CGRectMake(70, (self.view.frame.size.height-200)/2-64, self.view.frame.size.width-70*2, 200)];
    [self.view addSubview:choice2BgView];
    
    choice2View = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, choice2BgView.frame.size.width, choice2BgView.frame.size.height)];
    choice2View.image = [UIImage imageNamed:@"alert_bg.png"];
    [choice2BgView addSubview:choice2View];
    
    choice2Label = [[UILabel alloc] initWithFrame:CGRectMake(23, 10, choice2View.frame.size.width-46, 90)];
    choice2Label.text = @"这个视频是哪个打车软件的广告?";
    choice2Label.font = [UIFont boldSystemFontOfSize:20.0f];
    choice2Label.textAlignment = NSTextAlignmentCenter;
    choice2Label.textColor = [UIColor whiteColor];
    choice2Label.numberOfLines = 3;
    [choice2BgView addSubview:choice2Label];
    
    choice2Btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    choice2Btn1.frame = CGRectMake(30, choice2Label.frame.origin.y+choice2Label.frame.size.height,80, 80);
    [choice2Btn1 setBackgroundImage:[UIImage imageNamed:@"choiceBtn3.png"] forState:UIControlStateNormal];
    choice2Btn1.showsTouchWhenHighlighted = YES;
    choice2Btn1.tag = 202;
    [choice2BgView addSubview:choice2Btn1];
    [choice2Btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    choice2Btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    choice2Btn2.frame = CGRectMake(choice2View.frame.size.width-30-choice2Btn1.frame.size.width, choice2Btn1.frame.origin.y,choice2Btn1.frame.size.width, choice2Btn1.frame.size.height);
    [choice2Btn2 setBackgroundImage:[UIImage imageNamed:@"choiceBtn4.png"] forState:UIControlStateNormal];
    choice2Btn2.showsTouchWhenHighlighted = YES;
    choice2Btn2.tag = 203;
    [choice2BgView addSubview:choice2Btn2];
    [choice2Btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //fault choice
    faultBgView = [[UIView alloc] initWithFrame:CGRectMake(70, (self.view.frame.size.height-200)/2-64, self.view.frame.size.width-70*2, 200)];
    [self.view addSubview:faultBgView];
    
    faultView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, faultBgView.frame.size.width, faultBgView.frame.size.height)];
    faultView.image = [UIImage imageNamed:@"alert_bg.png"];
    [faultBgView addSubview:faultView];
    
    faultLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 10, faultView.frame.size.width-46, 90)];
    faultLabel.text = @"回答错误";
    faultLabel.textAlignment = NSTextAlignmentCenter;
    faultLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    faultLabel.textAlignment = NSTextAlignmentCenter;
    faultLabel.textColor = [UIColor whiteColor];
    faultLabel.numberOfLines = 3;
    [faultBgView addSubview:faultLabel];
    
    faultPlayBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    faultPlayBackBtn.frame = CGRectMake(30, faultLabel.frame.origin.y+faultLabel.frame.size.height,80, 80);
    [faultPlayBackBtn setBackgroundImage:[UIImage imageNamed:@"YES button3.png"] forState:UIControlStateNormal];
    faultPlayBackBtn.showsTouchWhenHighlighted = YES;
    faultPlayBackBtn.tag = 300;
    [faultBgView addSubview:faultPlayBackBtn];
    [faultPlayBackBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    faultPayWashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    faultPayWashBtn.frame = CGRectMake(faultView.frame.size.width-30-faultPlayBackBtn.frame.size.width, faultPlayBackBtn.frame.origin.y,faultPlayBackBtn.frame.size.width, faultPlayBackBtn.frame.size.height);
    [faultPayWashBtn setBackgroundImage:[UIImage imageNamed:@"NO button3.png"] forState:UIControlStateNormal];
    faultPayWashBtn.showsTouchWhenHighlighted = YES;
    faultPayWashBtn.tag = 301;
    [faultBgView addSubview:faultPayWashBtn];
    [faultPayWashBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

    //right choice
    rightBgView = [[UIView alloc] initWithFrame:CGRectMake(70, (self.view.frame.size.height-200)/2-64, self.view.frame.size.width-70*2, 200)];
    [self.view addSubview:rightBgView];
    
    rightView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, rightBgView.frame.size.width, rightBgView.frame.size.height)];
    rightView.image = [UIImage imageNamed:@"alert_bg.png"];
    [rightBgView addSubview:rightView];
    
    rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 10, rightView.frame.size.width-46, 60)];
    rightLabel.text = @"回答正确\n恭喜您获得免费洗车资格";
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.textColor = [UIColor whiteColor];
    rightLabel.numberOfLines = 2;
    [rightBgView addSubview:rightLabel];
    
    rightQRImage = [[UIImageView alloc] initWithFrame:CGRectMake((rightBgView.frame.size.width-100)/2, rightLabel.frame.origin.y+rightLabel.frame.size.height+10, 100, 100)];
    rightQRImage.image = [UIImage imageNamed:@"washCarQRCode.png"];
    [rightBgView addSubview:rightQRImage];
    
    alertBgView.hidden = YES;
    choice1BgView.hidden = YES;
    choice2BgView.hidden = YES;
    faultBgView.hidden = YES;
    rightBgView.hidden = YES;
    
}

- (void)btnAction:(UIButton *)sender {
    if (sender.tag == 200) {
        choice1BgView.hidden = YES;
        faultBgView.hidden = NO;
    } else if (sender.tag == 201) {
        choice1BgView.hidden = YES;
        choice2BgView.hidden = NO;
    } else if (sender.tag == 202) {
        choice2BgView.hidden = YES;
        rightBgView.hidden = NO;
        alertBgView.userInteractionEnabled = YES;
    } else if (sender.tag == 203) {
        choice2BgView.hidden = YES;
        faultBgView.hidden = NO;
    } else if (sender.tag == 300) {
        faultBgView.hidden = YES;
        alertBgView.hidden = YES;
        [_player play];
        self.playBtn.selected = YES;
    } else if (sender.tag == 301) {
        faultBgView.hidden = YES;
        alertBgView.hidden = YES;
        [_player removeTimeObserver:self.observer];
        [_playerItem removeObserver:self forKeyPath:@"status"];
        [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"goToPayWashVC" object:nil];
        }];
    }
}

- (void)playMoview:(NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp4"];
    _playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:path]];
    //播放器初始化
    _player = [AVPlayer playerWithPlayerItem:_playerItem];
    
    //播放器视图初始化
    MyPlayerView *playerView = [[MyPlayerView alloc] initWithFrame:self.view.bounds];
    playerView.player = _player;
    playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    playerView.backgroundColor = [UIColor blackColor];
    playerView.userInteractionEnabled = YES;
    [self.view addSubview:playerView];
    [self.view sendSubviewToBack:playerView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [playerView addGestureRecognizer:tap];
    
    [self.player play];
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // code to be executed on the main queue after delay
        [self tapAction];
    });
}

- (void)tapAction {
    if (!isHide) {
        self.topBarView.hidden = YES;
        self.bottomBarView.hidden = YES;
        isHide = YES;
    } else {
        self.topBarView.hidden = NO;
        self.bottomBarView.hidden = NO;
        isHide = NO;
        
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // code to be executed on the main queue after delay
            if (!self.topBarView.hidden) {
                [self tapAction];
            }
        });
    }
}

- (void)alertViewTapAction {
    if (alertBgView.hidden==NO && rightBgView.hidden==NO) {
        alertBgView.hidden = YES;
        rightBgView.hidden = YES;
        
        [_player removeTimeObserver:self.observer];
        [_playerItem removeObserver:self forKeyPath:@"status"];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

- (void)choiceQuestionView:(ChoiceQuestionView *)choiceQuestionView clickChoiceAtIndex:(NSInteger)choiceIndex isFinish:(BOOL)isFinish{
    NSLog(@"%ld,%d",choiceIndex,isFinish);
    [self.resultArray addObject:[NSNumber numberWithInteger:choiceIndex]];
    if (isFinish) {
        for (NSInteger i = 0; i < self.resultArray.count; i++) {
            NSLog(@"%@,%@",self.resultArray[i],self.keyArray[i]);
            if ([self.resultArray[i] integerValue] != [self.keyArray[i] integerValue]) {
                [self.resultArray removeAllObjects];
                [self wrongAnswer];
                return ;
            }
        
            if (i == (self.resultArray.count-1)) {
                [self.resultArray removeAllObjects];
                [self rightAnswer];
            }
        }
    }
}

- (void)wrongAnswer {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"回答错误,请重新看过视频和回答选择题" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"好的", nil];
    [alert show];
}

- (void)rightAnswer {
    [_player removeTimeObserver:self.observer];
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"rightAnswer" object:nil];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [_player removeTimeObserver:self.observer];
        [_playerItem removeObserver:self forKeyPath:@"status"];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    } else if (buttonIndex == 1) {
        [_player play];
        self.playBtn.selected = YES;

    }
}

- (void)didPlayToEnd:(NSNotification *)noti {
    self.playBtn.selected = NO;
    CMTime time = _playerItem.currentTime;
    time.value = 0;
    [_playerItem seekToTime:time];
    
    alertBgView.hidden = NO;
    choice1BgView.hidden = NO;
//    NSArray *messageArray = @[@"汽车轮胎上的沟纹主要作用是？",@"什么颜色的车交通发生交通事故的比率最高？"];
//    NSArray *titlesArray = @[@"A、减轻车身重量",@"B、排除雨水和泥水",@"C、增加车身的缓冲",@"D、增加与地面的摩擦",@"A、红色",@"B、黑色",@"C、绿色",@"D、白色"];
//    
//    ChoiceQuestionView *choiceQuestion = [[ChoiceQuestionView alloc] initWithMessage:messageArray delegate:self otherButtonTitles:titlesArray];
//    [self.view addSubview:choiceQuestion];
}

//当观察的值发生变化会自动调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"])
    {
        //视频可以播放
        if ([change[NSKeyValueChangeNewKey] integerValue] == AVPlayerItemStatusReadyToPlay)
        {
            //CMTimeMake(@"当前为哪一帧", @"帧率");
            
            //秒 = value/timescale
            
            //计算视频的总秒数
            CMTime time = _playerItem.duration;
            _totalSecond = time.value / time.timescale;
            
            //赋值
            _totalTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",(int)_totalSecond/60,(int)_totalSecond%60];
            
            //解决循环引用问题
            __weak VideoPlayerVC *ctl = self;
            
            //计算当前时间
            self.observer = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time)
             {
                 CMTime currentTime = ctl.playerItem.currentTime;
                 //当前播放时间
                 CGFloat currentSecond = currentTime.value / currentTime.timescale;
                 
                 //赋值
                 ctl.currentTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",(int)currentSecond/60,(int)currentSecond%60];
                 ctl.timeSlider.value = currentSecond/ctl.totalSecond;

             }];
        }
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)playBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected)
    {
        //播放
        [_player play];
    }
    else
    {
        //暂停
        [_player pause];
    }
}

- (IBAction)doneBtnAction:(id)sender {
    [_player removeTimeObserver:self.observer];
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
