//
//  CustomPageViewController.m
//  Storyboard
//
//  Created by Mark on 15/12/5.
//  Copyright © 2015年 Wecan Studio. All rights reserved.
//

#import "CustomPageViewController.h"
#import "WMViewController.h"

@interface CustomPageViewController ()

@end

@implementation CustomPageViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSArray *viewControllerClasses = @[[WMViewController class], [WMViewController class], [WMViewController class]];
        NSArray *titles = @[@"你好", @"支持我", @"点赞"];
        self.viewControllerClasses = viewControllerClasses;
        self.titles = titles;
        self.menuItemWidth = 60;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.titleSizeSelected = 15.0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
