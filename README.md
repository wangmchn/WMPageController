# WMPageController <a href="https://github.com/wangmchn/WMPageController/blob/master/README_zh-CN.md">中文介绍</a>
[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)
![CocoaPods Version](https://img.shields.io/badge/pod-v0.36.4-brightgreen.svg)

An easy solution to page controllers like `NetEase News`
## Overview
<img height="600" src="https://github.com/wangmchn/WMPageController/blob/master/WMPageControllerDemo/Overview.gif" />

## Basic use
Create an controller extends from `WMPageController`.There are two ways to init the `WMPageController`:

#### Init with Classes
Use the following constructor to init the controller:
```objective-c
- (instancetype)initWithViewControllerClasses:(NSArray *)classes 
                               andTheirTitles:(NSArray *)titles;
```
Here are two important porperties:

    classes :contains the classes of child view controllers, just like [UITableViewController class];
    titles  :Each View controller's title to show in the menu view at the top of the view;

#### Use datasource (Recommend This Way!)
The usage is very familiar to `UITableView`, these are the methods need to implement:
```objective-c 
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController;

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index;

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index;
```
Just implement these datasource methods in YOUR WMPageController after initialize it.

## Customize Content's Frame 
It's easy for you to customize your controller as following, just implement these two datasource methods.<br>
```
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView;

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView;
```
When you want to change the frame of contentView, you need to call `-forceLayoutSubViews` method. This will recall the datasource method above and re-layout subviews.
If you are interested, see `viewFrameExample` for more detail.

## Use Storyboard / xib
1.If you init the `WMPageController` with child controller's class,override the `-init` method in `WMPageController's childViewController`, For example:
```objective-c
- (instancetype)init {
    return [self initWithNibName:@"xxxViewController" bundle:nil];
}
```
2.If you are using datasource, Just implement `-pageController:viewControllerAtIndex:` as following:
```objective-c
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"WMViewController"];
    return vc;
}
```
See `StoryboardExample` for more detail.

## Styles

You can easily change style by setting `xxxPageController.style = WMMenuViewStyleLine`.<br>
If you want `menuView` to show on the navigation bar, set `.showOnNavigationBar = YES`;

## Using CocoaPods
    pod 'WMPageController'

## Note
1. If you have any trouble with content controller's frame or size,just try set `viewFrame` property, which make you free to customize your own size.

2. You can put every controller in `WMPageController`,But if you want have a `UICollectionViewController` in, please have an attention to `UICollectionViewController's` init method.<br>
You should override the `- init` to give `UICollectionViewController` a `UICollectionViewLayout`.
Here is an example:
```objective-c
- (instancetype)init {
    // init layout here...
    self = [self initWithCollectionViewLayout:layout];
    if (self) {
        // insert code here...
    }
    return self;
}
```

## License
This project is under MIT License. See LICENSE file for more information.
