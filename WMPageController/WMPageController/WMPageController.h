//
//  WMPageController.h
//  WMPageController
//
//  Created by Mark on 15/6/11.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMMenuView.h"

@interface WMPageController : UIViewController
// 各个控制器的class,例如:[UITableViewController class]
@property (nonatomic, strong) NSArray *viewControllerClasses;
// 各个控制器标题,NSString
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, assign) int selectedIndex;
// 点击相邻的MenuItem是否触发翻页动画(当当前选中与点击Item相差大于1是不触发)
@property (nonatomic, assign) BOOL pageAnimatable;
// 标题尺寸
@property (nonatomic, assign) CGFloat titleSizeSelected;
@property (nonatomic, assign) CGFloat titleSizeNormal;
// 标题颜色
@property (nonatomic, strong) UIColor *titleColorSelected;
@property (nonatomic, strong) UIColor *titleColorNormal;
// 导航栏高度
@property (nonatomic, assign) CGFloat menuHeight;
// 每个MenuItem的宽度
@property (nonatomic, assign) CGFloat menuItemWidth;
// 导航栏背景色
@property (nonatomic, strong) UIColor *menuBGColor;
// init方法,请使用该方法创建控制器
- (instancetype)initWithViewControllerClasses:(NSArray *)classes andTheirTitles:(NSArray *)titles;
@end
