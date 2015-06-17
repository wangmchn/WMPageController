# WMPageController
An easy solution to page controllers like `NetEase News`
## Overview
![Example](https://github.com/wangmchn/WMPageController/blob/master/WMPageController/ScreenShot/ScreenShot.gif)
## Basic use

1.First Drag files in red frame to your project.
![Guide](https://github.com/wangmchn/WMPageController/blob/master/WMPageController/ScreenShot/guide1.png)
2.Create an controller that extends `WMPageController`.I recommend to use<br>
```objective-c
- (instancetype)initWithViewControllerClasses:(NSArray *)classes andTheirTitles:(NSArray *)titles;
```
to init the controller.Here are two important porperties
    // classes :contains the classes of view controller, you can put obj in like this [UITableViewController Class];
    // titles  :Each View controller's title to show in the menu view at the top of the view;
3.to have a custom controller,please set the properties in `WMPageController`,They are:`titleSize`,`titleColor`,`menuHeight`,`pageAnimatable`,`menuBGColor`,`menuItemWidth`.
