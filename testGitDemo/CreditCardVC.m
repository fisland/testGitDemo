//
//  CreditCardVC.m
//  testGitDemo
//
//  Created by chanWenJay on 15/6/13.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "CreditCardVC.h"
#import "Card.h"

@interface CreditCardVC () {
    UITextField *textField;
}

@end

@implementation CreditCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加付款方式";
    self.view.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightBtn.frame = CGRectMake(0, 0, 40, 20);
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(rightBarButtonClick)];
    self.navigationItem.rightBarButtonItem.customView = rightBtn;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChangeText) name:UITextFieldTextDidChangeNotification object:nil];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)rightBarButtonClick {
    Card *card = [[Card alloc] init];
    card.num = textField.text;
    card.type = 2;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:card,@"card", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addCard" object:nil userInfo:dic];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)initUI {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 30+64, self.view.frame.size.width-20, 40)];
    bgView.layer.borderWidth = 1.0f;
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderColor = [UIColor colorWithWhite:0.777f alpha:1.0f].CGColor;
    [self.view addSubview:bgView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 20)];
    imgView.image = [UIImage imageNamed:@"payment_icon_small_creditcard"];
    [bgView addSubview:imgView];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(imgView.frame.origin.x+imgView.frame.size.width+10, imgView.frame.origin.y, bgView.frame.size.width-50, 20)];
    textField.placeholder = @"1234 5678 9012 3456";
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [bgView addSubview:textField];
}

- (void)textFieldChangeText {
    if (textField.text.length >= 1) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else if (textField.text.length == 0){
        self.navigationItem.rightBarButtonItem.enabled = NO;
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
