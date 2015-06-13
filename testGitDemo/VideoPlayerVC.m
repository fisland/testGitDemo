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
    [self.timeSlider setThumbImage:[UIImage imageNamed:@"2011121611432897"] forState:UIControlStateNormal];
    [self.timeSlider setMaximumTrackTintColor:[UIColor blackColor]];
    
    [self playMoview:@"welcome_video"];
    //观察当前视频的状态，如果当前状态处于可以播放状态，才能获取总时间
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didPlayToEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];

    // Do any additional setup after loading the view.
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
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"rightAnswer" object:nil];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
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
    
    NSArray *messageArray = @[@"汽车轮胎上的沟纹主要作用是？",@"什么颜色的车交通发生交通事故的比率最高？"];
    NSArray *titlesArray = @[@"A、减轻车身重量",@"B、排除雨水和泥水",@"C、增加车身的缓冲",@"D、增加与地面的摩擦",@"A、红色",@"B、黑色",@"C、绿色",@"D、白色"];
    
    ChoiceQuestionView *choiceQuestion = [[ChoiceQuestionView alloc] initWithMessage:messageArray delegate:self otherButtonTitles:titlesArray];
    [self.view addSubview:choiceQuestion];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
