//
//  WMMenuItem.m
//  WMPageController
//
//  Created by Mark on 15/4/26.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WMMenuItem.h"

@interface WMMenuItem () {
    CGFloat _selectedRed, _selectedGreen, _selectedBlue, _selectedAlpha;
    CGFloat _normalRed, _normalGreen, _normalBlue, _normalAlpha;
}
@end

@implementation WMMenuItem

#pragma mark - Public Methods
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.normalColor   = [UIColor blackColor];
        self.selectedColor = [UIColor blackColor];
        self.normalSize    = 15;
        self.selectedSize  = 18;
        self.numberOfLines = 0;
    }
    return self;
}

// 设置选中，隐式动画所在
- (void)setSelected:(BOOL)selected {
    if (self.selected == selected) { return; }
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
    CGFloat r = _normalRed + (_selectedRed - _normalRed) * rate;
    CGFloat g = _normalGreen + (_selectedGreen - _normalGreen) * rate;
    CGFloat b = _normalBlue + (_selectedBlue - _normalBlue) * rate;
    CGFloat a = _normalAlpha + (_selectedAlpha - _normalAlpha) * rate;
    self.textColor = [UIColor colorWithRed:r green:g blue:b alpha:a];
    CGFloat minScale = self.normalSize / self.selectedSize;
    CGFloat trueScale = minScale + (1 - minScale)*rate;
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

- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    [selectedColor getRed:&_selectedRed green:&_selectedGreen blue:&_selectedBlue alpha:&_selectedAlpha];
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    [normalColor getRed:&_normalRed green:&_normalGreen blue:&_normalBlue alpha:&_normalAlpha];
}

#pragma mark - Private Methods

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(didPressedMenuItem:)]) {
        [self.delegate didPressedMenuItem:self];
    }
}

@end
