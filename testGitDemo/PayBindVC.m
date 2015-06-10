//
//  PayBindVC.m
//  testGitDemo
//
//  Created by 张炯枫 on 15/6/10.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "PayBindVC.h"

@implementation PayBindVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"支付绑定";
    
    UIBarButtonItem *openItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
    self.navigationItem.leftBarButtonItem = openItem;
    // Do any additional setup after loading the view.
}

- (void)backButtonPressed {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
