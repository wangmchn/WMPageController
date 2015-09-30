# WMPageController
[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)
![CocoaPods Version](https://img.shields.io/badge/pod-v0.36.4-brightgreen.svg)

An easy solution to page controllers like `NetEase News`
## Overview
<br>
<img height="400" src="https://github.com/wangmchn/WMPageController/blob/master/WMPageControllerDemo/WMPageController/ScreenShot/ScreenShot.gif" />
<br>
<br>
And you can easily change styles by setting `menuViewStyle` property:
```objective-c
pageController.menuViewStyle = WMMenuViewStyleLine;
pageController.menuViewStyle = WMMenuViewStyleFlood;
```
## What's New
* **Now page controller has a cache policy and scroll much more fluently!**
* If items width didn't fill the screen width,page controller will calculate width and add gap between each item automatically;
* Adjust views and frames when device's orientation changed;
* Set the property `itemsWidths` to have **Different Width**! Like `@[@(100),@(80),@(50).....]`;

## Basic use

First Drag files in red frame to your project.<br>
<img height="300" src="https://github.com/wangmchn/WMPageController/blob/master/WMPageControllerDemo/WMPageController/ScreenShot/guide.png" />

Then,create an controller that extends from `WMPageController`.I recommend to use<br>
```objective-c
- (instancetype)initWithViewControllerClasses:(NSArray *)classes 
                               andTheirTitles:(NSArray *)titles;
```
to init the controller.Here are two important porperties<br>

    classes :contains the classes of view controller, you can put obj in like [UITableViewController class];
    titles  :Each View controller's title to show in the menu view at the top of the view;

To have a custom page controller,please set the properties in `WMPageController` ,They are: `titleSize`, `titleColor`, `menuHeight`, `pageAnimatable`, `menuBGColor`, `menuItemWidth`,~~`rememberLocation`~~,and also `itemsWidths`.<br>

## Pod
    pod 'WMPageController'

## Note
You can put every controller in `WMPageController`,But if you want have a `UICollectionViewController` in, please have an attention to `UICollectionViewController's` init method.<br>
You should override the `- init` to give `UICollectionViewController` a `UICollectionViewLayout`.
Here is an example:
```objective-c
- (instancetype)init{
    // init layout here...
    self = [self initWithCollectionViewLayout:layout];
    if (self) {
        // insert code here...
    }
    return self;
}
```
## To do
    New styles!
    And support Swift.

## License
This project is under MIT License. See LICENSE file for more information.

