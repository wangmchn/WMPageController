# WMPageController <a href="#中文介绍">中文介绍</a>
[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)
![CocoaPods Version](https://img.shields.io/badge/pod-v0.36.4-brightgreen.svg)

An easy solution to page controllers like `NetEase News`
## Overview
<br>
<img height="400" src="https://github.com/wangmchn/WMPageController/blob/master/WMPageControllerDemo/Code/WMPageController/ScreenShot/ScreenShot.gif" />
<br>
<br>
And you can easily change styles by setting `menuViewStyle` property:
```objective-c
pageController.menuViewStyle = WMMenuViewStyleLine;
```
If you want `menuView` to show on the navigation bar, set `showOnNavigationBar = YES`;

## Swift Version
Click here: https://github.com/wangmchn/WMPageController-Swift

## What's New
* **Now page controller has a cache policy and scroll much more fluently!**
* Add `itemMargin` and `itemsMargins` to custom margin between each item, `viewFrame` to custom controller.view's frame. 
* Add `values` and `keys` properties which can help pass values to childControllers through `KVC`.
* If items width didn't fill the screen width, `WMPageController` will calculate width and add gap between each item automatically;
* Adjust views and frames when device's orientation changed;
* Set the property `itemsWidths` to have **Different Width**! Like `@[@(100),@(80),@(50).....]`;
* Can reload data like `NetEase News`.

## Basic use

First Drag files in red frame to your project.<br>
<img height="300" src="https://github.com/wangmchn/WMPageController/blob/master/WMPageControllerDemo/Code/WMPageController/ScreenShot/guide.png" />

Then,create an controller that extends from `WMPageController`.I recommend to use<br>
```objective-c
- (instancetype)initWithViewControllerClasses:(NSArray *)classes 
                               andTheirTitles:(NSArray *)titles;
```
to init the controller.Here are two important porperties<br>

    classes :contains the classes of view controller, you can put obj in like [UITableViewController class];
    titles  :Each View controller's title to show in the menu view at the top of the view;

To have a custom page controller,please set the properties in `WMPageController` ,They are: `titleSize`, `titleColor`, `menuHeight`, `pageAnimatable`, `menuBGColor`, `menuItemWidth`,~~`rememberLocation`~~,and also `itemsWidths`.<br>

## Use Storyboard / xib
Override `-init` method in `childViewController`, For example:
```objective-c
- (instancetype)init {
    return [self initWithNibName:@"xxxViewController" bundle:nil];
}
```

## Pod
    pod 'WMPageController'

## Note
You can put every controller in `WMPageController`,But if you want have a `UICollectionViewController` in, please have an attention to `UICollectionViewController's` init method.<br>
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

# 中文介绍

`WMPageController`是一个方便形成如同网易新闻首页，控制器滑动翻页效果的控制器。(原谅我拙略的英文)

## Swift 实现
戳这里: https://github.com/wangmchn/WMPageController-Swift

## 特性
* 增加了缓存机制，对加载过的控制器进行缓存，当内存过高时自动清理缓存。
* 可通过`itemMargin`和`itemsMargins`来定制顶部标题的间距，通过`viewFrame`来定制子控制器的`frame`属性。
* 通过设置`values`和`keys`向子控制器传值。(内部利用KVC实现)
* 当标题宽度之和不足宽度时，自动计算并为顶部`item`添加间隙。
* 适配横屏，当设备旋转时自动调整`frame`。
* 可通过设置`itemsWidths`属性来设置不同的标题宽度，例如 `@[@(100),@(80),@(50).....]`;
* 增加了`reload`功能，可以像网易新闻那样重新更新标题和控制器。

## 使用

首先，把下面红框里的内容拖入项目。<br>
<img height="300" src="https://github.com/wangmchn/WMPageController/blob/master/WMPageControllerDemo/Code/WMPageController/ScreenShot/guide.png" />

然后，创建一个控制器继承自`WMPageController`，并使用以下方法初始化该控制器<br>
```objective-c
- (instancetype)initWithViewControllerClasses:(NSArray *)classes 
                               andTheirTitles:(NSArray *)titles;
```
其中，`Classes`是要传人显示的控制器的类型，比如`[UITableViewController class]`, `titles`是要显示的控制对应的标题。
如要定制`WMPageController`的外观，可通过设置如下属性：
 `titleSize`, `titleColor`, `menuHeight`, `pageAnimatable`, `menuBGColor`, `menuItemWidth`,~~`rememberLocation`~~,以及 `itemsWidths`.<br>

## 使用 Storyboard / xib
重写子控制器的 `-init` 方法，例如：
```objective-c
- (instancetype)init {
    return [self initWithNibName:@"xxxViewController" bundle:nil];
}
```

## 使用Pod管理
    pod 'WMPageController'

## 要点
如果需要传入 `UICollectionViewController`, 需要重写 `- init` 方法，来为`UICollectionViewController`提供一个 `UICollectionViewLayout`。
方式如下：
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

## 许可
该项目使用 `MIT` 许可证，详情见 `LICENSE` 文件。
