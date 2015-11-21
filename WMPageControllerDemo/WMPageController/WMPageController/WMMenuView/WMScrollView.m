//
//  WMScrollView.m
//  WMPageController
//
//  Created by lh on 15/11/21.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WMScrollView.h"

@implementation WMScrollView

#pragma mark - Init

- (id)init {
    if (self = [super init]) {
        self.otherGestureRecognizerSimultaneously = YES;
    }
    return self;
}


#pragma mark - <UIGestureRecognizerDelegate>

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // iOS横向滚动的scrollView和系统pop手势返回冲突的解决办法:     http://blog.csdn.net/hjaycee/article/details/49279951
    // 不判断 UILayoutContainerView ， ReSideMenu也可以用
    
    // 首先判断otherGestureRecognizer是不是系统pop手势
    //    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
    // 再判断系统手势的state是began还是fail，同时判断scrollView的位置是不是正好在最左边
    if (self.otherGestureRecognizerSimultaneously && otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.contentOffset.x == 0) {
        return YES;
    }
    //    }
    
    return NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
