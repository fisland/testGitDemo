//
//  WJMenuView.m
//  testGitDemo
//
//  Created by chanWenJay on 15/6/3.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "WJMenuView.h"

@interface WJMenuView ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView * leftTableView;
}

@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation WJMenuView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height) style:(UITableViewStylePlain)];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    [leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    leftTableView.tableFooterView = [[UITableView alloc]init];
    [self.view addSubview:leftTableView];
    leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setTheHeaderView];
    [self loadData];
    // Do any additional setup after loading the view.
}

-(void)setTheHeaderView {
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    //view.backgroundColor = [UIColor redColor];
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 40, 40)];
    imgView.layer.cornerRadius = 20;
    imgView.clipsToBounds = YES;
    [imgView setImageWithURL:[NSURL URLWithString:@"http://imgcdn.guoku.com/avatar/large/bd7679e7adfc7c61ff463610338e4981"]];
    [view addSubview:imgView];
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, 90, 40)];
    nameLabel.text = @"枫island";
    nameLabel.font = [UIFont fontWithName:@"Arial" size:15];
    nameLabel.textColor = [UIColor darkGrayColor];
    [view addSubview:nameLabel];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userViewClick)];
    [view addGestureRecognizer:tap];
    leftTableView.tableHeaderView = view;
}

-(void)loadData
{
    names = @[@"首页",@"精选",@"热门",@"发现",@"动态",@"消息",@"设置"];
    imgNames = @[@"bg_allmooc_default",@"bg_mymooc_default",@"bg_mynote_default",@"bg_off-line_default",@"Drawer_iOS7",@"bg_message_default",@"bg_setting_default"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
