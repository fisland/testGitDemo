//
//  IndividualVC.m
//  testGitDemo
//
//  Created by chanWenJay on 15/6/4.
//  Copyright (c) 2015年 fisland. All rights reserved.
//

#import "IndividualVC.h"

@interface IndividualVC () <UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    int selectTag;
    int offset;
    BOOL isMove;
    int movingTag;
    NSString* filePath;
    
    UIView *phoneView;
    UIView *carNumView;
    UIView *carTypeView;
    UIView *carModelView;
}

@end

@implementation IndividualVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人资料";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20.0],NSFontAttributeName, nil];
    self.headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(IPHONE_WIDTH/2-50, 24, 100, 100)];
    self.headerImgView.layer.cornerRadius = self.headerImgView.frame.size.width/2;
    self.headerImgView.image = [UIImage imageWithContentsOfFile:self.user.headerPath];
    self.headerImgView.clipsToBounds = YES;
    [self.view addSubview:self.headerImgView];
    
    self.nameTF = [[UITextField alloc] initWithFrame:CGRectMake(IPHONE_WIDTH/2-100, 140, 200, 30)];
    self.nameTF.text = self.user.name;
    self.nameTF.textColor = [UIColor colorWithRed:19/255.0f green:147/255.0f blue:178/255.0f alpha:1.0f];
    self.nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameTF.font = [UIFont boldSystemFontOfSize:22.0f];
    self.nameTF.textAlignment = NSTextAlignmentCenter;
    self.nameTF.tag = 1000;
    self.nameTF.delegate = self;
    [self.view addSubview:self.nameTF];

    NSInteger btnWidth = 300;
    NSInteger btnPonintX = (IPHONE_WIDTH - btnWidth) / 2;
    
    phoneView = [self createNormaelTextFieldView:@"手机" andPoint:CGPointMake(btnPonintX, 210) andIsSecure:NO];
    phoneView.tag = 2001;
    [self.view addSubview:phoneView];
    carNumView = [self createNormaelTextFieldView:@"车牌号" andPoint:CGPointMake(btnPonintX, 280) andIsSecure:NO];
    carNumView.tag = 2002;
    [self.view addSubview:carNumView];
    carTypeView = [self createNormaelTextFieldView:@"品牌" andPoint:CGPointMake(btnPonintX, 350) andIsSecure:NO];
    carTypeView.tag = 2003;
    [self.view addSubview:carTypeView];
    carModelView = [self createNormaelTextFieldView:@"车型" andPoint:CGPointMake(btnPonintX, 420) andIsSecure:NO];
    carModelView.tag = 2004;
    [self.view addSubview:carModelView];
    
    self.quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.quitBtn.frame = CGRectMake(btnPonintX, 490, btnWidth, 45);
    [self.quitBtn setBackgroundImage:[UIImage imageNamed:@"normal_button"] forState:UIControlStateNormal];
    [self.quitBtn setTitle:@"退    出" forState:UIControlStateNormal];
    [self.quitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.quitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:24.0f];
    [self.view addSubview:self.quitBtn];
    [self.quitBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
//    self.nameTF.borderStyle = UITextBorderStyleNone;
//    self.nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//    self.phoneTF.borderStyle = UITextBorderStyleNone;
//    self.phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//    self.carNumType.borderStyle = UITextBorderStyleNone;
//    self.carNumType.clearButtonMode = UITextFieldViewModeWhileEditing;
//    self.carTypeTF.borderStyle = UITextBorderStyleNone;
//    self.carTypeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//    
//    self.headerImgView.image = [UIImage imageWithContentsOfFile:self.user.headerPath];
//    self.nameTF.text = self.user.name;
//    self.phoneTF.text = self.user.phone;
//    self.carTypeTF.text = self.user.carType;
//    self.carNumType.text = self.user.carNum;
//    self.nameTF.delegate = self;
//    self.phoneTF.delegate = self;
//    self.carTypeTF.delegate = self;
//    self.carNumType.delegate = self;
//    
//    self.nameTF.tag = 1000;
//    self.phoneTF.tag = 1001;
//    self.carTypeTF.tag = 1002;
//    self.carNumType.tag = 1003;
    
    UIButton * leftNacBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNacBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftNacBtn setBackgroundImage:[UIImage imageNamed:@"left_nav_button"] forState:UIControlStateNormal];
    [leftNacBtn addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftNacBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.view addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeader)];
    self.headerImgView.userInteractionEnabled = YES;
    [self.headerImgView addGestureRecognizer:tap1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)backButtonPressed {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)tapClick {
    [self.nameTF resignFirstResponder];
    [self.phoneTF resignFirstResponder];
    [self.carNumType resignFirstResponder];
    [self.carTypeTF resignFirstResponder];
    [self.carModel resignFirstResponder];
    
    if (isMove) {
        [UIView animateWithDuration:0.25f animations:^{
            self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
        }];
        isMove = NO;
    }
}

