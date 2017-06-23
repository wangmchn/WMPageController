//
//  WMMainTableViewController.m
//  WMPageControllerExample
//
//  Created by Mark on 2017/6/21.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "WMMainTableViewController.h"
#import "WMCustomizedPageController.h"

@interface WMMainTableViewController ()
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSDictionary *stylesMap;
@end

@implementation WMMainTableViewController

- (NSArray *)titles {
    if (_titles == nil) {
        _titles = @[@"WMMenuViewStyleDefault",
                    @"WMMenuViewStyleLine",
                    @"WMMenuViewStyleFlood",
                    @"WMMenuViewStyleFloodHollow",
                    @"WMMenuViewShowOnNav",
                    @"WMMenuViewStyleSegmented",
                    @"WMMenuViewStyleTriangle",
                    @"WMMenuViewStyleNaughty",
                    @"WMMenuViewCornerRadius",
                    @"WMMenuViewPositionBottom"];
    }
    return _titles;
}

- (NSDictionary *)stylesMap {
    if (!_stylesMap) {
        _stylesMap = @{@"WMMenuViewStyleDefault": @(WMMenuViewStyleDefault),
                       @"WMMenuViewStyleLine": @(WMMenuViewStyleLine),
                       @"WMMenuViewStyleFlood": @(WMMenuViewStyleFlood),
                       @"WMMenuViewStyleFloodHollow": @(WMMenuViewStyleFloodHollow),
                       @"WMMenuViewShowOnNav": @(WMMenuViewStyleFlood),
                       @"WMMenuViewStyleSegmented": @(WMMenuViewStyleSegmented),
                       @"WMMenuViewStyleTriangle": @(WMMenuViewStyleTriangle),
                       @"WMMenuViewStyleNaughty": @(WMMenuViewStyleLine),
                       @"WMMenuViewCornerRadius": @(WMMenuViewStyleFlood),
                       @"WMMenuViewPositionBottom": @(WMMenuViewStyleDefault)};
    }
    return _stylesMap;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const cellIdentifier = @"WMMainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = self.titles[indexPath.row];
    WMMenuViewStyle style = [self.stylesMap[key] integerValue];
    
    WMCustomizedPageController *vc = [[WMCustomizedPageController alloc] init];
    vc.title = key;
    vc.menuViewStyle = style;
    vc.automaticallyCalculatesItemWidths = YES;
    if ([key isEqualToString:@"WMMenuViewStyleNaughty"]) {
        vc.progressViewIsNaughty = YES;
        vc.progressWidth = 10;
    }
    if ([key isEqualToString:@"WMMenuViewCornerRadius"]) {
        vc.progressViewCornerRadius = 5.0f;
    }
    if ([key isEqualToString:@"WMMenuViewPositionBottom"]) {
        vc.menuViewPosition = WMMenuViewPositionBottom;
    }
    [self customizePageController:vc];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)customizePageController:(WMPageController *)vc {
    switch (vc.menuViewStyle) {
        case WMMenuViewStyleSegmented:
        case WMMenuViewStyleFlood: {
            vc.titleColorSelected = [UIColor whiteColor];
            vc.titleColorNormal = [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1];
            vc.progressColor = [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1];
            vc.showOnNavigationBar = YES;
            vc.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
            vc.titleSizeSelected = 15;
        }
            break;
        case WMMenuViewStyleTriangle: {
            vc.progressWidth = 6;
            vc.progressHeight = 4;
            vc.titleSizeSelected = 15;
        }
            break;
        case WMMenuViewStyleDefault: {
            vc.titleSizeSelected = 16;
        }
            break;
        default:
            break;
    }
}

@end
