//
//  WMViewController.m
//  WMPageController
//
//  Created by Mark on 15/6/13.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WMViewController.h"

@interface WMViewController ()
@end

@implementation WMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 180)];
    imageView.image = [UIImage imageNamed:@"hitMark.jpg"];
    imageView.center = CGPointMake(self.view.center.x, 100);
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, self.view.frame.size.width, 120)];
    label.text = @"Hey,\ndo you have any suggestions?\nPlease contact me.\n:)";
    label.numberOfLines = 0;
    label.font = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:20];
    
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    NSLog(@"%@ destroyed",[self class]);
}
@end
