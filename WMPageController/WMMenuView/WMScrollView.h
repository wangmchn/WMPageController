//
//  WMScrollView.h
//  WMPageController
//
//  Created by lh on 15/11/21.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMScrollView : UIScrollView

/// 左滑时同时启用其他手势，比如系统左滑、sidemenu左滑。默认 NO
@property (assign, nonatomic) BOOL otherGestureRecognizerSimultaneously;

@end
