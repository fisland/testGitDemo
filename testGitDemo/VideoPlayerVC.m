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

@interface VideoPlayerVC () <ChoiceQuestionViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) MPMoviePlayerController *movieVC;

@property (nonatomic, strong) NSMutableArray *resultArray;
@property (nonatomic, strong) NSArray        *keyArray;

@end

@implementation VideoPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.resultArray = [NSMutableArray array];
    self.keyArray = [NSArray arrayWithObjects:[NSNumber numberWithInteger:1],[NSNumber numberWithInteger:3], nil];
    self.navigationController.navigationBarHidden = YES;
    [self playMoview:@"welcome_video"];
    // Do any additional setup after loading the view.
}

- (void)playMoview:(NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    self.movieVC = [[MPMoviePlayerController alloc] initWithContentURL:url];
    self.movieVC.controlStyle = MPMovieControlStyleFullscreen;
    self.movieVC.view.frame = self.view.bounds;
    [self.view addSubview:self.movieVC.view];
    [self.movieVC play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.movieVC];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieDidEnterFullScreen:) name:MPMoviePlayerDidEnterFullscreenNotification object:self.movieVC];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieChangePlaybackState:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
}

- (void)movieFinishedCallback:(NSNotification *)noti {

    if (self.movieVC.currentPlaybackTime != self.movieVC.playableDuration) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    NSArray *messageArray = @[@"汽车轮胎上的沟纹主要作用是？",@"什么颜色的车交通发生交通事故的比率最高？"];
    NSArray *titlesArray = @[@"A、减轻车身重量",@"B、排除雨水和泥水",@"C、增加车身的缓冲",@"D、增加与地面的摩擦",@"A、红色",@"B、黑色",@"C、绿色",@"D、白色"];
    
    ChoiceQuestionView *choiceQuestion = [[ChoiceQuestionView alloc] initWithMessage:messageArray delegate:self otherButtonTitles:titlesArray];
    [self.view addSubview:choiceQuestion];
//    MPMoviePlayerController *moviewVC = [noti object];
    //销毁播放通知
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:moviewVC];
//    [moviewVC.view removeFromSuperview];
    
}

- (void)movieChangePlaybackState:(NSNotification *)noti {
    
}

- (void)movieDidEnterFullScreen:(NSNotification *)noti {
    [self.movieVC setFullscreen:NO animated:YES];
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
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"rightAnswer" object:nil];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    } else if (buttonIndex == 1) {
        [self.movieVC play];
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
