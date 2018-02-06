//
//  WMScrollView.m
//  WMPageController
//
//  Created by lh on 15/11/21.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WMScrollView.h"

@implementation WMScrollView

#pragma mark - <UIGestureRecognizerDelegate>

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //MARK: UITableViewCell 删除手势
    if ([NSStringFromClass(otherGestureRecognizer.view.class) isEqualToString:@"UITableViewWrapperView"] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return YES;
    }
    return NO;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *result = [super hitTest:point withEvent:event];
    
    if(self.scrollEnableIgnoreClass != nil)
    {
        if([result isKindOfClass:[self.scrollEnableIgnoreClass class]])
        {
            self.scrollEnabled = NO;
        }
        else
        {
            self.scrollEnabled = YES;
        }
    }

    return result ;
}

@end
