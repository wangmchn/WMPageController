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
// each controller's class ,example:[UITableViewController class]
@property (nonatomic, strong) NSArray *viewControllerClasses;

// 各个控制器标题,NSString
// titles of view controllers in page controller. Use NSString.
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIViewController *currentViewController;
// 设置选中几号item
// to select item at index
@property (nonatomic, assign) int selectIndex;

// 点击相邻的MenuItem是否触发翻页动画(当当前选中与点击Item相差大于1是不触发)
// whether to animate when press the MenuItem
// when distant between the selected and the pressed is larger than 1,never animate.
@property (nonatomic, assign) BOOL pageAnimatable;

// 标题尺寸
// the title size
@property (nonatomic, assign) CGFloat titleSizeSelected;
@property (nonatomic, assign) CGFloat titleSizeNormal;

// 标题颜色,请注意, 颜色必须要有RGBA分量.(比如blackColor和grayColor都不像，建议使用RBGA创建)
// the title color,the color is animatable, make sure they have RGBA components.
@property (nonatomic, strong) UIColor *titleColorSelected;
@property (nonatomic, strong) UIColor *titleColorNormal;

// 导航栏高度
// the menu view height
@property (nonatomic, assign) CGFloat menuHeight;

// 每个MenuItem的宽度
// the item width,when all are same,use this property
@property (nonatomic, assign) CGFloat menuItemWidth;

// 各个MenuItem的宽度，可不等，数组内为NSNumber
// each item's width, when they are not all the same, use this property, Put NSNumber in this array.
@property (nonatomic, strong) NSArray *itemsWidths;

// 导航栏背景色
// the background color of menu view
@property (nonatomic, strong) UIColor *menuBGColor;

// 默认为无下划线
// menu view's style, now has tow different style,'Line','default'
@property (nonatomic, assign) WMMenuViewStyle menuViewStyle;

// init方法,请使用该方法创建控制器
// init method
- (instancetype)initWithViewControllerClasses:(NSArray *)classes andTheirTitles:(NSArray *)titles;
@end
