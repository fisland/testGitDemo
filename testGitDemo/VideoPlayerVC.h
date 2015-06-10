//
//  VideoPlayerVC.h
//  testGitDemo
//
//  Created by chanWenJay on 15/6/7.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoPlayerVC : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *timeSlider;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *topBarView;
@property (weak, nonatomic) IBOutlet UIView *bottomBarView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

- (IBAction)playBtnClick:(id)sender;
- (IBAction)doneBtnAction:(id)sender;

@end
