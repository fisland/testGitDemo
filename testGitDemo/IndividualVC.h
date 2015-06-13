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

@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *carTypeTF;
@property (weak, nonatomic) IBOutlet UITextField *carNumType;

@property (nonatomic, strong) User *user;

@end
