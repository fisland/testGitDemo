//
//  Config.h
//  testGitDemo
//
//  Created by 张炯枫 on 15/6/4.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#ifndef testGitDemo_Config_h
#define testGitDemo_Config_h

//----------------：颜色相关------------------------

#define default_nav_color  [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0]//默认导航条的背景色
#define default_tab_color  [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0]//默认tabbar背景颜色
#define default_blue_color [UIColor colorWithRed:68/255.0 green:129/255.0 blue:210/255.0 alpha:1.0] //系统默认蓝色

#define ClearColor      [UIColor clearColor]
#define RedColor        [UIColor redColor]
#define WhiteColor      [UIColor whiteColor]
#define BlackColor      [UIColor blackColor]
#define GreenColor      [UIColor greenColor]
#define YellowColor     [UIColor yellowColor]
#define BlueColor       [UIColor blueColor]
#define GrayColor       [UIColor grayColor]
#define LightGrayColor  [UIColor lightGrayColor]
#define SeparatorLineOrBorderColor RGB_A(204)//分割线的颜色，边框的颜色

#define RGB_A(x)        [UIColor colorWithRed:x/255.0 green:x/255.0 blue:x/255.0 alpha:1.0]     //后缀ABC排序
#define RGB_B(x,y,z)    [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]     //只为控制联想时
#define RGB_C(x,y,z,a)  [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:a/1.0]   //出现顺序
#define RGB_D(x,a)      [UIColor colorWithRed:x/255.0 green:x/255.0 blue:x/255.0 alpha:a/1.0]


//----------------：字体相关------------------------

#define Font(x)   [UIFont systemFontOfSize:x]        //设置系统字体
#define FontB(x)  [UIFont boldSystemFontOfSize:x]    //设置系统字体

//----------------：控件相关------------------------

//#define Rect(x, y, w, h) CGRectMake(x, y, w, h)

#define String(x)    [NSString stringWithFormat:@"%@", x == nil ? @"" : x];
#define StringInt(x) [NSString stringWithFormat:@"%d", x];

//-------------------通用宏定义-------------------
#define IS_IP5_SCREEN [UIScreen mainScreen].bounds.size.height>480
#define IPHONE_WIDTH  [UIScreen mainScreen].bounds.size.width
#define IPHONE_HEIGTH [UIScreen mainScreen].bounds.size.height

//-------------------登录宏定义-------------------
#define CurrentLoginUser @"CurrentLoginUser"
#endif
