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
        self.name = @"French Bulldog";
        self.phone = @"12345678901";
        self.carType = @"NISSAN GTR";
        self.carNum = @"66666";
        NSString *path = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@"png"];
        self.headerPath = path;
    }
    return  self;
}

@end
