//
//  WMTableViewController.m
//  WMPageController
//
//  Created by Mark on 15/6/13.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WMTableViewController.h"
#import "WMLoopView.h"
#import "WMPageConst.h"
#import "WMMainTableViewController.h"
@interface WMTableViewController () <WMLoopViewDelegate>

@end

@implementation WMTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.showsVerticalScrollIndicator = NO;
    NSArray *images = @[@"zoro.jpg",@"three.jpg",@"onepiece.jpg"];
    WMLoopView *loopView = [[WMLoopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/1.8) images:images autoPlay:YES delay:10.0];
    loopView.delegate = self;
    self.tableView.tableHeaderView = loopView;
    self.tableView.rowHeight = 80;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];

}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WMCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"WMCell"];
    }
    cell.textLabel.text = @"Hello,I'm Mark.";
    cell.detailTextLabel.text = @"And I'm now a student.";
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.imageView.image = [UIImage imageNamed:@"github.png"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WMMainTableViewController *main = [[WMMainTableViewController alloc] init];
    NSLog(@"%@",[self.navigationController description]);
    [self.navigationController pushViewController:main animated:YES];
}
- (void)dealloc{
    NSLog(@"%@ destroyed",[self class]);
}
@end
