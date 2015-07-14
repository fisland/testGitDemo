//
//  PayBindVC.m
//  testGitDemo
//
//  Created by 张炯枫 on 15/6/10.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "PayBindVC.h"
#import "AddCardVC.h"
#import "Card.h"

@interface PayBindVC () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    UICollectionView *_collectionView;
    NSMutableArray *dataArray;
}

@end

@implementation PayBindVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付绑定";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20.0],NSFontAttributeName, nil];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.backBarButtonItem = backItem;
    backItem.title = @"back";
    self.view.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    
    dataArray = [NSMutableArray array];
    [self initUI];
    
    UIButton * leftNacBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNacBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftNacBtn setBackgroundImage:[UIImage imageNamed:@"left_nav_button"] forState:UIControlStateNormal];
    [leftNacBtn addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftNacBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAddCard:) name:@"addCard" object:nil];
    // Do any additional setup after loading the view.
}

- (void)backButtonPressed {
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

}

- (void)initUI {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(self.view.frame.size.width-20, 40)];
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
    return dataArray.count + 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.row == dataArray.count) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 20)];
        imgView.tag = 2000;
        imgView.image = [UIImage imageNamed:@"card_plus"];
        [cell.contentView addSubview:imgView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 150, 20)];
        label.text = @"添加付款方式";
        label.tag = 2001;
        label.textColor = [UIColor colorWithRed:75/255.0f green:172/255.0f blue:233/255.f alpha:1.0f];
        label.font = [UIFont boldSystemFontOfSize:12.0f];
        [cell.contentView addSubview:label];
    } else {
        if (dataArray.count > 0) {
            UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:2000];
            Card *card = dataArray[indexPath.row];
            if (card.type == 1) {
                imgView.image = [UIImage imageNamed:@"payment_icon_small_alipay"];
            } else {
                imgView.image = [UIImage imageNamed:@"credit_card_large_union_pay"];
            }
            [cell.contentView addSubview:imgView];
            
            UILabel *label = (UILabel *)[cell.contentView viewWithTag:2001];
            label.text = card.num;
            label.textColor = [UIColor blackColor];
            label.font = [UIFont boldSystemFontOfSize:12.0f];
            [cell.contentView addSubview:label];
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == dataArray.count) {
        AddCardVC *addCardVC = [[AddCardVC alloc] init];
        [self.navigationController pushViewController:addCardVC animated:YES];
    }
}

- (void)didAddCard:(NSNotification *)noti {
    Card *card = noti.userInfo[@"card"];
    [dataArray addObject:card];
    [_collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
