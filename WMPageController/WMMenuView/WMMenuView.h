//
//  WMMenuView.h
//  WMPageController
//
//  Created by Mark on 15/4/26.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMMenuItem.h"
#import "WMFloodView.h"
@class WMMenuView;

typedef NS_ENUM(NSUInteger, WMMenuViewStyle) {
    WMMenuViewStyleDefault,     // 默认
    WMMenuViewStyleLine,        // 带下划线 (若要选中字体大小不变，设置选中和非选中大小一样即可)
    WMMenuViewStyleFlood,       // 涌入效果 (填充)
    WMMenuViewStyleFloodHollow, // 涌入效果 (空心的)
};

@protocol WMMenuViewDelegate <NSObject>
@optional
- (void)menuView:(WMMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex;

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index;
- (CGFloat)menuView:(WMMenuView *)menu itemMarginAtIndex:(NSInteger)index;
- (CGFloat)menuView:(WMMenuView *)menu titleSizeForState:(WMMenuItemState)state;
- (UIColor *)menuView:(WMMenuView *)menu titleColorForState:(WMMenuItemState)state;
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
@end

@interface WMMenuView : UIView
@property (nonatomic, weak) WMProgressView *progressView;
@property (nonatomic, assign) CGFloat progressHeight;
@property (nonatomic, assign) WMMenuViewStyle style;
@property (nonatomic, assign) CGFloat contentMargin;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat progressViewBottomSpace;
@property (nonatomic, weak) id<WMMenuViewDelegate> delegate;
@property (nonatomic, weak) id<WMMenuViewDataSource> dataSource;
@property (nonatomic, weak) UIView *leftView;
@property (nonatomic, weak) UIView *rightView;
@property (nonatomic, copy) NSString *fontName;

@property (nonatomic, readonly) CGFloat selectedSize;
@property (nonatomic, readonly) CGFloat normalSize;
@property (nonatomic, readonly) UIColor *selectedColor;
@property (nonatomic, readonly) UIColor *normalColor;

@property (nonatomic, weak) UIScrollView *scrollView;

- (void)slideMenuAtProgress:(CGFloat)progress;
- (void)selectItemAtIndex:(NSInteger)index;
- (void)resetFrames;
- (void)reload;
- (void)updateTitle:(NSString *)title atIndex:(NSInteger)index andWidth:(BOOL)update;

/**
 *  更新角标视图，如要移除，在 -menuView:badgeViewAtIndex: 中返回 nil 即可
 */
- (void)updateBadgeViewAtIndex:(NSInteger)index;

@end
