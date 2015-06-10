//
//  ChoiceQuestionView.m
//  testGitDemo
//
//  Created by chanWenJay on 15/6/8.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "ChoiceQuestionView.h"

@interface ChoiceQuestionView () {
    UIScrollView *bgView;
    NSInteger num;
    NSInteger lowLowY;
    NSInteger maxHeight;
}

@property (nonatomic, assign) NSNumber *index;

@end

@implementation ChoiceQuestionView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (id)initWithMessage:(NSArray *)messageArray delegate:(id)delegate otherButtonTitles:(NSArray *)titleArray {
    self = [super init];
    self.delegate = delegate;
    [self setFrame:[[UIScreen mainScreen] bounds]];
    self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    bgView = [[UIScrollView alloc] initWithFrame:CGRectMake(50, 150, rect.size.width-100, rect.size.height-300)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.scrollEnabled = NO;
    [self addSubview:bgView];
    num = titleArray.count/messageArray.count-1;
    
    for (NSInteger i = 0; i < messageArray.count; i++) {
        //选择题题目
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+i*bgView.frame.size.width, 20, bgView.frame.size.width-40, 20)];
        titleLabel.text = messageArray[i];
        titleLabel.numberOfLines = 0;
        titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [titleLabel sizeToFit];
        [bgView addSubview:titleLabel];
        NSInteger lowY = titleLabel.frame.size.height+titleLabel.frame.origin.y;
        NSInteger lowHeight = 0;
        lowLowY = 0;
        
        //选项内容
        for (NSInteger j = 0; j < (num+1); j++) {
            
            UILabel *choice = [[UILabel alloc] initWithFrame:CGRectMake(20+i*bgView.frame.size.width, lowY+lowHeight*j+20*(j+1), bgView.frame.size.width-40, 20)];
            choice.text = titleArray[i*(num+1)+j];
            choice.numberOfLines = 0;
            choice.font = [UIFont systemFontOfSize:16.0f];
            [choice sizeToFit];
            choice.tag = 100*i+j+(num+1)*2;
            lowHeight = choice.frame.size.height;
            lowLowY = choice.frame.size.height+choice.frame.origin.y;
            [bgView addSubview:choice];
            
            UIControl *choiceControl = [[UIControl alloc] initWithFrame:CGRectMake(bgView.frame.size.width*i, choice.frame.origin.y-10, bgView.frame.size.width, choice.frame.size.height+20)];
            [choiceControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
            choiceControl.backgroundColor = [UIColor clearColor];
            choiceControl.tag = 100*i+j+1;
            [bgView addSubview:choiceControl];
            
            UIButton *backgroudBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            backgroudBtn.frame = choiceControl.frame;
            backgroudBtn.backgroundColor = [UIColor clearColor];
            backgroudBtn.tag = 100*i+j+1+num+1;
            [bgView addSubview:backgroudBtn];
            [bgView sendSubviewToBack:backgroudBtn];
        }
        
        //提交按钮
        if (i != messageArray.count-1) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            NSInteger btnWith = bgView.frame.size.width/4;
            btn.frame = CGRectMake((bgView.frame.size.width-btnWith)/2+bgView.frame.size.width*i, lowLowY+30, btnWith, 30);
            [btn setTitle:@"下一道" forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor colorWithRed:68/255.0 green:129/255.0 blue:210/255.0 alpha:1.0];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [bgView addSubview:btn];
            btn.tag = 100*(i+1);
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            lowLowY = btn.frame.size.height+btn.frame.origin.y;
            if (lowLowY > maxHeight) {
                maxHeight = lowLowY;
            }
        } else {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            NSInteger btnWith = bgView.frame.size.width/4;
            btn.frame = CGRectMake((bgView.frame.size.width-btnWith)/2+bgView.frame.size.width*i, lowLowY+30, btnWith, 30);
            [btn setTitle:@"提 交" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor colorWithRed:68/255.0 green:129/255.0 blue:210/255.0 alpha:1.0];
            [bgView addSubview:btn];
            btn.tag = 10086;
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            lowLowY = btn.frame.size.height+btn.frame.origin.y;
            if (lowLowY > maxHeight) {
                maxHeight = lowLowY;
            }
        }
        bgView.frame = CGRectMake(bgView.frame.origin.x, bgView.frame.origin.y, bgView.frame.size.width, maxHeight+20);
        bgView.contentSize = CGSizeMake(bgView.frame.size.width*messageArray.count, bgView.frame.size.height);
    }
    
    return self;
}

- (void)btnAction:(UIButton *)sender {
    if (self.index) {
        if ([self.delegate respondsToSelector:@selector(choiceQuestionView:clickChoiceAtIndex:isFinish:)]) {

            if (sender.tag != 10086) {
                [self.delegate choiceQuestionView:self clickChoiceAtIndex:[self.index integerValue] isFinish:NO];
                self.index = nil;
                [bgView setContentOffset:CGPointMake(sender.tag/100*bgView.frame.size.width, 0) animated:YES];
            } else {
                [self.delegate choiceQuestionView:self clickChoiceAtIndex:[self.index integerValue] isFinish:YES];
                self.index = nil;
                [self removeFromSuperview];
            }
            
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择一个答案" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)controlAction:(UIControl *)sender {
    UIButton *backgroundBtn = (UIButton *)[bgView viewWithTag:sender.tag+num+1];
    
    if (backgroundBtn.selected) {
        backgroundBtn.backgroundColor = [UIColor clearColor];
        backgroundBtn.selected = NO;
    } else {
        backgroundBtn.backgroundColor = [UIColor yellowColor];
        backgroundBtn.selected = YES;
    }
    
    if (backgroundBtn.selected) {
        self.index = [NSNumber numberWithInteger:sender.tag%100];
    } else {
        self.index = nil;
    }
    NSInteger tag = sender.tag - sender.tag%100;
    for (NSInteger i = 0; i < num+1; i++) {
        UIButton *btn = (UIButton *)[bgView viewWithTag:tag+i+1+num+1];
        if (btn == backgroundBtn) {
            continue;
        }
        btn.backgroundColor = [UIColor clearColor];
        btn.selected = NO;
    }
    
}

@end
