//
//  WMCustomPageController.m
//  Use Datasource
//
//  Created by Mark on 16/1/3.
//  Copyright © 2016年 Wecan Studio. All rights reserved.
//

#import "WMCustomPageController.h"
#import "WMViewController.h"
#import "WMTableViewController.h"
#import "WMBlankViewController.h"

@interface WMCustomPageController ()

@end

@implementation WMCustomPageController

- (instancetype)init {
    if (self = [super init]) {
        self.menuHeight = 40.0;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = 60;
    }
    return self;
}

- (NSArray *)titles {
    return @[@"自己", @"实现", @"数据源"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WMPageControllerDataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    switch (index) {
        case 0: {
            WMViewController *vc = [[WMViewController alloc] init];
            vc.age = @22;
            return vc;
        }
            break;
        case 1: {
            WMTableViewController *vc = [[WMTableViewController alloc] initWithStyle:UITableViewStylePlain];
            vc.name = @"Mark";
            vc.desc = @"I will be happy if you star this repo.";
            return vc;
        }
        default: {
            return [[WMBlankViewController alloc] init];
        }
            break;
    }
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titles[index];
}

//- (void)pageController:(WMPageController *)pageController lazyLoadViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
//    NSLog(@"%@", info);
//}

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    NSLog(@"%@", info);
}

@end
