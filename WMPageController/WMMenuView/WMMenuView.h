//
//  WMMenuView.h
//  WMPageController
//
//  Created by Mark on 15/4/26.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMMenuItem.h"
@class WMMenuView;

typedef NS_ENUM(NSUInteger, WMMenuViewStyle) {
    WMMenuViewStyleDefault,     // 默认
    WMMenuViewStyleLine,        // 带下划线 (若要选中字体大小不变，设置选中和非选中大小一样即可)
    WMMenuViewStyleFoold,       // 涌入效果 (填充)
    WMMenuViewStyleFooldHollow, // 涌入效果 (空心的)
};

@protocol WMMenuViewDelegate <NSObject>
@optional
- (void)menuView:(WMMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex;
- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index;
- (CGFloat)menuView:(WMMenuView *)menu itemMarginAtIndex:(NSInteger)index;
- (CGFloat)menuView:(WMMenuView *)menu titleSizeForState:(WMMenuItemState)state;
- (UIColor *)menuView:(WMMenuView *)menu titleColorForState:(WMMenuItemState)state;
@end

@interface WMMenuView : UIView
@property (nonatomic, assign) CGFloat progressHeight;
@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, assign) WMMenuViewStyle style;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, weak) id<WMMenuViewDelegate> delegate;
@property (nonatomic, copy) NSString *fontName;

@property (nonatomic, readonly) CGFloat selectedSize;
@property (nonatomic, readonly) CGFloat normalSize;
@property (nonatomic, readonly) UIColor *selectedColor;
@property (nonatomic, readonly) UIColor *normalColor;

- (void)slideMenuAtProgress:(CGFloat)progress;
- (void)selectItemAtIndex:(NSInteger)index;
- (void)resetFrames;

- (void)updateTitle:(NSString *)title atIndex:(NSInteger)index andWidth:(BOOL)update;

@end
