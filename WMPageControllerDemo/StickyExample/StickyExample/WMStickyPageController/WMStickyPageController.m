//
//  WMStickyPageViewController.m
//  StickyExample
//
//  Created by Tpphha on 2017/7/22.
//  Copyright © 2017年 Tpphha. All rights reserved.
//

#import "WMStickyPageController.h"
#import "WMMagicScrollView.h"

@interface WMStickyPageController () <WMMagicScrollViewDelegate>

@property(nonatomic, strong) WMMagicScrollView *contentView;

@end

@implementation WMStickyPageController
@dynamic delegate;

#pragma mark - Life Cycle
- (void)loadView {
    self.contentView.frame = [UIScreen mainScreen].bounds;
    self.view = self.contentView;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.contentView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds),
                                              CGRectGetHeight(self.view.bounds) +
                                              self.maximumHeaderViewHeight);
}

#pragma mark - WMMagicScrollViewDelegate

- (BOOL)scrollView:(WMMagicScrollView *)scrollView shouldScrollWithSubview:(UIScrollView *)subview {
    if ([subview isKindOfClass:WMScrollView.class]) {
        return NO;
    }
    
    if ([self.delegate conformsToProtocol:@protocol(WMStickyPageControllerDelegate)]) {
        id<WMStickyPageControllerDelegate> delegate = (id<WMStickyPageControllerDelegate>)self.delegate;
        if ([delegate respondsToSelector:@selector(pageController:shouldScrollWithSubview:)]) {
            return [delegate pageController:self shouldScrollWithSubview:subview];
        }
    }
    
    return YES;
}

#pragma mark - WMPageControllerDataSource

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat originY = self.maximumHeaderViewHeight;
    if (originY <= 0) {
        UINavigationBar *navigationBar = self.navigationController.navigationBar;
        originY = (self.showOnNavigationBar && navigationBar) ? 0 : CGRectGetMaxY(navigationBar.frame);
    }
    return CGRectMake(0, originY, CGRectGetWidth( self.view.frame), self.menuViewHeight);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGRect preferredFrameForMenuView = [self pageController:pageController preferredFrameForMenuView:pageController.menuView];
    UITabBar *tabBar = self.tabBarController.tabBar;
    CGFloat tabBarHeight = tabBar && !tabBar.hidden ? CGRectGetHeight(tabBar.frame) : 0;
    return CGRectMake(0,
                      CGRectGetMaxY(preferredFrameForMenuView),
                      CGRectGetWidth(preferredFrameForMenuView),
                      CGRectGetHeight(self.view.frame) -
                      self.minimumHeaderViewHeight -
                      CGRectGetHeight(preferredFrameForMenuView) -
                      tabBarHeight);
    
}

#pragma mark - setter & getter

- (WMMagicScrollView *)contentView {
    if (!_contentView) {
        _contentView = [WMMagicScrollView new];
        _contentView.delegate = self;
    }
    return _contentView;
}

- (void)setMinimumHeaderViewHeight:(CGFloat)minimumHeaderViewHeight {
    self.contentView.minimumHeaderViewHeight = minimumHeaderViewHeight;
}

- (CGFloat)minimumHeaderViewHeight {
    return self.contentView.minimumHeaderViewHeight;
}

- (void)setMaximumHeaderViewHeight:(CGFloat)maximumHeaderViewHeight {
    self.contentView.maximumHeaderViewHeight = maximumHeaderViewHeight;
}

- (CGFloat)maximumHeaderViewHeight {
    return self.contentView.maximumHeaderViewHeight;
}

@end

