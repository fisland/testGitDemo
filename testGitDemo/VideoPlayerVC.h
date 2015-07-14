//
//  VideoPlayerVC.h
//  testGitDemo
//
//  Created by chanWenJay on 15/6/7.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayWashCarVC.h"

@protocol UIVideoPlayerDelegate;

@interface VideoPlayerVC : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *timeSlider;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *topBarView;
@property (weak, nonatomic) IBOutlet UIView *bottomBarView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (IBAction)playBtnClick:(id)sender;
- (IBAction)doneBtnAction:(id)sender;

@property (nonatomic, assign) id<UIVideoPlayerDelegate> delegate;

@end

@protocol UIVideoPlayerDelegate <NSObject>

@optional

- (void)pushMapView;

@end
