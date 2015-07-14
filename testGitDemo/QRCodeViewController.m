//
//  QRCodeViewController.m
//  testGitDemo
//
//  Created by 张炯枫 on 15/6/7.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "QRCodeViewController.h"
#import "BaseMapViewController.h"
@interface QRCodeViewController ()
- (IBAction)gotoWashCarAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *gotoMapWashCar;

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation QRCodeViewController

@synthesize mapView     = _mapView;
@synthesize search      = _search;
- (void)viewDidLoad {
    self.title = @"二维码";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20.0],NSFontAttributeName, nil];
    [super viewDidLoad];
    
    UIButton * leftNacBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNacBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftNacBtn setBackgroundImage:[UIImage imageNamed:@"left_nav_button"] forState:UIControlStateNormal];
    [leftNacBtn addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftNacBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self initSearch];
    [self initMapView];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIButton * leftNacBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNacBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftNacBtn setBackgroundImage:[UIImage imageNamed:@"left_nav_button"] forState:UIControlStateNormal];
    [leftNacBtn addTarget:self action:@selector(gotoback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftNacBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}


- (void)backButtonPressed {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - init ui
- (void)initMapView
{
//    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager requestAlwaysAuthorization];
    }
}

/* 初始化search. */
- (void)initSearch
{
    self.search = [[AMapSearchAPI alloc] initWithSearchKey:[MAMapServices sharedServices].apiKey Delegate:nil];
}
#pragma mark - action
- (IBAction)gotoWashCarAction:(id)sender {
//    CustomAnnotationViewController *vc = [[CustomAnnotationViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    BaseMapViewController *subViewController = [[NSClassFromString(@"CustomAnnotationViewController") alloc] init];
    
    subViewController.title   = @"地图";
//    subViewController.mapView = self.mapView;
    subViewController.search  = self.search;
    
    [self.navigationController pushViewController:(UIViewController*)subViewController animated:YES];
}
- (void)gotoback{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
