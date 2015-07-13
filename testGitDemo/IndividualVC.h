//
//  IndividualVC.h
//  testGitDemo
//
//  Created by chanWenJay on 15/6/4.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface IndividualVC : UIViewController

@property (strong, nonatomic) UIImageView *headerImgView;
@property (strong, nonatomic) UITextField *nameTF;

@property (strong, nonatomic) UITextField *phoneTF;
@property (strong, nonatomic) UITextField *carTypeTF;
@property (strong, nonatomic) UITextField *carNumType;
@property (nonatomic, strong) UITextField *carModel;

@property (nonatomic, strong) UIButton *quitBtn;

@property (nonatomic, strong) User *user;

@end
