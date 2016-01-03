//
//  WMCustomPageController.h
//  Use Datasource
//
//  Created by Mark on 16/1/3.
//  Copyright © 2016年 Wecan Studio. All rights reserved.
//

#import "WMPageController.h"

/**
 *  It's a subclass of `WMPageController`, WMPageController's delegate and datasource is self by default, so you can implement it in order to do more efforts.
    For example, you can implement `-pageController:viewControllerAtIndex:` and return a viewcontroller that initialize by yourself, that means: you can return a viewcontroller from a storyboard or set properties after call `-init` method.
 */
@interface WMCustomPageController : WMPageController

@end
