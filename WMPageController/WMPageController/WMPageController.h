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

@property (nonatomic, strong) NSArray *viewControllerClasses;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, assign) int selectedIndex;

@property (nonatomic, assign) BOOL pageAnimatable;

@property (nonatomic, assign) CGFloat titleSizeSelected;
@property (nonatomic, assign) CGFloat titleSizeNormal;

@property (nonatomic, strong) UIColor *titleColorSelected;
@property (nonatomic, strong) UIColor *titleColorNormal;

@property (nonatomic, assign) CGFloat menuHeight;
@property (nonatomic, assign) CGFloat menuItemWidth;
@property (nonatomic, strong) UIColor *menuBGColor;

- (instancetype)initWithViewControllerClasses:(NSArray *)classes andTheirTitles:(NSArray *)titles;
@end
