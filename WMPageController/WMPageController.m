//
//  WMPageController.m
//  WMPageController
//
//  Created by Mark on 15/6/11.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WMPageController.h"
#import "WMPageConst.h"
@interface WMPageController () <WMMenuViewDelegate,UIScrollViewDelegate>{
    CGFloat viewHeight;
    CGFloat viewWidth;
    BOOL animate;
}
@property (nonatomic, weak)   WMMenuView *menuView;
@property (nonatomic, weak)   UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *childViewFrames;
@property (nonatomic, strong) NSMutableDictionary *displayVC;
@end

@implementation WMPageController
- (instancetype)initWithViewControllerClasses:(NSArray *)classes andTheirTitles:(NSArray *)titles{
    if (self = [super init]) {
        self.viewControllerClasses = [NSArray arrayWithArray:classes];
        self.titles = titles;
        
        [self setup];
    }
    return self;
}
- (instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}
- (void)setSelectIndex:(int)selectIndex{
    _selectIndex = selectIndex;
    if (self.menuView) {
        [self.menuView selectItemAtIndex:selectIndex];
    }
}
- (void)setup{
    self.titleSizeSelected = WMTitleSizeSelected;
    self.titleColorSelected = WMTitleColorSelected;
    self.titleSizeNormal = WMTitleSizeNormal;
    self.titleColorNormal = WMTitleColorNormal;
    
    self.menuBGColor = WMMenuBGColor;
    self.menuHeight = WMMenuHeight;
    self.menuItemWidth = WMMenuItemWidth;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self calculateSize];
    [self addScrollView];
    [self addMenuView];
    if (self.selectIndex != 0) {
        [self.menuView selectItemAtIndex:self.selectIndex];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Lazy Loading
- (NSMutableArray *)childViewFrames{
    if (_childViewFrames == nil) {
        _childViewFrames = [NSMutableArray array];
        for (int i = 0; i < self.viewControllerClasses.count; i++) {
            CGRect frame = CGRectMake(i*viewWidth, 0, viewWidth, viewHeight);
            [_childViewFrames addObject:[NSValue valueWithCGRect:frame]];
        }
    }
    return _childViewFrames;
}
- (NSMutableDictionary *)displayVC{
    if (_displayVC == nil) {
        _displayVC = [NSMutableDictionary dictionary];
    }
    return _displayVC;
}
#pragma mark - Private Methods
- (void)addViewControllerAtIndex:(int)index{
    Class vcClass = self.viewControllerClasses[index];
    UIViewController *viewController = [[vcClass alloc] init];
    viewController.view.frame = [self.childViewFrames[index] CGRectValue];
    [self addChildViewController:viewController];
    [viewController didMoveToParentViewController:self];
    [self.scrollView addSubview:viewController.view];
    self.currentViewController = viewController;
    
    [self.displayVC setObject:viewController forKey:@(index)];
}
- (void)calculateSize{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (self.navigationController) {
        viewHeight = self.view.frame.size.height - self.menuHeight - 64;
    }else{
        viewHeight = self.view.frame.size.height - self.menuHeight - 0;
    }
    viewWidth = self.view.frame.size.width;
}
- (void)addScrollView{
    CGRect frame = CGRectMake(0, self.menuHeight, viewWidth, viewHeight);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    
    scrollView.contentSize = CGSizeMake(self.viewControllerClasses.count*viewWidth, viewHeight);
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    [self addViewControllerAtIndex:0];
    
}
- (void)addMenuView{
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.menuHeight);
    WMMenuView *menuView = [[WMMenuView alloc] initWithFrame:frame buttonItems:self.titles backgroundColor:self.menuBGColor norSize:self.titleSizeNormal selSize:self.titleSizeSelected norColor:self.titleColorNormal selColor:self.titleColorSelected];
    menuView.delegate = self;
    menuView.style = self.menuViewStyle;
    [self.view addSubview:menuView];
    self.menuView = menuView;
}
- (void)layoutChildViewControllers{
    int currentPage = (int)self.scrollView.contentOffset.x / viewWidth;
    int start,end;
    if (currentPage == 0) {
        start = currentPage;
        end = currentPage + 1;
    }else if (currentPage + 1 == self.viewControllerClasses.count){
        start = currentPage - 1;
        end = currentPage;
    }else{
        start = currentPage - 1;
        end = currentPage + 1;
    }
    for (int i = start; i <= end; i++) {
        CGRect frame = [self.childViewFrames[i] CGRectValue];
        UIViewController *vc = [self.displayVC objectForKey:@(i)];
        if ([self isInScreen:frame]) {
            if (vc == nil) {
                [self addViewControllerAtIndex:i];
            }
        }else{
            if (vc) {
                [vc.view removeFromSuperview];
                [vc willMoveToParentViewController:nil];
                [vc removeFromParentViewController];
                
                [self.displayVC removeObjectForKey:@(i)];
            }
        }
    }
}
- (BOOL)isInScreen:(CGRect)frame{
    CGFloat x = frame.origin.x;
    CGFloat ScreenWidth = self.scrollView.frame.size.width;
    
    CGFloat contentOffsetX = self.scrollView.contentOffset.x;
    if (CGRectGetMaxX(frame) > contentOffsetX && x-contentOffsetX < ScreenWidth) {
        return YES;
    }else{
        return NO;
    }
}
#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self layoutChildViewControllers];
    if (animate) {
        CGFloat width = scrollView.frame.size.width;
        CGFloat contentOffsetX = scrollView.contentOffset.x;
        CGFloat rate = contentOffsetX / width;
        [self.menuView slideMenuAtProgress:rate];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    animate = YES;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _selectIndex = (int)scrollView.contentOffset.x / viewWidth;
}
#pragma mark - WMMenuView Delegate
- (void)menuView:(WMMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex{
    NSInteger gap = (NSInteger)labs(index - currentIndex);
    animate = NO;
    CGPoint targetP = CGPointMake(viewWidth*index, 0);
    
    [self.scrollView setContentOffset:targetP animated:gap > 1?NO:self.pageAnimatable];
}
- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index{
    if (self.itemsWidths) {
        return [self.itemsWidths[index] floatValue];
    }
    return self.menuItemWidth;
}
@end
