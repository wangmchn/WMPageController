//
//  WMStickyPageViewController.h
//  StickyExample
//
//  Created by Tpphha on 2017/7/22.
//  Copyright © 2017年 Tpphha. All rights reserved.
//

#import "WMPageController.h"

@protocol WMStickyPageViewControllerDelegate <NSObject>

@optional
- (UIScrollView *)stretchScrollView;

@end

@interface WMStickyPageViewController : WMPageController

/**
 self.view == self.basicScrollView
 */
@property (nonatomic, readonly) UIScrollView *basicScrollView;

@property (nonatomic, assign) CGFloat menuViewHeight;

/**
 It's determine the sticky location and the best is set to an integer.
 */
@property (nonatomic, assign)  CGFloat  minimumTopInset;

/**
 custom header view height, default 0 means no effective and the best is set to an integer.
 */
@property (nonatomic, assign) CGFloat headerViewHeight;

/**
 turn off the sticky
 */
@property (nonatomic, assign) BOOL disableSticky;

/**
 the basicScrollView's maximum contentOffsetY
 */
@property (nonatomic, readonly) CGFloat maximumContentOffsetY;


- (void)updateStretchScrollViewIfNeeded;
@end
