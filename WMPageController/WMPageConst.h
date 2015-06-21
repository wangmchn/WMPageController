//
//  WMPageConst.h
//  WMPageController
//
//  Created by Mark on 15/6/13.
//  Copyright (c) 2015年 yq. All rights reserved.
//
//  WMPageController的导航栏的一些默认属性
//  如懒得设置PageController的属性，可在此自行修改

//  标题的尺寸(选中/非选中)
#define WMTitleSizeSelected 18
#define WMTitleSizeNormal   15

//  标题的颜色(选中/非选中) (P.S.标题颜色是可动画的，请确保颜色具有RGBA分量，如通过RGBA创建)
#define WMTitleColorSelected [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1]
#define WMTitleColorNormal   [UIColor colorWithRed:0 green:0 blue:0 alpha:1]

//  导航菜单栏的背景颜色
#define WMMenuBGColor [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0]
//  导航菜单栏的高度
#define WMMenuHeight  30
//  导航菜单栏每个item的宽度
#define WMMenuItemWidth 65