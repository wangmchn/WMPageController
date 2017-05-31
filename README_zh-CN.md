# 中文介绍
原谅我拙略的英文

## Issue 须知
鉴于很多朋友在提 issue 的时候没有提供足够的信息，在此希望大家在提 issue 时能够包含下面信息：
```
1. Xcode / iOS / WMPageController 的版本信息;
2. 编译错误或者运行时错误时，编译器提供的所有信息;
3. 你设置的关键的代码片段; (如果能够提供 demo 复现那就更好了，我就是懒-。-)
4. 其他任何你觉得有可能帮助的信息;
```
以上信息会更好的帮助我改善这个项目（不要再提为什么我的xxx方法没用这样的问题了，没有信息我真的做不出判断😭)。
如果你有什么好的建议或者修改，非常欢迎提出 issue 或者直接发起 Pull request. 
任何改进都非常欢迎：bug 修复, 拼写错误或者用词语法错误, 以及文档补充以及特性需求等等。期待你的贡献！

## Swift 实现
戳这里: https://github.com/wangmchn/WMPageController-Swift

## 特性
* 增加了缓存机制，对加载过的控制器进行缓存，当内存过高时自动清理缓存。
* 可通过`itemMargin`和`itemsMargins`来定制顶部标题的间距，通过`viewFrame`来定制子控制器的`frame`属性。
* 当标题宽度之和不足宽度时，自动计算并为顶部`item`添加间隙。
* 适配横屏，当设备旋转时自动调整`frame`。
* 可通过设置`itemsWidths`属性来设置不同的标题宽度，例如 `@[@(100),@(80),@(50).....]`;
* 增加了`reload`功能，可以像网易新闻那样重新更新标题和控制器。
* 新类型 `WMMenuViewStyleSegmented`, 用于实现 <a href="https://github.com/wangmchn/WMPageController/issues/120">#120</a>

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
现在有5种样式提供选择，可通过设置 `xxxPageController.style = WMMenuViewStyleLine` 来改变样式.<br>
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

## new i add 
当子tabVC 需要多参数传递的时候，只需将参数封装成一个字典，但是这个字典属性不需要在子tabVC里添加，但是要里面的keys要对应添加属性
这是解决：这个tabVC创建的时候，需要多个参数，但是在别的地方传值的时候，不需要这么多个参数，可能是其中的一两个参数即可。如果要将其所有参数都用字典传值，就会导致所有要跳转的地方都改成字典传值。
```
    self.keys = @[@"paramDic", @"paramDic", @"paramDic"].mutableCopy; //这里key名字随便写的  
    //这里生成tabVC的时候需要传两个值，但是在别的界面跳转过来只需要一个参数即可。这里这样写keys和Values，项目其他地方都不用修改
    self.values = @[@{@"communityVcType":@(WChildCommunityVcTypeRecommend),@"isFromHomeLink":@(self.isFromHomeLink)}, @{@"communityVcType":@(WChildCommunityVcTypeFollowed),@"isFromHomeLink":@(self.isFromHomeLink)}, @{@"communityVcType":@(WChildCommunityVcTypeMine),@"isFromHomeLink":@(self.isFromHomeLink)}].mutableCopy;
```



## 许可
该项目使用 `MIT` 许可证，详情见 `LICENSE` 文件。
