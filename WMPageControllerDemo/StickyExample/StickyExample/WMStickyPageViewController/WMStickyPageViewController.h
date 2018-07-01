//
//  WMStickyPageViewController.h
//  StickyExample
//
//  Created by Tpphha on 2017/7/22.
//  Copyright © 2017年 Tpphha. All rights reserved.
//

#import <WMPageController.h>
#import "WMMagicScrollView.h"

@interface WMStickyPageViewController : WMPageController

/**
 You should add subviews to the content view, contentView is equal self.view
 */
@property(nonatomic, strong, readonly) WMMagicScrollView *contentView;

/**
 It's determine the sticky locatio.
 */
@property (nonatomic, assign)  CGFloat  minimumHeaderViewHeight;

/**
 The custom headerView's height, default 0 means no effective.
 */
@property (nonatomic, assign) CGFloat maximumHeaderViewHeight;

/**
 The menuView's height, default 44
 */
@property (nonatomic, assign) CGFloat menuViewHeight;

@end
