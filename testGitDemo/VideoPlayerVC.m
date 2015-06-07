//
//  VideoPlayerVC.m
//  testGitDemo
//
//  Created by chanWenJay on 15/6/7.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "VideoPlayerVC.h"
#import <MediaPlayer/MediaPlayer.h>

@interface VideoPlayerVC ()

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieWillEnterFullScreen:) name:MPMoviePlayerWillEnterFullscreenNotification object:self.movieVC];

}

- (void)movieFinishedCallback:(NSNotification *)noti {
    MPMoviePlayerController *moviewVC = [noti object];
    //销毁播放通知
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:moviewVC];
//    [moviewVC.view removeFromSuperview];
    
}

- (void)movieWillEnterFullScreen:(NSNotification *)noti {
    [self.movieVC setFullscreen:NO animated:NO];
//    self.movieVC.controlStyle = MPMovieControlStyleNone;
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
