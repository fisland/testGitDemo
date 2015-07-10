//
//  User.m
//  testGitDemo
//
//  Created by chanWenJay on 15/6/14.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "User.h"

@implementation User

- (id)init {
    if (self = [super init]) {
        self.name = @"廖 企鹅";
        self.phone = @"12345678901";
        self.carType = @"NISSAN GTR";
        self.carNum = @"66666";
        self.carModel = @"跑车";
        NSString *path = [[NSBundle mainBundle] pathForResource:@"head" ofType:@"png"];
        self.headerPath = path;
    }
    return  self;
}

@end
