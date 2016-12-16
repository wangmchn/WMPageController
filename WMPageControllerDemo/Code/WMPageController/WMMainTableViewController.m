//
//  WMMainTableViewController.m
//  WMPageController
//
//  Created by Mark on 15/7/13.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WMMainTableViewController.h"
#import "WMPageController.h"
#import "WMTableViewController.h"
#import "WMViewController.h"
#import "WMCollectionViewController.h"

@interface WMMainTableViewController ()
@property (nonatomic, strong) NSArray *styles;
@end

@implementation WMMainTableViewController
- (NSArray *)styles {
    if (_styles == nil) {
        _styles = @[@"WMMenuViewStyleDefault",
                    @"WMMenuViewStyleLine",
                    @"WMMenuViewStyleFlood",
                    @"WMMenuViewStyleFloodHollow",
                    @"WMMenuViewShowOnNav",
                    @"WMMenuViewStyleSegmented",
                    @"WMMenuViewStyleTriangle",
                    @"WMMenuViewStyleNaughty"];
    }
    return _styles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.styles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const cellIdentifier = @"WMMainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.styles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WMPageController *pageController = [self p_defaultController];
    if ([self.styles[indexPath.row] isEqualToString:@"WMMenuViewStyleDefault"]) {
        // 默认
        pageController.title = @"Default";
        pageController.preloadPolicy = WMPageControllerPreloadPolicyNeighbour;
    
    } else if ([self.styles[indexPath.row] isEqualToString:@"WMMenuViewStyleLine"]) {
        // 下划线
        pageController.title = @"Line";
        pageController.menuViewStyle = WMMenuViewStyleLine;
        pageController.titleSizeSelected = 15;
        pageController.selectIndex = 3;
    } else if ([self.styles[indexPath.row] isEqualToString:@"WMMenuViewStyleFlood"]) {
        // 涌入
        pageController = [self pageControllerStyleFlood];
        pageController.title = @"Flood";
        //MARK:控制器传值 / KVC 第一个控制器是 Table / view / Collection
        pageController.values = @[@22, @{@"name":@"Mark", @"age": @22}, @"Mark"].mutableCopy;
        pageController.keys = @[@"age", @"model",@"name"].mutableCopy;
        pageController.selectIndex = 1;
    } else if ([self.styles[indexPath.row] isEqualToString:@"WMMenuViewStyleFloodHollow"]) {
        // 涌入/空心
        pageController.title = @"Hollow";
        pageController.menuViewStyle = WMMenuViewStyleFloodHollow;
        pageController.titleSizeSelected = 15;
    } else if ([self.styles[indexPath.row] isEqualToString:@"WMMenuViewShowOnNav"]) {
        //在导航栏上展示
        pageController.menuHeight = 44;
        pageController.menuViewStyle = WMMenuViewStyleLine;
        pageController.titleSizeSelected = 15;
        pageController.showOnNavigationBar = YES;
        pageController.menuBGColor = [UIColor clearColor];
        pageController.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
    } else if ([self.styles[indexPath.row] isEqualToString:@"WMMenuViewStyleSegmented"]) {
        // 网易新闻
        pageController = [self pageControllerStyleFlood];
        pageController.menuHeight = 44;
        pageController.showOnNavigationBar = YES;
        pageController.titleSizeSelected = 15;
        pageController.menuViewStyle = WMMenuViewStyleSegmented;
        pageController.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
        pageController.titleColorSelected = [UIColor whiteColor];
        pageController.titleColorNormal = [UIColor blackColor];
        pageController.progressColor = [UIColor blackColor];
        pageController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    } else if ([self.styles[indexPath.row] isEqualToString:@"WMMenuViewStyleTriangle"]) {
        pageController.progressHeight = 5;
        
        pageController.progressWidth = 10;
        pageController.menuViewStyle = WMMenuViewStyleTriangle;
        pageController.titleSizeSelected = 15;

    } else if ([self.styles[indexPath.row] isEqualToString:@"WMMenuViewStyleNaughty"]) {
        pageController.title = @"Line";
        pageController.menuViewStyle = WMMenuViewStyleLine;
        pageController.titleSizeSelected = 15;
        pageController.progressWidth = 10;
        pageController.progressViewIsNaughty = YES;
    }
    
    [self.navigationController pushViewController:pageController animated:YES];
}

- (WMPageController *)p_defaultController {
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 9; i++) {
        Class vcClass;
        NSString *title;
        switch (i % 3) {
            case 0:
                vcClass = [WMTableViewController class];
                title = @"Greetings";
                break;
            case 1:
                vcClass = [WMViewController class];
                title = @"Hit Me";
                break;
            default:
                vcClass = [WMCollectionViewController class];
                title = @"Fluency";
                break;
        }
        [viewControllers addObject:vcClass];
        [titles addObject:title];
    }
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC.menuItemWidth = 85;
    pageVC.postNotification = YES;
    pageVC.bounces = YES;
    pageVC.hidesBottomBarWhenPushed = YES;
    return pageVC;
}

- (WMPageController *)pageControllerStyleFlood {
    NSArray *viewControllers = @[[WMTableViewController class], [WMViewController class], [WMCollectionViewController class]];
    NSArray *titles = @[@"通知", @"赞与感谢", @"私信"];
    
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC.titleSizeSelected = 15;
    pageVC.pageAnimatable = YES;
    pageVC.menuViewStyle = WMMenuViewStyleFlood;
    pageVC.titleColorSelected = [UIColor whiteColor];
    pageVC.titleColorNormal = [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1];
    pageVC.progressColor = [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1];
    pageVC.itemsWidths = @[@(70),@(100),@(70)]; // 这里可以设置不同的宽度
    pageVC.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
//    pageVC.menuViewStyle = WMMenuViewStyleSegmented;
    return pageVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
