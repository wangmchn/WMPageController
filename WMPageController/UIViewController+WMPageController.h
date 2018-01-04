//
//  UIViewController+WMPageController.h
//  WMPageController
//
//  Created by Mark on 15/6/11.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WMPageController;

@interface UIViewController (WMPageController)

/**
 获取控制器所在的WMPageController
 */
@property (nonatomic, nullable, strong, readonly) WMPageController *wm_pageController;

@end
