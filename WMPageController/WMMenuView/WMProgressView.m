//
//  WMProgressView.m
//  WMPageController
//
//  Created by Mark on 15/6/20.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WMProgressView.h"
@implementation WMProgressView {
    int sign;
    CGFloat gap;
    CGFloat step;
    __weak CADisplayLink *_link;
}

- (void)setProgressWithOutAnimate:(CGFloat)progress {
    if (self.progress == progress) return;
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)setProgress:(CGFloat)progress {
    if (self.progress == progress) return;
    if (fabs(progress - _progress) >= 0.94 && fabs(progress - _progress) < 1.2) {
        gap  = fabs(self.progress - progress);
        sign = self.progress > progress ? -1 : 1;
        step = gap / 20.0;
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(progressChanged)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        _link = link;
        return;
    }
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)progressChanged {
    if (gap >= 0.0) {
        self.progress += sign * step;
        gap -= step;
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
    CGFloat rate = self.progress - index;
    CGRect currentFrame = [self.itemFrames[index] CGRectValue];
    CGFloat currentWidth = currentFrame.size.width;
    int nextIndex = index + 1 < self.itemFrames.count ? index + 1 : index;
    CGFloat nextWidth = [self.itemFrames[nextIndex] CGRectValue].size.width;
    CGFloat height = self.frame.size.height;
    CGFloat constY = height / 2;
    CGFloat currentX = currentFrame.origin.x;
    CGFloat nextX = [self.itemFrames[nextIndex] CGRectValue].origin.x;
    CGFloat startX = currentX + (nextX - currentX) * rate;
    CGFloat endX = startX + currentWidth + (nextWidth - currentWidth)*rate;
    CGContextMoveToPoint(ctx, startX, constY);
    CGContextAddLineToPoint(ctx, endX, constY);
    CGContextSetLineWidth(ctx, height);
    CGContextSetStrokeColorWithColor(ctx, self.color);
    CGContextStrokePath(ctx);
}

@end
