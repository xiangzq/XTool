//
//  XViewController.m
//  XTool
//
//  Created by xiangzq on 01/28/2021.
//  Copyright (c) 2021 xiangzq. All rights reserved.
//

#import "XViewController.h"
//#import <XTool/XTool.h>
#import "XTool.h"
@interface XViewController ()
@property (nonatomic,strong) NSArray *arr;
@end

@implementation XViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    CGRect bounds = [UIScreen mainScreen].bounds;
    NSString *urlString = @"https://lmg.jj20.com/up/allimg/4k/s/02/2109242332225H9-0-lp.jpg";

    UIImageView *imageV1 = [UIImageView new];
    imageV1.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height/2);
    [self.view addSubview:imageV1];
    
    UIImageView *imageV2 = [UIImageView new];
    imageV2.frame = CGRectMake(0, bounds.size.height/2 + 10, bounds.size.width, bounds.size.height/2);
    [self.view addSubview:imageV2];
    
    UIImage *image1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    UIImage *image2 = [UIImage downsampleWithImageURL:[NSURL URLWithString:urlString] PointSize:imageV2.bounds.size Scale:0.5];
    
    imageV1.image = image1;
    imageV2.image = image2;
    
    NSLog(@"1  %.2f %.2f",image1.size.width,image1.size.height);
    NSLog(@"2  %.2f %.2f",image2.size.width,image1.size.height);
}



@end
