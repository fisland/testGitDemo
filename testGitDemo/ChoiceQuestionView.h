//
//  ChoiceQuestionView.h
//  testGitDemo
//
//  Created by chanWenJay on 15/6/8.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChoiceQuestionViewDelegate;

@interface ChoiceQuestionView : UIView

@property (nonatomic, assign) id <ChoiceQuestionViewDelegate> delegate;

- (id)initWithMessage:(NSArray *)messageArray delegate:(id)delegate otherButtonTitles:(NSArray *)titleArray;

@end

@protocol ChoiceQuestionViewDelegate <NSObject>

@optional

- (void)choiceQuestionView:(ChoiceQuestionView *)choiceQuestionView clickChoiceAtIndex:(NSInteger)choiceIndex;

@end