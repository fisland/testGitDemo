//
//  MyPlayerView.h
//  自定义播放器demo
//
//  Created by vera on 14-11-26.
//  Copyright (c) 2014年 vera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

//播放器视图
@interface MyPlayerView : UIView

//播放器对象
@property (nonatomic,strong) AVPlayer *player;

@end
