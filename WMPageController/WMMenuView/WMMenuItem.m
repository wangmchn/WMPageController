//
//  WMMenuItem.m
//  WMPageController
//
//  Created by Mark on 15/4/26.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WMMenuItem.h"
#define kSelectedSize 18
#define kNormalSize   15
#define kSelectedColor  [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1]
#define kNormalColor    [UIColor colorWithRed:0 green:0 blue:0 alpha:1]

@interface WMMenuItem () {
    CGFloat rgba[4];
    CGFloat rgbaGAP[4];
    BOOL    hasRGBA;
}
@end

@implementation WMMenuItem

#pragma mark - Public Methods
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        hasRGBA = NO;
        _normalColor   = kNormalColor;
        _selectedColor = kSelectedColor;
        _normalSize    = kNormalSize;
        _selectedSize  = kSelectedSize;
    }
    return self;
}

// 设置选中，隐式动画所在
- (void)setSelected:(BOOL)selected {
    if (self.selected == selected) {
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        if (self.selected == YES) {
            self.rate = 0.0;
        } else {
            self.rate = 1.0;
        }
        _selected = selected;
    } completion:nil];
}

// 设置rate,并刷新标题状态
- (void)setRate:(CGFloat)rate {
    _rate = rate;
    if (!hasRGBA) {
        [self setRBGA];
    }
    CGFloat r = rgba[0] + rgbaGAP[0]*self.rate;
    CGFloat g = rgba[1] + rgbaGAP[1]*self.rate;
    CGFloat b = rgba[2] + rgbaGAP[2]*self.rate;
    CGFloat a = rgba[3] + rgbaGAP[3]*self.rate;
    self.textColor = [UIColor colorWithRed:r green:g blue:b alpha:a];
    CGFloat minScale = self.normalSize / self.selectedSize;
    CGFloat trueScale = minScale + (1-minScale)*rate;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}

- (void)selectedItemWithoutAnimation {
    self.rate = 1.0;
    _selected = YES;
}

- (void)deselectedItemWithoutAnimation {
    self.rate = 0;
    _selected = NO;
}

#pragma mark - Private Methods
// 记录normal的rgba值以及nor和sel的r、g、b、a的差值，以便后续使用
- (void)setRBGA {
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
    } else if (numNormal == 2 || numSelected == 2) {
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
    } else {
        NSAssert(NO, @"Error with item's color (`titleColorSelected`), may use `colorWithRed:green:blue:alpha:` can solve the problem.");
    }
    hasRGBA = YES;
}

// 触摸事件，告诉代理被触摸(点击)
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(didPressedMenuItem:)]) {
        [self.delegate didPressedMenuItem:self];
    }
}

@end
