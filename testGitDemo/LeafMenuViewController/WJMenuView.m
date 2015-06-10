//
//  WJMenuView.m
//  testGitDemo
//
//  Created by chanWenJay on 15/6/3.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "WJMenuView.h"
#import "IndividualVC.h"
#import "PayBindVC.h"
#import "SaleVC.h"
#import "ShareVC.h"
#import "HelpVC.h"

@interface WJMenuView ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView * leftTableView;
    NSArray * names;
    NSArray * imgNames;
    NSInteger currentRow;
}

@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation WJMenuView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
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
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    //view.backgroundColor = [UIColor redColor];
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 40, 40)];
    imgView.layer.cornerRadius = 20;
    imgView.clipsToBounds = YES;
    imgView.image = [UIImage imageNamed:@"dog.png"];
    [view addSubview:imgView];
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, 150, 40)];
    nameLabel.text = @"French Bulldog";
    nameLabel.font = [UIFont fontWithName:@"Arial" size:15];
    nameLabel.textColor = [UIColor darkGrayColor];
    [view addSubview:nameLabel];
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userViewClick)];
//    [view addGestureRecognizer:tap];
    leftTableView.tableHeaderView = view;
}

-(void)loadData
{
    names = @[@"个人资料",@"付款",@"优惠",@"分享",@"帮助"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return names.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = names[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        IndividualVC *individualVC = [[IndividualVC alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:individualVC];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    } else if (indexPath.row == 1) {
        PayBindVC *payVC = [[PayBindVC alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:payVC];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    } else if (indexPath.row == 2) {
        SaleVC *saleVC = [[SaleVC alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:saleVC];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    } else if (indexPath.row == 3) {
        ShareVC *shareVC = [[ShareVC alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:shareVC];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    } else if (indexPath.row == 4) {
        HelpVC *helpVC = [[HelpVC alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:helpVC];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
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
