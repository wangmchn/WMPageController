//
//  WMPageController.h
//  WMPageController
//
//  Created by Mark on 15/6/11.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMMenuView.h"
#import "WMScrollView.h"
@class WMPageController;

/*
 *  WMPageController 的缓存设置，默认缓存为无限制，当收到 memoryWarning 时，会自动切换到低缓存模式 (WMPageControllerCachePolicyLowMemory)，并在一段时间后切换到 High .
    收到多次警告后，会停留在到 WMPageControllerCachePolicyLowMemory 不再增长
 *
 *  The Default cache policy is No Limit, when recieved memory warning, page controller will switch mode to 'LowMemory'
    and continue to grow back after a while.
    If recieved too much times, the cache policy will stay at 'LowMemory' and don't grow back any more.
 */
typedef NS_ENUM(NSUInteger, WMPageControllerCachePolicy) {
    WMPageControllerCachePolicyNoLimit   = 0,  // No limit
    WMPageControllerCachePolicyLowMemory = 1,  // Low Memory but may block when scroll
    WMPageControllerCachePolicyBalanced  = 3,  // Balanced ↑ and ↓
    WMPageControllerCachePolicyHigh      = 5   // High
};

@protocol WMPageControllerDataSource <NSObject>
@optional

/**
 *  To inform how many child controllers will in `WMPageController`.
 *
 *  @param pageController The parent controller.
 *
 *  @return The value of child controllers's count.
 */
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController;

/**
 *  Return a controller that you wanna to display at index. You can set properties easily if you implement this methods.
 *
 *  @param pageController The parent controller.
 *  @param index          The index of child controller.
 *
 *  @return The instance of a `UIViewController`.
 */
- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index;

/**
 *  Each title you wanna show in the `WMMenuView`
 *
 *  @param pageController The parent controller.
 *  @param index          The index of title.
 *
 *  @return A `NSString` value to show at the top of `WMPageController`.
 */
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index;

@end

@protocol WMPageControllerDelegate <NSObject>
@optional

/**
 *  Called when a viewController will be cached. You can clear some data if it's not reusable.
 *
 *  @param pageController The parent controller (WMPageController)
 *  @param viewController The viewController will be cached.
 *  @param info           A dictionary that includes some infos, such as: `index` / `title`
 */
- (void)pageController:(WMPageController *)pageController willCachedViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info;

/**
 *  Called when a viewController will be appear to user's sight. Do some preparatory methods if needed.
 *
 *  @param pageController The parent controller (WMPageController)
 *  @param viewController The viewController will appear.
 *  @param info           A dictionary that includes some infos, such as: `index` / `title`
 */
- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info;

/**
 *  Called when a viewController will fully displayed, that means, scrollView have stopped scrolling and the controller's view have entirely displayed.
 *
 *  @param pageController The parent controller (WMPageController)
 *  @param viewController The viewController entirely displayed.
 *  @param info           A dictionary that includes some infos, such as: `index` / `title`
 */
- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info;

@end

@interface WMPageController : UIViewController <WMMenuViewDelegate, WMMenuViewDataSource, UIScrollViewDelegate, WMPageControllerDataSource, WMPageControllerDelegate>

@property (nonatomic, weak) id<WMPageControllerDelegate> delegate;
@property (nonatomic, weak) id<WMPageControllerDataSource> dataSource;

/**
 *  Values and keys can set properties when initialize child controlelr (it's KVC)
 *  values keys 属性可以用于初始化控制器的时候为控制器传值(利用 KVC 来设置)
    使用时请确保 key 与控制器的属性名字一致！！(例如：控制器有需要设置的属性 type，那么 keys 所放的就是字符串 @"type")
 */
@property (nonatomic, strong) NSMutableArray<id> *values;
@property (nonatomic, strong) NSMutableArray<NSString *> *keys;

/**
 *  各个控制器的 class, 例如:[UITableViewController class]
 *  Each controller's class, example:[UITableViewController class]
 */
@property (nonatomic, copy) NSArray<Class> *viewControllerClasses;

/**
 *  各个控制器标题
 *  Titles of view controllers in page controller.
 */
@property (nonatomic, copy) NSArray<NSString *> *titles;
@property (nonatomic, strong, readonly) UIViewController *currentViewController;

/**
 *  设置选中几号 item
 *  To select item at index
 */
@property (nonatomic, assign) int selectIndex;

/**
 *  点击相邻的 MenuItem 是否触发翻页动画 (当当前选中与点击Item相差大于1是不触发)
 *  Whether to animate when press the MenuItem, if distant between the selected and the pressed is larger than 1,never animate.
 */
@property (nonatomic, assign) BOOL pageAnimatable;

/**
 *  选中时的标题尺寸
 *  The title size when selected (animatable)
 */
@property (nonatomic, assign) CGFloat titleSizeSelected;

/**
 *  非选中时的标题尺寸
 *  The normal title size (animatable)
 */
@property (nonatomic, assign) CGFloat titleSizeNormal;

/**
 *  标题选中时的颜色, 颜色是可动画的.
 *  The title color when selected, the color is animatable.
 */
@property (nonatomic, strong) UIColor *titleColorSelected;

/**
 *  标题非选择时的颜色, 颜色是可动画的.
 *  The title's normal color, the color is animatable.
 */
@property (nonatomic, strong) UIColor *titleColorNormal;

/**
 *  标题的字体名字
 *  The name of title's font
 */
@property (nonatomic, copy) NSString *titleFontName;

/**
 *  导航栏高度
 *  The menu view's height
 */
@property (nonatomic, assign) CGFloat menuHeight;

