//
//  UIViewController+WMPageController.m
//  WMPageController
//
//  Created by Mark on 15/6/11.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "UIViewController+WMPageController.h"
#import "WMPageController.h"

@implementation UIViewController (WMPageController)

- (WMPageController *)wm_pageController {
    UIViewController *parentViewController = self.parentViewController;
    while (parentViewController) {
        if ([parentViewController isKindOfClass:[WMPageController class]]) {
            return (WMPageController *)parentViewController;
        }
        parentViewController = parentViewController.parentViewController;
    }
    return nil;
}

@end
