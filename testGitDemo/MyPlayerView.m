//
//  MyPlayerView.m
//  自定义播放器demo
//
//  Created by vera on 14-11-26.
//  Copyright (c) 2014年 vera. All rights reserved.
//

#import "MyPlayerView.h"

@implementation MyPlayerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//default is [CALayer class]
+ (Class)layerClass
{
    //把当前层的CALayer对象改为AVPlayerLayer对象
    return [AVPlayerLayer class];
}

//安放播放器对象
- (void)setPlayer:(AVPlayer *)player
{
    AVPlayerLayer *layer = (AVPlayerLayer *)self.layer;
    layer.player = player;
}

- (AVPlayer *)player
{
    AVPlayerLayer *layer = (AVPlayerLayer *)self.layer;
    
    return layer.player;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
