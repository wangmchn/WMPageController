//
//  WMHomeViewController.m
//  Demo
//
//  Created by Mark on 16/7/25.
//  Copyright © 2016年 Wecan Studio. All rights reserved.
//

#import "WMHomeViewController.h"
#import "WMTableViewController.h"

@interface WMHomeViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSArray *musicCategories;
@end

@implementation WMHomeViewController

- (NSArray *)musicCategories {
    if (!_musicCategories) {
        _musicCategories = @[@"单曲", @"详情", @"歌词"];
    }
    return _musicCategories;
}

- (instancetype)init {
    if (self = [super init]) {
        self.titleSizeNormal = 15;
        self.titleSizeSelected = 15;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.musicCategories.count;
        self.menuHeight = 50;
        self.viewTop = kNavigationBarHeight + kWMHeaderViewHeight;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"专辑";
}


// MARK: ChangeViewFrame (Animatable)
- (void)setViewTop:(CGFloat)viewTop {
    
    _viewTop = viewTop;
    
    if (_viewTop <= kNavigationBarHeight) {
        _viewTop = kNavigationBarHeight;
    }
    
    if (_viewTop > kWMHeaderViewHeight + kNavigationBarHeight) {
        _viewTop = kWMHeaderViewHeight + kNavigationBarHeight;
    }
    
    self.viewFrame = CGRectMake(0, _viewTop, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - _viewTop);
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
    WMTableViewController *vc = [[WMTableViewController alloc] init];
    return vc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.musicCategories[index];
}

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    NSLog(@"%@",viewController);
    WMTableViewController *vc = (WMTableViewController *)viewController;
    NSLog(@"%@", NSStringFromCGPoint(vc.tableView.contentOffset));
    
    vc.tableView.contentOffset = CGPointMake(0, kNavigationBarHeight + kWMHeaderViewHeight - self.viewTop);
}

@end
