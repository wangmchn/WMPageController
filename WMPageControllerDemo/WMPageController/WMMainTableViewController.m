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
                    @"WMMenuViewStyleFloodHollow"];
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
    } else if ([self.styles[indexPath.row] isEqualToString:@"WMMenuViewStyleLine"]) {
        // 下划线
        pageController.title = @"Line";
        pageController.menuViewStyle = WMMenuViewStyleLine;
        pageController.titleSizeSelected = 15;
    } else if ([self.styles[indexPath.row] isEqualToString:@"WMMenuViewStyleFlood"]) {
        // 涌入
        pageController = [self pageControllerStyleFlood];
        pageController.title = @"Flood";
        //MARK:控制器传值 / KVC 第一个控制器是 Table / view / Collection
        pageController.values = @[@22, @{@"name":@"Mark", @"age": @22}, @"Mark"];
        pageController.keys = @[@"age", @"model",@"name"];
//        pageController.viewFrame = CGRectMake(0, 100, 320, 400);
        
        //MARK:Example of reload data. / 刷新WMPageController
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            pageController.viewControllerClasses = @[[WMTableViewController class], [WMViewController class], [WMCollectionViewController class], [WMTableViewController class], [WMViewController class], [WMCollectionViewController class]];
//            pageController.titles = @[@"通知", @"赞与感谢", @"私信", @"通知", @"赞与感谢", @"私信"];
//        pageController.values = @[@22, @{@"name":@"Mark", @"age": @22}, @"Mark",@22, @{@"name":@"Mark", @"age": @22}, @"Mark"];
//        pageController.keys = @[@"age", @"model",@"name",@"age", @"model",@"name"];
//            pageController.itemsWidths = @[@(70),@(100),@(70),@(70),@(100),@(70)];
//            [pageController reloadData];
//        });
        
    } else if ([self.styles[indexPath.row] isEqualToString:@"WMMenuViewStyleFloodHollow"]) {
        // 涌入/空心
        pageController.title = @"Hollow";
        pageController.menuViewStyle = WMMenuViewStyleFooldHollow;
        pageController.titleSizeSelected = 15;
    }
    [self.navigationController pushViewController:pageController animated:YES];
}

- (WMPageController *)p_defaultController {
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
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
    pageVC.pageAnimatable = YES;
    pageVC.menuItemWidth = 85;
    pageVC.postNotification = YES;
    pageVC.bounces = YES;
    return pageVC;
}

- (WMPageController *)pageControllerStyleFlood {
    NSArray *viewControllers = @[[WMTableViewController class], [WMViewController class], [WMCollectionViewController class]];
    NSArray *titles = @[@"通知", @"赞与感谢", @"私信"];
    
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC.titleSizeSelected = 15;
    pageVC.pageAnimatable = YES;
    pageVC.menuViewStyle = WMMenuViewStyleFoold;
    pageVC.titleColorSelected = [UIColor whiteColor];
    pageVC.titleColorNormal = [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1];
    pageVC.progressColor = [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1];
    pageVC.itemsWidths = @[@(70),@(100),@(70)]; // 这里可以设置不同的宽度
    return pageVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
