//
//  WMStickyPageViewController.m
//  StickyExample
//
//  Created by Tpphha on 2017/7/22.
//  Copyright © 2017年 Tpphha. All rights reserved.
//

#import "WMStickyPageViewController.h"
#import "TPDelegateMatrioska.h"
#import <objc/runtime.h>

@interface UIScrollView (WMStickyPageViewControllerMultipleDelegate)
@property (nonatomic, strong) TPDelegateMatrioska *matrioska;
@end


@implementation UIScrollView (WMStickyPageViewControllerMultipleDelegate)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(setDelegate:) with:@selector(MultipleDelegate_setDelegate:)];
    });
}

+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return NO;
    
    class_addMethod(self,
                    originalSel,
                    class_getMethodImplementation(self, originalSel),
                    method_getTypeEncoding(originalMethod));
    class_addMethod(self,
                    newSel,
                    class_getMethodImplementation(self, newSel),
                    method_getTypeEncoding(newMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, originalSel),
                                   class_getInstanceMethod(self, newSel));
    return YES;
}


- (void)setMatrioska:(TPDelegateMatrioska *)matrioska {
    objc_setAssociatedObject(self, _cmd, matrioska, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TPDelegateMatrioska *)matrioska {
    return objc_getAssociatedObject(self, @selector(setMatrioska:));
}

- (void)MultipleDelegate_setDelegate:(id<UIScrollViewDelegate>)delegate {
    id<UIScrollViewDelegate> originDelegate = delegate;
    
    if (self.matrioska) {
        TPDelegateMatrioska *matrioska = self.matrioska;
        if (originDelegate && ![matrioska containsDelegate:originDelegate]) {
            [self addMethodIfNecessaryWithTarget:originDelegate];
            [matrioska addDelegate:originDelegate];
        }
        
    }else {
        if ([originDelegate conformsToProtocol:@protocol(WMStickyPageViewControllerDelegate)]) {
            if (!self.matrioska) {
                self.matrioska = [[TPDelegateMatrioska alloc] initWithDelegateQueueQOS:NSQualityOfServiceUserInitiated];
            }
            
            if (originDelegate) {
                [self addMethodIfNecessaryWithTarget:originDelegate];
                [self.matrioska addDelegate:originDelegate];
            }
            
            delegate = (id<UIScrollViewDelegate>)self.matrioska;
        }
        
        [self MultipleDelegate_setDelegate:delegate];
    }
    
}


- (void)addMethodIfNecessaryWithTarget:(id)target {
    SEL sel = @selector(scrollViewDidScroll:);
    if (![target respondsToSelector:sel]) {
        class_addMethod([target class], sel, (IMP)_emptyMethod, "v@:@");
    }
    
    sel = @selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:);
    if (![target respondsToSelector:sel]) {
#if CGFLOAT_IS_DOUBLE
        class_addMethod([target class], sel, (IMP)_emptyMethod1, "v@:@dd*");
#else
        class_addMethod([target class], sel, (IMP)_emptyMethod1, "v@:@ff*");
#endif
    }
    
    sel = @selector(scrollViewWillBeginDragging:);
    if (![target respondsToSelector:sel]) {
        class_addMethod([target class], sel, (IMP)_emptyMethod, "v@:@");
    }
    
}


void _emptyMethod(id current_self, SEL current_cmd, UIScrollView *scrollView) {
    
}

void _emptyMethod1(id current_self, SEL current_cmd, UIScrollView *scrollView, CGPoint velocity, CGPoint *targetContentOffset) {
    
}

@end


@interface WMStickyPageViewControllerDynamicItem : NSObject <UIDynamicItem>
@property (nonatomic, readwrite) CGPoint center;
@property (nonatomic, readonly) CGRect bounds;
@property (nonatomic, readwrite) CGAffineTransform transform;
@end

@implementation WMStickyPageViewControllerDynamicItem

- (CGRect)bounds {
    return CGRectMake(0, 0, 1, 1);
}

@end


@interface WMStickyPageViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@end

@implementation WMStickyPageViewController
@dynamic maximumContentOffsetY;