// 当所有item的宽度加起来小于屏幕宽时，PageController会自动帮助排版，添加每个item之间的间隙以填充整个宽度
// When the sum of all the item's width is smaller than the screen's width, pageController will add gap to each item automatically, in order to fill the width.

/**
 *  每个 MenuItem 的宽度
 *  The item width,when all are same,use this property
 */
@property (nonatomic, assign) CGFloat menuItemWidth;

/**
 *  各个 MenuItem 的宽度，可不等，数组内为 NSNumber.
 *  Each item's width, when they are not all the same, use this property, Put `NSNumber` in this array.
 */
@property (nonatomic, copy) NSArray<NSNumber *> *itemsWidths;

/**
 *  导航栏背景色
 *  The background color of menu view
 */
@property (nonatomic, strong) UIColor *menuBGColor;

/**
 *  Menu view 的样式，默认为无下划线
 *  Menu view's style, now has two different styles, 'Line','default'
 */
@property (nonatomic, assign) WMMenuViewStyle menuViewStyle;

/**
 *  进度条的颜色，默认和选中颜色一致(如果 style 为 Default，则该属性无用)
 *  The progress's color,the default color is same with `titleColorSelected`.If you want to have a different color, set this property.
 */
@property (nonatomic, strong) UIColor *progressColor;

/**
 *  是否发送在创建控制器或者视图完全展现在用户眼前时通知观察者，默认为不开启，如需利用通知请开启
 *  Whether notify observer when finish init or fully displayed to user, the default is NO.
 *  See `WMPageConst.h` for more information.
 */
@property (nonatomic, assign) BOOL postNotification;

/**
 *  是否记录 Controller 的位置，并在下次回来的时候回到相应位置，默认为 NO (若当前缓存中存在不会触发)
 *  Whether to remember controller's positon if it's a kind of scrollView controller,like UITableViewController,The default value is NO.
 *  比如 `UITabelViewController`, 当然你也可以在自己的控制器中自行设置, 如果将 Controller.view 替换为 scrollView 或者在Controller.view 上添加了一个和自身 bounds 一样的 scrollView 也是OK的
 */
@property (nonatomic, assign) BOOL rememberLocation __deprecated_msg("Because of the cache policy,this property can abondon now.");

/** 缓存的机制，默认为无限制 (如果收到内存警告, 会自动切换) */
@property (nonatomic, assign) WMPageControllerCachePolicy cachePolicy;

/** Whether ContentView bounces */
@property (nonatomic, assign) BOOL bounces;

/**
 *  是否作为 NavigationBar 的 titleView 展示，默认 NO
 *  Whether to show on navigation bar, the default value is `NO`
 */
@property (assign, nonatomic) BOOL showOnNavigationBar;

/** 下划线进度条的高度 */
@property (nonatomic, assign) CGFloat progressHeight;

/** WMPageController View' frame */
@property (nonatomic, assign) CGRect viewFrame;

/**
 *  Menu view items' margin / make sure it's count is equal to (controllers' count + 1),default is 0
    顶部菜单栏各个 item 的间隙，因为包括头尾两端，所以确保它的数量等于控制器数量 + 1, 默认间隙为 0
 */
@property (nonatomic, copy) NSArray<NSNumber *> *itemsMargins;

/**
 *  set itemMargin if all margins are the same, default is 0
    如果各个间隙都想同，设置该属性，默认为 0
 */
@property (nonatomic, assign) CGFloat itemMargin;

/** 顶部 menuView 和 scrollView 之间的间隙 */
@property (nonatomic, assign) CGFloat menuViewBottom;

/** 顶部导航栏 */
@property (nonatomic, weak) WMMenuView *menuView;

/** 内部容器 */
@property (nonatomic, weak) WMScrollView *scrollView;

/**
 *  左滑时同时启用其他手势，比如系统左滑、sidemenu左滑。默认 NO
    (会引起一个小问题，第一个和最后一个控制器会变得可以斜滑, 还未解决)
 */
@property (assign, nonatomic) BOOL otherGestureRecognizerSimultaneously;
/**
 *  构造方法，请使用该方法创建控制器. 或者实现数据源方法. /
 *  Init method，recommend to use this instead of `-init`. Or you can implement datasource by yourself.
 *
 *  @param classes 子控制器的 class，确保数量与 titles 的数量相等
 *  @param titles  各个子控制器的标题，用 NSString 描述
 *
 *  @return instancetype
 */
- (instancetype)initWithViewControllerClasses:(NSArray<Class> *)classes andTheirTitles:(NSArray<NSString *> *)titles;

/**
 *  A method in order to reload MenuView and child view controllers. If you had set `itemsMargins` or `itemsWidths` `values` and `keys` before, make sure you have update them also before you call this method. And most important, PAY ATTENTION TO THE COUNT OF THOSE ARRAY.
    该方法用于重置刷新父控制器，该刷新包括顶部 MenuView 和 childViewControllers.如果之前设置过 `itemsMargins` 和 `itemsWidths` `values` 以及 `keys` 属性，请确保在调用 reload 之前也同时更新了这些属性。并且，最最最重要的，注意数组的个数以防止溢出。
 */
- (void)reloadData;

/**
 *  Update designated item's title
    更新指定序号的控制器的标题
 *
 *  @param title 新的标题
 *  @param index 目标序号
 */
- (void)updateTitle:(NSString *)title atIndex:(NSInteger)index;

/**
 *  Update designated item's title and width
    更新指定序号的控制器的标题以及他的宽度
 *
 *  @param title 新的标题
 *  @param index 目标序号
 *  @param width 对应item的新宽度
 */
- (void)updateTitle:(NSString *)title andWidth:(CGFloat)width atIndex:(NSInteger)index;

@end