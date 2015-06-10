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

@interface VideoPlayerVC () <ChoiceQuestionViewDelegate>

@property (nonatomic, strong) MPMoviePlayerController *movieVC;

@end

@implementation VideoPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self playMoview:@"welcome_video"];
    // Do any additional setup after loading the view.
}

- (void)playMoview:(NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    self.movieVC = [[MPMoviePlayerController alloc] initWithContentURL:url];
//    self.movieVC.controlStyle = MPMovieControlStyleFullscreen;
    self.movieVC.view.frame = self.view.bounds;
    [self.view addSubview:self.movieVC.view];
    [self.movieVC play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.movieVC];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieDidEnterFullScreen:) name:MPMoviePlayerDidEnterFullscreenNotification object:self.movieVC];
}

- (void)movieFinishedCallback:(NSNotification *)noti {
    ChoiceQuestionView *choiceQuestion = [[ChoiceQuestionView alloc] initWithMessage:@[@"我跟你们说啊我跟你们说啊我跟你们说啊我跟你们说啊我跟你们说啊我跟你们说啊我跟你们说啊我跟你们说啊我跟你们说啊我跟你们说啊我跟你们说啊我跟你们说啊我跟你们说啊我跟你们说啊我跟你们说啊我跟你们说啊我跟你们说啊",@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈"] delegate:self otherButtonTitles:@[@"A、123",@"B、234",@"C、345",@"D、456",@"A、123",@"B、234",@"C、345",@"D、456"]];
    [self.view addSubview:choiceQuestion];
//    MPMoviePlayerController *moviewVC = [noti object];
    //销毁播放通知
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:moviewVC];
//    [moviewVC.view removeFromSuperview];
    
}

- (void)movieDidEnterFullScreen:(NSNotification *)noti {
    [self.movieVC setFullscreen:NO animated:YES];
}

- (void)choiceQuestionView:(ChoiceQuestionView *)choiceQuestionView clickChoiceAtIndex:(NSInteger)choiceIndex {
    NSLog(@"%ld",choiceIndex);
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
