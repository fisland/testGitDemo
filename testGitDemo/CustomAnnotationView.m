//
//  CustomAnnotationView.m
//  CustomAnnotationDemo
//
//  Created by songjian on 13-3-11.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "CustomCalloutView.h"

#define kWidth  35.f
#define kHeight 50.f

#define kHoriMargin 5.f
#define kVertMargin 5.f

#define kPortraitWidth  50.f
#define kPortraitHeight 50.f

#define kCalloutWidth   220.0
#define kCalloutHeight  70.0

@interface CustomAnnotationView ()<UIActionSheetDelegate>

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation CustomAnnotationView

@synthesize calloutView;
@synthesize portraitImageView   = _portraitImageView;
@synthesize nameLabel           = _nameLabel;

#pragma mark - Handle Action

- (void)btnAction
{
    CLLocationCoordinate2D coorinate = [self.annotation coordinate];
    
    NSLog(@"coordinate = {%f, %f}", coorinate.latitude, coorinate.longitude);
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"开启导航" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"指令",@"百度地图导航",@"高德地图导航" ,nil];
    [actionSheet showInView:self.window];
}

#pragma mark - Override

- (NSString *)name
{
    return self.nameLabel.text;
}

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}

- (UIImage *)portrait
{
    return self.portraitImageView.image;
}

- (void)setPortrait:(UIImage *)portrait
{
    self.portraitImageView.image = portrait;
}

- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            /* Construct custom callout. */
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,-CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
//            self.calloutView.backgroundColor = RGB_B(60, 160, 180);
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake(10, 10, 40, 40);
            [btn setTitle:@"导航" forState:UIControlStateNormal];
            btn.layer.cornerRadius = 5;
            btn.clipsToBounds = YES;
            [btn setTitleColor:RGB_B(60, 160, 180) forState:UIControlStateNormal];
            [btn setBackgroundColor:WhiteColor];
            [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
            
            [self.calloutView addSubview:btn];
            
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(50+10, 15, 150, 30)];
            name.backgroundColor = [UIColor clearColor];
            name.textColor = [UIColor whiteColor];
            name.text = @"约需6分钟完成洗车";
            [self.calloutView addSubview:name];
        }
        
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    /* Points that lie outside the receiver’s bounds are never reported as hits,
     even if they actually lie within one of the receiver’s subviews.
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    if (!inside && self.selected)
    {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    
    return inside;
}

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, kWidth, kHeight);
        
        self.backgroundColor = [UIColor clearColor];
        self.portraitImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:self.portraitImageView];
    }
    
    return self;
}
#pragma mark - actionsheet delegate 
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *string = nil;
    NSString *urlString = @"http://api.map.baidu.com/direction?origin=latlng:22.536548,113.90797999999999|name:我家&destination=世界之窗&mode=driving&region=深圳&output=html&src=yourCompanyName|yourAppName" ;
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    switch (buttonIndex) {
        case 0:
        {
            string = @"请开到合适的位置，开始自动洗车";
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:string delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }
            break;
        case 1:
        {
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication]openURL:url];
            }
//            string = @"开始百度地图导航";
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:string delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
//            [alert show];
        }
            break;
        case 2:
        {
            string = @"开始高德地图导航";
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:string delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }
            break;
        default:
            break;
    }
    
   
}
@end
