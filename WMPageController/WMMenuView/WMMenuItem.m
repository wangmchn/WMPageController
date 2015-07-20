//
//  WMMenuItem.m
//  WMPageController
//
//  Created by Mark on 15/4/26.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WMMenuItem.h"
#define kSelectedSize 18
#define kNormolSize   15
#define kAnimateStep  0.05
#define kAnimateRate  0.1

#define kSelectedColor  [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1]
#define kNormalColor    [UIColor colorWithRed:0 green:0 blue:0 alpha:1]

@interface WMMenuItem (){
    CGFloat rgba[4];
    CGFloat rgbaGAP[4];
    BOOL    hasRGBA;
}
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, assign) CGFloat sizeGap;
@end

@implementation WMMenuItem
#pragma mark - Public Methods
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        hasRGBA = NO;
    }
    return self;
}
- (void)setTitle:(NSString *)title{
    _title = title;
    [self setNeedsDisplay];
}
- (void)setFontSize:(CGFloat)fontSize{
    if (self.fontName) {
        self.font = [UIFont fontWithName:self.fontName size:fontSize];
    }else{
        self.font = [UIFont systemFontOfSize:fontSize];
    }
    _fontSize = fontSize;
    [self setNeedsDisplay];
}
- (void)setFontName:(NSString *)fontName{
    _fontName = fontName;
    self.fontSize = self.normalSize+self.sizeGap*self.rate;
    [self setNeedsDisplay];
}
- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    [self setNeedsDisplay];
}
// 设置选中，隐式动画所在
- (void)setSelected:(BOOL)selected{
    _selected = selected;
    if (self.link) return;
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeTitle)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
// 设置rate,并刷新标题状态
- (void)setRate:(CGFloat)rate{
    _rate = rate;
    [self updateFontAndRGB];
}
- (void)selectedItemWithoutAnimation{
    self.titleColor = self.selectedColor;
    self.fontSize = self.selectedSize;
    _rate = 1.0;
    _selected = YES;
    [self setNeedsDisplay];
}
- (void)deselectedItemWithoutAnimation{
    self.titleColor = self.normalColor;
    self.fontSize = self.normalSize;
    _rate = 0;
    _selected = NO;
    [self setNeedsDisplay];
}
#pragma mark - Lazy loading
- (CGFloat)normalSize{
    if (!_normalSize) {
        _normalSize = kNormolSize;
    }
    return _normalSize;
}
- (CGFloat)selectedSize{
    if (!_selectedSize) {
        _selectedSize = kSelectedSize;
    }
    return _selectedSize;
}
- (CGFloat)sizeGap{
    if (!_sizeGap) {
        _sizeGap = self.selectedSize - self.normalSize;
    }
    return _sizeGap;
}
- (UIColor *)selectedColor{
    if (!_selectedColor) {
        _selectedColor = kSelectedColor;
    }
    return _selectedColor;
}
- (UIColor *)normalColor{
    if (!_normalColor) {
        _normalColor = kNormalColor;
    }
    return _normalColor;
}
#pragma mark - Private Methods
// 重绘
- (void)drawRect:(CGRect)rect {
    if (self.title) {
        if (self.font == nil) {
            self.fontSize = self.normalSize;
        }
        if (self.titleColor == nil) {
            self.titleColor = self.normalColor;
        }
        NSDictionary *attrs = @{NSFontAttributeName:self.font,
                                NSForegroundColorAttributeName:self.titleColor
                                };
        CGSize size = [self.title sizeWithAttributes:attrs];
        CGFloat x = (self.frame.size.width - size.width)/2;
        CGFloat y = (self.frame.size.height - size.height)/2;
        [self.title drawAtPoint:CGPointMake(x, y) withAttributes:attrs];
    }
}
// 记录normal的rgba值以及nor和sel的r、g、b、a的差值，以便后续使用
- (void)setRBGA{
    int numNormal = (int)CGColorGetNumberOfComponents(self.normalColor.CGColor);
    int numSelected = (int)CGColorGetNumberOfComponents(self.selectedColor.CGColor);
    if (numNormal == 4&&numSelected == 4) {
        // UIDeviceRGBColorSpace
        const CGFloat *norComponents = CGColorGetComponents(self.normalColor.CGColor);
        const CGFloat *selComponents = CGColorGetComponents(self.selectedColor.CGColor);
        rgba[0] = norComponents[0];
        rgbaGAP[0] =  selComponents[0]-rgba[0];
        rgba[1] = norComponents[1];
        rgbaGAP[1] = selComponents[1]-rgba[1];
        rgba[2] = norComponents[2];
        rgbaGAP[2] = selComponents[2]-rgba[2];
        rgba[3] = norComponents[3];
        rgbaGAP[3] =  selComponents[3]-rgba[3];
    }else if (numNormal == 2 || numSelected == 2) {
        // 将灰度空间 (grayColor blackColor ect.) 转为 RGBA 色彩空间
        if (numNormal == 2) {
            const CGFloat *norComponents = CGColorGetComponents(self.normalColor.CGColor);
            self.normalColor = [UIColor colorWithRed:norComponents[0] green:norComponents[0] blue:norComponents[0] alpha:norComponents[1]];
        }
        if (numSelected == 2) {
            const CGFloat *selComponents = CGColorGetComponents(self.selectedColor.CGColor);
            self.selectedColor = [UIColor colorWithRed:selComponents[0] green:selComponents[0] blue:selComponents[0] alpha:selComponents[1]];
        }
        [self setRBGA];
        return;
    }else{
        NSAssert(NO, @"Error with item's color (`titleColorSelected`), may use `colorWithRed:green:blue:alpha:` can solve the problem.");
    }
    hasRGBA = YES;
}

// 触摸事件，告诉代理被触摸(点击)
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(didPressedMenuItem:)]) {
        [self.delegate didPressedMenuItem:self];
    }
}
// 更新自身的标题的字体大小及颜色
- (void)updateFontAndRGB{
    if (!hasRGBA) {
        [self setRBGA];
    }
    CGFloat fontSize = self.normalSize+self.sizeGap*self.rate;
    CGFloat r = rgba[0] + rgbaGAP[0]*self.rate;
    CGFloat g = rgba[1] + rgbaGAP[1]*self.rate;
    CGFloat b = rgba[2] + rgbaGAP[2]*self.rate;
    CGFloat a = rgba[3] + rgbaGAP[3]*self.rate;
    self.titleColor = [UIColor colorWithRed:r green:g blue:b alpha:a];
    self.fontSize = fontSize;
}
// 隐式动画的实现
- (void)changeTitle{
    if (!hasRGBA) {
        [self setRBGA];
    }
    if (self.isSelected) {
        if (self.rate < 1.0f) {
            self.rate += kAnimateRate;
        }else{
            [self.link invalidate];
            self.link = nil;
        }
    }else{
        if (self.rate > 0.0f) {
            self.rate -= kAnimateRate;
        }else{
            [self.link invalidate];
            self.link = nil;
        }
    }
}

@end
