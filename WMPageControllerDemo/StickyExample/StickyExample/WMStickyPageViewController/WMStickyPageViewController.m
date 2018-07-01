//
//  WMStickyPageViewController.m
//  StickyExample
//
//  Created by Tpphha on 2017/7/22.
//  Copyright © 2017年 Tpphha. All rights reserved.
//

#import "WMStickyPageViewController.h"

@interface WMStickyPageViewController () <WMMagicScrollViewDelegate>

@property(nonatomic, strong) WMMagicScrollView *contentView;

@end

@implementation WMStickyPageViewController
@dynamic delegate;

#pragma mark - life cycle
- (void)loadView {
    self.contentView.frame = [UIScreen mainScreen].bounds;
    self.view = self.contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.contentView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) + self.maximumHeaderViewHeight);
}

#pragma mark - WMMagicScrollViewDelegate

- (BOOL)scrollView:(WMMagicScrollView *)scrollView shouldScrollWithSubview:(UIScrollView *)subview {
    if ([subview isKindOfClass:WMScrollView.class]) {
        return NO;
    }
    
    if ([self.delegate respondsToSelector:@selector(pageController:shouldScrollWithSubview:)]) {
        return [self.delegate pageController:self shouldScrollWithSubview:subview];
    }
    
    return YES;
}

#pragma mark - WMPageControllerDataSource

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat originY = self.maximumHeaderViewHeight;
    if (originY <= 0) {
        originY = (self.showOnNavigationBar && self.navigationController.navigationBar) ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    }
    return CGRectMake(0, originY, self.view.frame.size.width, self.menuViewHeight);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGRect preferredFrameForMenuView = [self pageController:pageController preferredFrameForMenuView:pageController.menuView];
    CGFloat tabBarHeight = self.tabBarController.tabBar && !self.tabBarController.tabBar.hidden ? self.tabBarController.tabBar.frame.size.height : 0;
    return CGRectMake(0, CGRectGetMaxY(preferredFrameForMenuView), CGRectGetWidth(preferredFrameForMenuView),self.view.frame.size.height - self.minimumHeaderViewHeight - CGRectGetHeight(preferredFrameForMenuView) - tabBarHeight);
    
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