#pragma mark - life cycle
- (void)loadView {
    UIScrollView *basicScrollView = [[UIScrollView alloc] init];
    basicScrollView.bounces = NO;
    basicScrollView.delegate = self;
    basicScrollView.showsVerticalScrollIndicator = NO;
    self.view = basicScrollView;
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.postNotification = YES;
    self.menuViewHeight = 44;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didFullyDisplayedNotification)
                                                 name:WMControllerDidFullyDisplayedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didAddToSuperViewNotification)
                                                 name:WMControllerDidAddToSuperViewNotification
                                               object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.basicScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + self.headerViewHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WMControllerDidFullyDisplayedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WMControllerDidAddToSuperViewNotification object:nil];
}

#pragma mark - notification
- (void)didFullyDisplayedNotification {
    [self configureStreachScrollViewDelegate];
}



- (void)didAddToSuperViewNotification {
    UIScrollView *basicScrollView = self.basicScrollView;
    CGFloat basicScrollViewContentOffsetY = basicScrollView.contentOffset.y;
    if (basicScrollViewContentOffsetY != [self maximumContentOffsetY]) {
        NSArray<UIViewController *> *childViewControllers = self.childViewControllers;
        for (UIViewController *viewController in childViewControllers) {
            if ([self hasStreachScrollViewWithViewController:viewController]) {
                if (viewController != self.currentViewController) {
                    UIScrollView *scrollView = [(id<WMStickyPageViewControllerDelegate>)viewController streachScrollView];
                    if (scrollView.contentOffset.y != 0) {
                        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
                    }
                }
            }
        }
    }
}

#pragma mark - public
- (void)updateStreachScrollViewIfNeeded {
    [self configureStreachScrollViewDelegate];
}



#pragma mark - delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [super scrollViewWillBeginDragging:scrollView];
    [self.animator removeAllBehaviors];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];
    
    if (_disableSticky) return;
    
    CGFloat maximumContentOffsetY = self.maximumContentOffsetY;
    
    UIViewController *currentViewController = self.currentViewController;
    if ([self hasStreachScrollViewWithViewController:currentViewController]) {
        UIScrollView *currentScrollView = [(id<WMStickyPageViewControllerDelegate>)currentViewController streachScrollView];
        if (currentScrollView == scrollView) {
            UIScrollView *basicScrollView = self.basicScrollView;
            CGFloat basicScrollViewContentOffsetY = basicScrollView.contentOffset.y;
            CGFloat scrollViewContentOffsetY = scrollView.contentOffset.y;
            
            if (basicScrollViewContentOffsetY < 0) {
                basicScrollViewContentOffsetY = 0;
            }else if (basicScrollViewContentOffsetY >= 0 && basicScrollViewContentOffsetY < maximumContentOffsetY) {
                if (basicScrollViewContentOffsetY == 0) {
                    if (scrollViewContentOffsetY > 0) {
                        basicScrollViewContentOffsetY += scrollViewContentOffsetY;
                    }
                }else {
                    basicScrollViewContentOffsetY += scrollViewContentOffsetY;
                    scrollViewContentOffsetY = 0;
                }
            }else {
                if (scrollViewContentOffsetY < 0) {
                    basicScrollViewContentOffsetY += scrollViewContentOffsetY;
                    scrollViewContentOffsetY = 0;
                }else {
                    basicScrollViewContentOffsetY = maximumContentOffsetY;
                }
            }
            
            
            basicScrollView.contentOffset = CGPointMake(basicScrollView.contentOffset.x, basicScrollViewContentOffsetY);
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollViewContentOffsetY);
            
        }else {
            if (scrollView == self.basicScrollView) {
                if (self.basicScrollView.contentOffset.y > maximumContentOffsetY) {
                    self.basicScrollView.contentOffset = CGPointMake(self.basicScrollView.contentOffset.x, maximumContentOffsetY);
                }
            }
        }
    }else {
        if (scrollView == self.basicScrollView) {
            if (self.basicScrollView.contentOffset.y > maximumContentOffsetY) {
                self.basicScrollView.contentOffset = CGPointMake(self.basicScrollView.contentOffset.x, maximumContentOffsetY);
            }
        }
    }
    
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    [super scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    NSLog(@"CGPoint: %@", NSStringFromCGPoint(velocity));
    if (scrollView != [self streachScrollViewFromViewController:self.currentViewController]) {
        return;
    }
    CGFloat maximumContentOffsetY = self.maximumContentOffsetY;
    CGFloat contentOffsetY = self.basicScrollView.contentOffset.y;
    if (!(contentOffsetY > 0 && contentOffsetY < maximumContentOffsetY)) {
        return;
    }
    
    if (velocity.y == 0) {
        return;
    }
    
    [self.animator removeAllBehaviors];
    WMStickyPageViewControllerDynamicItem *item = [WMStickyPageViewControllerDynamicItem new];
    item.center = self.basicScrollView.contentOffset;
    UIDynamicItemBehavior *inertialBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[item]];
    CGFloat dynamicItemVelocityY = velocity.y > 0 ? 400 : -400;
    [inertialBehavior addLinearVelocity:CGPointMake(0, dynamicItemVelocityY) forItem:item];
    inertialBehavior.resistance = 1;
    __weak __typeof(self) weak_self = self;
    inertialBehavior.action = ^(){
        __strong __typeof(weak_self) self = weak_self;
        CGFloat contentOffsetY = item.center.y;
        
        if (contentOffsetY > maximumContentOffsetY) {
            [self.animator removeAllBehaviors];
            contentOffsetY = maximumContentOffsetY;
        }else if (contentOffsetY < 0) {
            [self.animator removeAllBehaviors];
            contentOffsetY = 0;
        }
        
        if (!isnan(contentOffsetY)) {
            self.basicScrollView.contentOffset = CGPointMake(0, contentOffsetY);
        }
    };
    [self.animator addBehavior:inertialBehavior];
}





- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat originY = self.headerViewHeight;
    if (originY <= 0) {
        originY = (self.showOnNavigationBar && self.navigationController.navigationBar) ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    }
    return CGRectMake(0, originY, self.view.frame.size.width, self.menuViewHeight);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGRect preferredFrameForMenuView = [self pageController:pageController preferredFrameForMenuView:pageController.menuView];
    CGFloat tabBarHeight = self.tabBarController.tabBar && !self.tabBarController.tabBar.hidden ? self.tabBarController.tabBar.frame.size.height : 0;
    if (_disableSticky) {
        return CGRectMake(0, CGRectGetMaxY(preferredFrameForMenuView), CGRectGetWidth(preferredFrameForMenuView),self.view.frame.size.height - self.minimumTopInset - CGRectGetMaxY(preferredFrameForMenuView) - tabBarHeight);
    }else {
        return CGRectMake(0, CGRectGetMaxY(preferredFrameForMenuView), CGRectGetWidth(preferredFrameForMenuView),self.view.frame.size.height - self.minimumTopInset - CGRectGetHeight(preferredFrameForMenuView) - tabBarHeight);
    }
    
}

#pragma mark - utilities
- (void)configureStreachScrollViewDelegate {
    UIViewController *currentViewController = self.currentViewController;
    UIScrollView *scrollView = [self streachScrollViewFromViewController:currentViewController];
    scrollView.delegate = self;
}

- (UIScrollView *)streachScrollViewFromViewController:(UIViewController *)viewController {
    if ([self hasStreachScrollViewWithViewController:viewController]) {
        return [(id<WMStickyPageViewControllerDelegate>)viewController streachScrollView];
    }else {
        return nil;
    }
}

- (BOOL)hasStreachScrollViewWithViewController:(UIViewController *)viewController {
    return [viewController conformsToProtocol:@protocol(WMStickyPageViewControllerDelegate)] &&
    [viewController respondsToSelector:@selector(streachScrollView)];
}

#pragma mark - setter && getter
- (UIScrollView *)basicScrollView {
    return (UIScrollView *)self.view;
}


- (CGFloat)maximumContentOffsetY {
    return floor(self.headerViewHeight - self.minimumTopInset);
}

@end
