//
//  WMViewController.m
//  Use Datasource
//
//  Created by Mark on 16/1/3.
//  Copyright © 2016年 Wecan Studio. All rights reserved.
//

#import "WMViewController.h"

@interface WMViewController () {
    UILabel *_label;
}
@end

@implementation WMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _label = [[UILabel alloc] init];
    _label.text = [NSString stringWithFormat:@"I'm %@ year old", self.age];
    [_label sizeToFit];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _label.center = self.view.center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"----------");
}

@end