- (void)tapHeader {
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [myActionSheet showInView:self.view];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    selectTag = (int)textField.tag;
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.nameTF resignFirstResponder];
    [self.phoneTF resignFirstResponder];
    [self.carNumType resignFirstResponder];
    [self.carTypeTF resignFirstResponder];
    [self.carModel resignFirstResponder];
    
    if (isMove) {
        [UIView animateWithDuration:0.25f animations:^{
            self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
        }];
        isMove = NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField.tag == 1000) {
        self.user.name = self.nameTF.text;
    } else if (textField.tag == 1001) {
        self.user.phone = self.phoneTF.text;
    } else if (textField.tag == 1002) {
        self.user.carType = self.carTypeTF.text;
        self.user.carNum = self.carNumType.text;
    } else if (textField.tag == 1003) {
        self.user.carType = self.carTypeTF.text;
    } else if (textField.tag == 1004) {
        self.user.carModel = self.carModel.text;
    }
    return YES;
}

- (void)keyboardWillShow:(NSNotification *)noti {
    NSDictionary *dic = [noti userInfo];
    UIView *textView = (UIView *)[self.view viewWithTag:selectTag+1000];
    
    NSLog(@"%f,%f",textView.frame.origin.y+textView.frame.size.height,self.view.frame.size.height-253);
    if (textView.frame.origin.y+textView.frame.size.height > self.view.frame.size.height-253) {
        isMove = YES;
        movingTag = selectTag;
        offset = self.view.frame.size.height-303-textView.frame.origin.y;
        [UIView animateWithDuration:0.25f animations:^{
            self.view.frame = CGRectMake(0, offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }
    
    switch (buttonIndex)
    {
        case 0:  //打开照相机拍照
            [self takePhoto];
            break;
            
        case 1:  //打开本地相册
            [self LocalPhoto];
            break;
    }
}



//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
        
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果
        
        self.headerImgView.image = image;
        self.user.headerPath = [NSString stringWithFormat:@"%@/Documents/header.png",NSHomeDirectory()];
        NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/header.png"];
        [UIImagePNGRepresentation(image) writeToFile:pngPath atomically:YES];
        // Create file manager
        NSError *error;
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        
        // Point to Document directory
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        // Write out the contents of home directory to console
        NSLog(@"Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateData" object:nil];
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)sendInfo
{
    NSLog(@"图片的路径是：%@", filePath);
}

- (UIView *)createNormaelTextFieldView:(NSString *)textType andPoint:(CGPoint)point andIsSecure:(BOOL)secure
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake((IPHONE_WIDTH - 300)/2, point.y, 300, 45)];
    
    UIImageView *imgview = [[UIImageView alloc]initWithFrame:view.bounds];
    imgview.userInteractionEnabled = YES;
    imgview.image = [UIImage imageNamed:@"normal_textfield"];
    [view addSubview:imgview];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 50, 30)];
    label.text = textType;
    label.font = Font(16);
    label.textColor = RGB_B(60, 160, 180);
    [view addSubview:label];
    
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(80, 8, 200, 30)];
    if ([textType isEqualToString:@"手机"]) {
        field.tag = 1001;
        field.delegate = self;
        field.text = self.user.phone;
        field.textColor = [UIColor colorWithRed:19/255.0f green:147/255.0f blue:178/255.0f alpha:1.0f];
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.phoneTF = field;
    } else if ([textType isEqualToString:@"车牌号"]) {
        field.tag = 1002;
        field.delegate = self;
        field.text = self.user.carNum;
        field.textColor = [UIColor colorWithRed:19/255.0f green:147/255.0f blue:178/255.0f alpha:1.0f];
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.carNumType = field;
    } else if ([textType isEqualToString:@"品牌"]) {
        field.tag = 1003;
        field.delegate = self;
        field.text = self.user.carType;
        field.textColor = [UIColor colorWithRed:19/255.0f green:147/255.0f blue:178/255.0f alpha:1.0f];
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.carTypeTF = field;
    } else if ([textType isEqualToString:@"车型"]) {
        field.tag = 1004;
        field.delegate = self;
        field.text = self.user.carModel;
        field.textColor = [UIColor colorWithRed:19/255.0f green:147/255.0f blue:178/255.0f alpha:1.0f];
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.carModel = field;
    }
    field.borderStyle = UITextBorderStyleNone;
    if (secure) {
        field.secureTextEntry = YES;
    }
    [view addSubview:field];
    
    return view;
}

- (void)btnAction {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:nil forKey:CurrentLoginUser];
    [appDelegate setupLoginRegistUI];
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
