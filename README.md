# WMPageController
An easy solution to page controllers like `NetEase News`
## Overview
**Default style** <br>
<img height="350" src="https://github.com/wangmchn/WMPageController/blob/master/WMPageControllerDemo/WMPageController/ScreenShot/ScreenShot.gif" />
<br>
<br>
**New style!**<br>
`WMMenuViewStyleLine` <br>
**And it's also remember the position now!**<br>
**CHEERS!** <br>
<img height="350" src="https://github.com/wangmchn/WMPageController/blob/master/WMPageControllerDemo/WMPageController/ScreenShot/ScreenShot4.gif" />               <img height="350" src="https://github.com/wangmchn/WMPageController/blob/master/WMPageControllerDemo/WMPageController/ScreenShot/ScreenShot3.gif" />
<br>
<br>
And you can easily have this style only by one step;
```objective-c
pageController.menuViewStyle = WMMenuViewStyleLine;
```
<br>
## What's New
* If items width didn't fill the screen width,page controller will calculate width and add gap between each item automatically;
* Page controller will remember the position, if it's a kind of scrollView controller,(that means: `UITabelViewController` , `UICollectionViewController` ,or a controller you have replaced `controller.view` to `scrollview`,or you have add a scrollview as it's first subview);
* Adjust views and frames when device's orientation changed;
* Set the property `itemsWidths` to have **different width**!Like `@[@(100),@(80),@(50).....]`;
* Waiting for new function...


## Basic use

First Drag files in red frame to your project.<br>
![Guide](https://github.com/wangmchn/WMPageController/blob/master/WMPageControllerDemo/WMPageController/ScreenShot/guide1.png)

Then,create an controller that extends from `WMPageController`.I recommend to use<br>
```objective-c
- (instancetype)initWithViewControllerClasses:(NSArray *)classes andTheirTitles:(NSArray *)titles;
```
to init the controller.Here are two important porperties<br>

    classes :contains the classes of view controller, you can put obj in like [UITableViewController class];
    titles  :Each View controller's title to show in the menu view at the top of the view;

To have a custom page controller,please set the properties in `WMPageController` ,They are: `titleSize`, `titleColor`, `menuHeight`, `pageAnimatable`, `menuBGColor`, `menuItemWidth`,`rememberLocation`,and also `itemsWidths`.<br>

### Attention
When you are setting the title color, please use those have RGBA components, `except like [UIColor blackColor],[UIColor grayColor],ect.`,or **USE** `[UIColor colorWithRed:green:blue:alpha:]` **to make sure the color definitely work**.
<br>
## Pod
    pod 'WMPageController'

## Note
You can put every controller in `WMPageController`,But if you want have a `UICollectionViewController` in, please have an attention to `UICollectionViewController's` init method.<br>
You should override the `- init` to give `UICollectionViewController` a `UICollectionViewLayout`.
Here is an example:
```objective-c
- (instancetype)init{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumLineSpacing = 1;
    flow.minimumInteritemSpacing = .1;
    CGFloat width = [[UIScreen mainScreen] bounds].size.width / 4 - 3*0.1;
    flow.itemSize = CGSizeMake(width,width);
    self = [self initWithCollectionViewLayout:flow];
    if (self) {
        // insert code here...
    }
    return self;
}
```
## Final
<br>
**Reusable view version see this:** https://github.com/wangmchn/YKPageView
<br>
<br>
**And:**
* If you have problems, please issue me.
* If you have suggestions, please issue me.
* If you like me, please issue me, or you can give me a little star :)
* If you want a new style, please issue me! (I'm waiting for it..)
