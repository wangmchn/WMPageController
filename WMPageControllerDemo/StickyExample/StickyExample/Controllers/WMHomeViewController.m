//
//  WMHomeViewController.m
//  Demo
//
//  Created by Mark on 16/7/25.
//  Copyright © 2016年 Wecan Studio. All rights reserved.
//

#import "WMHomeViewController.h"
#import "WMTableViewController.h"
#import "WMDetailViewController.h"

static CGFloat const kWMMenuViewHeight = 44.0;
@interface WMHomeViewController ()
@property (nonatomic, strong) NSArray *musicCategories;
@property (nonatomic, strong) UIView *redView;
@end

@implementation WMHomeViewController

- (instancetype)init {
    if (self = [super init]) {
        self.titleSizeNormal = 15;
        self.titleSizeSelected = 15;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.musicCategories.count;
        self.titleColorSelected = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
        self.titleColorNormal = [UIColor colorWithRed:0.4 green:0.8 blue:0.1 alpha:1.0];
        
        self.menuViewHeight = kWMMenuViewHeight;
        self.headerViewHeight = kWMHeaderViewHeight;
        self.minimumTopInset = kNavigationBarHeight;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"专辑";
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kWMHeaderViewHeight)];
    redView.backgroundColor = [UIColor redColor];
    self.redView = redView;
    [self.view addSubview:self.redView];
}

- (void)btnClicked:(id)sender {
    NSLog(@"touch up inside");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.musicCategories.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return [WMTableViewController new];
        case 1:{
            return [WMDetailViewController new];
        }
        default:
            return [UIViewController new];
    }
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.musicCategories[index];
}

#pragma mark - lazy
- (NSArray *)musicCategories {
    if (!_musicCategories) {
        _musicCategories = @[@"单曲", @"详情", @"歌词"];
    }
    return _musicCategories;
}

@end
