
# 中文介绍
原谅我拙略的英文

## Swift 实现
戳这里: https://github.com/wangmchn/WMPageController-Swift

## 特性
* 增加了缓存机制，对加载过的控制器进行缓存，当内存过高时自动清理缓存。
* 可通过`itemMargin`和`itemsMargins`来定制顶部标题的间距，通过`viewFrame`来定制子控制器的`frame`属性。
* 当标题宽度之和不足宽度时，自动计算并为顶部`item`添加间隙。
* 适配横屏，当设备旋转时自动调整`frame`。
* 可通过设置`itemsWidths`属性来设置不同的标题宽度，例如 `@[@(100),@(80),@(50).....]`;
* 增加了`reload`功能，可以像网易新闻那样重新更新标题和控制器。

## 使用
首先，把下面红框里的内容拖入项目。<br>
<img height="300" src="https://github.com/wangmchn/WMPageController/blob/master/WMPageControllerDemo/Code/WMPageController/ScreenShot/guide.png" />

然后，创建一个控制器继承自`WMPageController`, 可以通过两种方式来初始化控制器<br>
#### 通过 Class 创建
使用以下方法创建控制器：
```objective-c
- (instancetype)initWithViewControllerClasses:(NSArray *)classes 
                               andTheirTitles:(NSArray *)titles;
```
其中，`Classes`是要传人显示的控制器的类型，比如`[UITableViewController class]`, `titles`是要显示的控制对应的标题。
#### 使用 datasource
使用方法和 UITableView 相似，在子类中实现以下数据源方法即可：
```objective-c 
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController;

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index;

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index;
```

## 使用 Storyboard / xib
1.如果用了 **-initWithViewControllerClasses: andTheirTitles:** 来初始化， 那么需要重写子控制器(子控制器是指你添加到 WMPageController 的控制器)的 `-init` 方法，例如：
```objective-c
- (instancetype)init {
    return [self initWithNibName:@"xxxViewController" bundle:nil];
}
```
2.如果使用 datasource，那么实现对应的数据源即可，例如：
```objective-c
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"WMViewController"];
    return vc;
}
```

## Styles
现在有4种样式提供选择，可通过设置 `xxxPageController.style = WMMenuViewStyleLine` 来改变样式.<br>
如果想要在 NavigationBar 上显示导航栏， 设置`.showOnNavigationBar = YES`即可。

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
