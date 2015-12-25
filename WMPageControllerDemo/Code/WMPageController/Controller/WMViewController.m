//
//  WMViewController.m
//  WMPageController
//
//  Created by Mark on 15/6/13.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WMViewController.h"

@interface WMViewController ()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *label;
@end

@implementation WMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 180)];
    imageView.image = [UIImage imageNamed:@"hitMark.jpg"];
    self.imageView = imageView;
    [self.view addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, self.view.frame.size.width, 120)];
    label.text = @"Hey,\ndo you have any suggestions?\nPlease contact me.\n:)";
    label.numberOfLines = 0;
    label.font = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:20];
    self.label = label;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    NSLog(@"%@",self.model);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.label.frame = CGRectMake(0, 180, self.view.frame.size.width, 120);
    self.imageView.frame = CGRectMake((self.view.frame.size.width-200)/2.0, 10, 200, 180);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
