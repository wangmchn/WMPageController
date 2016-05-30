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

@interface WMCustomPageController () {
    BOOL _update;
}
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
    [self addViews];
}

- (void)addViews {
    UIButton *leftView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, self.menuHeight)];
    [leftView setTitle:@"Left" forState:UIControlStateNormal];
    [leftView setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [leftView addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.menuView.leftView = leftView;
    
    UIButton *rightView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, self.menuHeight)];
    [rightView setTitle:@"Right" forState:UIControlStateNormal];
    [rightView setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rightView addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.menuView.rightView = rightView;
    
    self.menuView.contentMargin = 10;
}

- (void)buttonPressed:(UIButton *)sender {
    NSLog(@"%@", sender);
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

- (UIView *)menuView:(WMMenuView *)menu badgeViewAtIndex:(NSInteger)index {
    if (_update) {
        return nil;
    }
    UIView *badgeView = [[UIView alloc] initWithFrame:CGRectMake(60 - 5, 2, 5, 5)];
    badgeView.layer.cornerRadius = 2.5;
    badgeView.layer.masksToBounds = YES;
    badgeView.backgroundColor = [UIColor purpleColor];
    return badgeView;
}

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    NSInteger index = [info[@"index"] integerValue];
    _update = YES;
    [self.menuView updateBadgeViewAtIndex:index];
}

@end
