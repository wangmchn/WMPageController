//
//  WMProgressView.m
//  WMPageController
//
//  Created by Mark on 15/6/20.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WMProgressView.h"
@implementation WMProgressView {
    int     _sign;
    CGFloat _gap;
    CGFloat _step;
    __weak  CADisplayLink *_link;
}

- (CGFloat)speedFactor {
    if (_speedFactor <= 0) {
        _speedFactor = 15.0;
    }
    return _speedFactor;
}

- (void)setProgressWithOutAnimate:(CGFloat)progress {
    if (self.progress == progress) return;
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self setNeedsDisplay];
}

- (void)moveToPostion:(NSInteger)pos {
    _gap = fabs(self.progress - pos);
    _sign = self.progress > pos ? -1 : 1;
    _step = _gap / self.speedFactor;
    if (_link) {
        [_link invalidate];
        [_link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(progressChanged)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    _link = link;
}

- (void)setProgress:(CGFloat)progress {
    if (self.progress == progress) return;
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)progressChanged {
    if (_gap > 0.000001) {
        _gap -= _step;
        if (_gap < 0.0) {
            self.progress = (int)(self.progress + _sign * _step + 0.5);
            return;
        }
        self.progress += _sign * _step;
    } else {
        self.progress = (int)(self.progress + 0.5);
        [_link invalidate];
        _link = nil;
    }
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    int index = (int)self.progress;
    index = (index <= self.itemFrames.count - 1) ? index : (int)self.itemFrames.count - 1;
    CGFloat rate = self.progress - index;
    CGRect currentFrame = [self.itemFrames[index] CGRectValue];
    CGFloat currentWidth = currentFrame.size.width;
    int nextIndex = index + 1 < self.itemFrames.count ? index + 1 : index;
    CGFloat nextWidth = [self.itemFrames[nextIndex] CGRectValue].size.width;
    CGFloat height = self.frame.size.height;
    CGFloat currentX = currentFrame.origin.x;
    CGFloat nextX = [self.itemFrames[nextIndex] CGRectValue].origin.x;
    CGFloat startX = currentX + (nextX - currentX) * rate;
    CGFloat width = currentWidth + (nextWidth - currentWidth)*rate;
    
    CGFloat lineWidth = (self.hollow || self.hasBorder) ? 1.0 : 0.0;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(startX, lineWidth / 2.0, width, height - lineWidth) cornerRadius:self.cornerRadius];
    
    CGContextAddPath(ctx, path.CGPath);
    
    if (self.hollow) {
        CGContextSetStrokeColorWithColor(ctx, self.color);
        CGContextStrokePath(ctx);
        return;
    }
    CGContextSetFillColorWithColor(ctx, self.color);
    CGContextFillPath(ctx);
    
    if (self.hasBorder) {
        // 计算点
        CGFloat startX = CGRectGetMinX([self.itemFrames.firstObject CGRectValue]);
        CGFloat endX = CGRectGetMaxX([self.itemFrames.lastObject CGRectValue]);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(startX, lineWidth / 2.0, (endX - startX), height - lineWidth) cornerRadius:self.cornerRadius];
        CGContextSetLineWidth(ctx, lineWidth);
        CGContextAddPath(ctx, path.CGPath);
        
        // 绘制
        CGContextSetStrokeColorWithColor(ctx, self.color);
        CGContextStrokePath(ctx);
    }
    
}

@end
