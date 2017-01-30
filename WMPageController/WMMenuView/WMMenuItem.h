//
//  WMMenuItem.h
//  WMPageController
//
//  Created by Mark on 15/4/26.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMMenuItem;

typedef NS_ENUM(NSUInteger, WMMenuItemState) {
    WMMenuItemStateSelected,
    WMMenuItemStateNormal,
};

NS_ASSUME_NONNULL_BEGIN
@protocol WMMenuItemDelegate <NSObject>
@optional
- (void)didPressedMenuItem:(WMMenuItem *)menuItem;
@end

@interface WMMenuItem : UILabel

@property (nonatomic, assign) CGFloat rate;           ///> 设置 rate, 并刷新标题状态 (0~1)
@property (nonatomic, assign) CGFloat normalSize;     ///> Normal状态的字体大小，默认大小为15
@property (nonatomic, assign) CGFloat selectedSize;   ///> Selected状态的字体大小，默认大小为18
@property (nonatomic, strong) UIColor *normalColor;   ///> Normal状态的字体颜色，默认为黑色 (可动画)
@property (nonatomic, strong) UIColor *selectedColor; ///> Selected状态的字体颜色，默认为红色 (可动画)
@property (nonatomic, assign) CGFloat speedFactor;    ///> 进度条的速度因数，默认 15，越小越快, 必须大于0
@property (nonatomic, nullable, weak) id<WMMenuItemDelegate> delegate;
@property (nonatomic, assign, readonly) BOOL selected;

- (void)setSelected:(BOOL)selected withAnimation:(BOOL)animation;

@end
NS_ASSUME_NONNULL_END
