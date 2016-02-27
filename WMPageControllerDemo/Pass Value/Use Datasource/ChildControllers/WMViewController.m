//
//  WMViewController.m
//  Use Datasource
//
//  Created by Mark on 16/1/3.
//  Copyright © 2016年 Wecan Studio. All rights reserved.
//

#import "WMViewController.h"

@interface WMViewController ()

@end

@implementation WMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"I'm %@ year old", self.age];
    [label sizeToFit];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = self.view.center;
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
