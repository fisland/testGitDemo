//
//  AddCardVC.m
//  testGitDemo
//
//  Created by chanWenJay on 15/6/13.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "AddCardVC.h"
#import "AliPayVC.h"
#import "CreditCardVC.h"

@interface AddCardVC () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    UICollectionView *_collectionView;
}

@end

@implementation AddCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加付款方式";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20.0],NSFontAttributeName, nil];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    
    UIButton * leftNacBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNacBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftNacBtn setBackgroundImage:[UIImage imageNamed:@"left_nav_button"] forState:UIControlStateNormal];
    [leftNacBtn addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftNacBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)backButtonPressed {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)initUI {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(self.view.frame.size.width, 40)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 1, 1, 1);
    flowLayout.minimumInteritemSpacing = 1.0f;
    flowLayout.minimumLineSpacing = 1.0f;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.row == 0) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 20)];
        imgView.image = [UIImage imageNamed:@"payment_icon_small_alipay"];
        [cell.contentView addSubview:imgView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 150, 20)];
        label.text = @"支付宝";
        label.textColor = [UIColor colorWithRed:75/255.0f green:172/255.0f blue:233/255.f alpha:1.0f];
        label.font = [UIFont boldSystemFontOfSize:12.0f];
        [cell.contentView addSubview:label];
        
        UIImageView *allowImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 30, 13, 10, 14)];
        allowImg.image = [UIImage imageNamed:@"disclosure_arrow"];
        [cell.contentView addSubview:allowImg];
    } else {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 20)];
        imgView.image = [UIImage imageNamed:@"payment_icon_small_creditcard"];
        [cell.contentView addSubview:imgView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 150, 20)];
        label.text = @"信用卡";
        label.textColor = [UIColor colorWithRed:75/255.0f green:172/255.0f blue:233/255.f alpha:1.0f];
        label.font = [UIFont boldSystemFontOfSize:12.0f];
        [cell.contentView addSubview:label];
        
        UIImageView *allowImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 30, 13, 10, 14)];
        allowImg.image = [UIImage imageNamed:@"disclosure_arrow"];
        [cell.contentView addSubview:allowImg];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 ) {
        AliPayVC *aliPayVC = [[AliPayVC alloc] init];
        [self.navigationController pushViewController:aliPayVC animated:YES];
    } else if (indexPath.row == 1) {
        CreditCardVC *creditCardVC = [[CreditCardVC alloc] init];
        [self.navigationController pushViewController:creditCardVC animated:YES];
    }
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
