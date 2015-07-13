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
- (NSArray *)styles{
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WMPageController *pageController = [self getDefaultController];
    if ([self.styles[indexPath.row] isEqualToString:@"WMMenuViewStyleDefault"]) {
        // 默认
        pageController.title = @"Default";
    }else if ([self.styles[indexPath.row] isEqualToString:@"WMMenuViewStyleLine"]){
        // 下划线
        pageController.title = @"Line";
        pageController.menuViewStyle = WMMenuViewStyleLine;
        pageController.titleSizeSelected = 15;
    }else if ([self.styles[indexPath.row] isEqualToString:@"WMMenuViewStyleFlood"]){
        // 涌入
        pageController = [self pageControllerStyleFlood];
        pageController.title = @"Flood";
    }else if ([self.styles[indexPath.row] isEqualToString:@"WMMenuViewStyleFloodHollow"]){
        // 涌入/空心
        pageController.title = @"Hollow";
        pageController.menuViewStyle = WMMenuViewStyleFooldHollow;
        pageController.titleSizeSelected = 15;
    }
    // 等待新样式
    // ...
    [self.navigationController pushViewController:pageController animated:YES];
}

- (WMPageController *)getDefaultController{
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        Class vcClass;
        NSString *title;
        switch (i%3) {
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
    return pageVC;
}
- (WMPageController *)pageControllerStyleFlood{
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        Class vcClass;
        NSString *title;
        switch (i%3) {
            case 0:
                vcClass = [WMTableViewController class];
                title = @"通知";
                break;
            case 1:
                vcClass = [WMViewController class];
                title = @"赞与感谢";
                break;
            default:
                vcClass = [WMCollectionViewController class];
                title = @"私信";
                break;
        }
        [viewControllers addObject:vcClass];
        [titles addObject:title];
    }
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC.titleSizeSelected = 15;
    pageVC.pageAnimatable = YES;
    pageVC.menuViewStyle = WMMenuViewStyleFoold;
    pageVC.titleColorSelected = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    pageVC.titleColorNormal = [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1];
    pageVC.progressColor = [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1];
    pageVC.rememberLocation = YES;
    
    pageVC.itemsWidths = @[@(70),@(100),@(70)]; // 这里可以设置不同的宽度
    return pageVC;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
