//
//  WMMenuView.h
//  WMPageController
//
//  Created by Mark on 15/4/26.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMMenuItem.h"
#import "WMProgressView.h"
#define WMUNDEFINED_VALUE -1

@class WMMenuView;

typedef NS_ENUM(NSUInteger, WMMenuViewStyle) {
    WMMenuViewStyleDefault,      // 默认
    WMMenuViewStyleLine,         // 带下划线 (若要选中字体大小不变，设置选中和非选中大小一样即可)
    WMMenuViewStyleTriangle,     // 三角形 (progressHeight 为三角形的高, progressWidths 为底边长)
    WMMenuViewStyleFlood,        // 涌入效果 (填充)
    WMMenuViewStyleFloodHollow,  // 涌入效果 (空心的)
    WMMenuViewStyleSegmented,    // 涌入带边框,即网易新闻选项卡
};

// 原先基础上添加了几个方便布局的枚举，更多布局格式可以通过设置 `itemsMargins` 属性来自定义
// 以下布局均只在 item 个数较少的情况下生效，即无法滚动 MenuView 时.
typedef NS_ENUM(NSUInteger, WMMenuViewLayoutMode) {
    WMMenuViewLayoutModeScatter, // 默认的布局模式, item 会均匀分布在屏幕上，呈分散状
    WMMenuViewLayoutModeLeft,    // Item 紧靠屏幕左侧
    WMMenuViewLayoutModeRight,   // Item 紧靠屏幕右侧
    WMMenuViewLayoutModeCenter,  // Item 紧挨且居中分布
};

@protocol WMMenuViewDelegate <NSObject>
@optional
- (BOOL)menuView:(WMMenuView *)menu shouldSelesctedIndex:(NSInteger)index;
- (void)menuView:(WMMenuView *)menu didSelectedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex;
- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index;
- (CGFloat)menuView:(WMMenuView *)menu itemMarginAtIndex:(NSInteger)index;
- (CGFloat)menuView:(WMMenuView *)menu titleSizeForState:(WMMenuItemState)state atIndex:(NSInteger)index;
- (UIColor *)menuView:(WMMenuView *)menu titleColorForState:(WMMenuItemState)state atIndex:(NSInteger)index;
- (void)menuView:(WMMenuView *)menu didLayoutItemFrame:(WMMenuItem *)menuItem atIndex:(NSInteger)index;
@end

@protocol WMMenuViewDataSource <NSObject>

@required
- (NSInteger)numbersOfTitlesInMenuView:(WMMenuView *)menu;
- (NSString *)menuView:(WMMenuView *)menu titleAtIndex:(NSInteger)index;

@optional
/**
 *  角标 (例如消息提醒的小红点) 的数据源方法，在 WMPageController 中实现这个方法来为 menuView 提供一个 badgeView
    需要在返回的时候同时设置角标的 frame 属性，该 frame 为相对于 menuItem 的位置
 *
 *  @param index 角标的序号
 *
 *  @return 返回一个设置好 frame 的角标视图
 */
- (UIView *)menuView:(WMMenuView *)menu badgeViewAtIndex:(NSInteger)index;

/**
 *  用于定制 WMMenuItem，可以对传出的 initialMenuItem 进行修改定制，也可以返回自己创建的子类，需要注意的是，此时的 item 的 frame 是不确定的，所以请勿根据此时的 frame 做计算！
    如需根据 frame 修改，请使用代理
 *
 *  @param menu            当前的 menuView，frame 也是不确定的
 *  @param initialMenuItem 初始化完成的 menuItem
 *  @param index           Item 所属的位置;
 *
 *  @return 定制完成的 MenuItem
 */
- (WMMenuItem *)menuView:(WMMenuView *)menu initialMenuItem:(WMMenuItem *)initialMenuItem atIndex:(NSInteger)index;

@end

@interface WMMenuView : UIView <WMMenuItemDelegate>
@property (nonatomic, strong) NSArray *progressWidths;
@property (nonatomic, weak) WMProgressView *progressView;
@property (nonatomic, assign) CGFloat progressHeight;
@property (nonatomic, assign) WMMenuViewStyle style;
@property (nonatomic, assign) WMMenuViewLayoutMode layoutMode;
@property (nonatomic, assign) CGFloat contentMargin;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat progressViewBottomSpace;
@property (nonatomic, weak) id<WMMenuViewDelegate> delegate;
@property (nonatomic, weak) id<WMMenuViewDataSource> dataSource;
@property (nonatomic, weak) UIView *leftView;
@property (nonatomic, weak) UIView *rightView;
@property (nonatomic, copy) NSString *fontName;
@property (nonatomic, weak) UIScrollView *scrollView;
/** 进度条的速度因数，默认为 15，越小越快， 大于 0 */
@property (nonatomic, assign) CGFloat speedFactor;
@property (nonatomic, assign) CGFloat progressViewCornerRadius;
@property (nonatomic, assign) BOOL progressViewIsNaughty;
@property (nonatomic, assign) BOOL showOnNavigationBar;

- (void)slideMenuAtProgress:(CGFloat)progress;
- (void)selectItemAtIndex:(NSInteger)index;
- (void)resetFrames;
- (void)reload;
- (void)updateTitle:(NSString *)title atIndex:(NSInteger)index andWidth:(BOOL)update;
- (void)updateAttributeTitle:(NSAttributedString *)title atIndex:(NSInteger)index andWidth:(BOOL)update;
- (WMMenuItem *)itemAtIndex:(NSInteger)index;
/// 立即刷新 menuView 的 contentOffset，使 title 居中
- (void)refreshContenOffset;
- (void)deselectedItemsIfNeeded;
/**
 *  更新角标视图，如要移除，在 -menuView:badgeViewAtIndex: 中返回 nil 即可
 */
- (void)updateBadgeViewAtIndex:(NSInteger)index;

@end
