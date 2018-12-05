//
//  WMScrollView+ScrollBack.m
//  KXLive
//
//  Created by 林祖涵 on 2018/11/29.
//  Copyright © 2018 ibobei. All rights reserved.
//

#import "WMScrollView+ScrollBack.h"

@implementation WMScrollView (ScrollBack)

#pragma mark - <UIGestureRecognizerDelegate>

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *tmpGesture = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint translation = [tmpGesture translationInView:tmpGesture.view];
        /* 当scrollView滑到初始位置时，再滑动就让返回手势生效
         * translation.x > 0 表示向右滑动 translation.x <= 0 表示向左滑动
         */
        if (self.contentOffset.x <= 0
            && translation.x > 0) {
            return NO;
        }
    }
    
    return YES;
}

@end
