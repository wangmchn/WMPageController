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

// 各个控制器的 class, 例如:[UITableViewController class]
// Each controller's class, example:[UITableViewController class]
@property (nonatomic, strong) NSArray *viewControllerClasses;

// 各个控制器标题, NSString
// Titles of view controllers in page controller. Use NSString.
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIViewController *currentViewController;

// 设置选中几号 item
// To select item at index
@property (nonatomic, assign) int selectIndex;

// 点击相邻的 MenuItem 是否触发翻页动画(当当前选中与点击Item相差大于1是不触发)
// Whether to animate when press the MenuItem
// When distant between the selected and the pressed is larger than 1,never animate.
@property (nonatomic, assign) BOOL pageAnimatable;

// 标题尺寸
// The title size
@property (nonatomic, assign) CGFloat titleSizeSelected;
@property (nonatomic, assign) CGFloat titleSizeNormal;

// 标题颜色, 请注意, 颜色必须要有 RGBA 分量.(比如 blackColor 和 grayColor 都不行，建议使用 RBGA 创建)
// The title color,the color is animatable, make sure they have RGBA components.
@property (nonatomic, strong) UIColor *titleColorSelected;
@property (nonatomic, strong) UIColor *titleColorNormal;

// 导航栏高度
// The menu view height
@property (nonatomic, assign) CGFloat menuHeight;

// 当所有item的宽度加起来小于屏幕宽时，PageController会自动帮助排版，添加每个item之间的间隙以填充整个宽度
// When the sum of all the item's width is smaller than the screen's width, pageController will add gap to each item automatically, in order to fill the width. so don 
// 每个 MenuItem 的宽度
// The item width,when all are same,use this property
@property (nonatomic, assign) CGFloat menuItemWidth;
// 各个 MenuItem 的宽度，可不等，数组内为 NSNumber
// Each item's width, when they are not all the same, use this property, Put `NSNumber` in this array.
@property (nonatomic, strong) NSArray *itemsWidths;

// 导航栏背景色
// The background color of menu view
@property (nonatomic, strong) UIColor *menuBGColor;

// 默认为无下划线
// Menu view's style, now has two different styles, 'Line','default'
@property (nonatomic, assign) WMMenuViewStyle menuViewStyle;

// 下划线的颜色，默认和选中颜色一致(如果不是 style 不为 line，则该属性无用)
// The line color,the default color is same with `titleColorSelected`.
// If you want to have a different color, set this property.
@property (nonatomic, strong) UIColor *lineColor;

// 是否发送在创建控制器或者视图完全展现在用户眼前时通知观察者，默认为不开启，如需利用通知请开启
// Whether notify observer when finish init or fully displayed to user, the default is NO.
@property (nonatomic, assign) BOOL postNotification;

/**
 *  构造方法，请使用该方法创建控制器 (此方法不重用控制器).
 *  Init method，recommend to use this instead of `-init` (not usable).
 *
 *  @param classes 子控制器的 class，确保数量与 titles 的数量相等
 *  @param titles  各个子控制器的标题，用 NSString 描述
 *
 *  @return instancetype
 */
- (instancetype)initWithViewControllerClasses:(NSArray *)classes andTheirTitles:(NSArray *)titles;
@end
