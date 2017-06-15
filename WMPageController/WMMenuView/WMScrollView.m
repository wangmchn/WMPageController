//
//  WMScrollView.m
//  WMPageController
//
//  Created by lh on 15/11/21.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WMScrollView.h"

/// 其他所有 Pan 手势优先于 WMScrollView 的滚动手势
/// 如想调整，自己处理冲突问题，(通过 UIGestureRecogizerDelegate 即可)
/// 删除 non-public 风险的 Api
@implementation WMScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] &&
        otherGestureRecognizer.state == UIGestureRecognizerStateBegan &&
        [gestureRecognizer.view isKindOfClass:[WMScrollView class]] &&
        [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return YES;
    }
    return NO;
}

@end
