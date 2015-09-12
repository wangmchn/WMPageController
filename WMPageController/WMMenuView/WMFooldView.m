//
//  WMFooldView.m
//  WMPageController
//
//  Created by Mark on 15/7/13.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WMFooldView.h"

@implementation WMFooldView {
    CGFloat WMFooldMargin;
    CGFloat WMFooldRadius;
    CGFloat WMFooldLength;
    CGFloat WMFooldHeight;
<<<<<<< HEAD
    int     sign;
    CGFloat gap;
    CGFloat step;
    CADisplayLink *link;
    CGFloat kTime;
=======
    CGFloat gap;
    CGFloat step;
    CGFloat kTime;
    int     sign;
    
    __weak CADisplayLink *_link;
>>>>>>> master
}

@synthesize progress = _progress;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        WMFooldHeight = frame.size.height;
        WMFooldMargin = WMFooldHeight * 0.15;
<<<<<<< HEAD
        WMFooldRadius = (WMFooldHeight - 2*WMFooldMargin)/2;
        WMFooldLength = frame.size.width  - 2*WMFooldRadius;
=======
        WMFooldRadius = (WMFooldHeight - WMFooldMargin * 2) / 2;
        WMFooldLength = frame.size.width  - WMFooldRadius * 2;
>>>>>>> master
        kTime = 20.0;
    }
    return self;
}

- (void)setProgressWithOutAnimate:(CGFloat)progress {
    if (self.progress == progress) return;
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)setProgress:(CGFloat)progress {
    if (self.progress == progress) return;
    if (fabs(progress - _progress) >= 0.9 && fabs(progress - _progress) < 1.5) {
        gap  = fabs(self.progress - progress);
<<<<<<< HEAD
        sign = self.progress>progress?-1:1;
=======
        sign = self.progress > progress ? - 1 : 1;
>>>>>>> master
        if (self.itemFrames.count <= 3) {
            kTime = 15.0;
        }
        step = gap / kTime;
<<<<<<< HEAD
        link = [CADisplayLink displayLinkWithTarget:self selector:@selector(progressChanged)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
=======
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(progressChanged)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        _link = link;
>>>>>>> master
        return;
    }
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)progressChanged {
    if (gap >= 0.0) {
        gap -= step;
        if (gap < 0.0) {
<<<<<<< HEAD
            self.progress = (int)(self.progress+0.5);
=======
            self.progress = (int)(self.progress + 0.5);
>>>>>>> master
            return;
        }
        self.progress += sign * step;
    } else {
<<<<<<< HEAD
        self.progress = (int)(self.progress+0.5);
        [link invalidate];
        link = nil;
=======
        self.progress = (int)(self.progress + 0.5);
        [_link invalidate];
        _link = nil;
>>>>>>> master
    }
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    int currentIndex = (int)self.progress;
    CGFloat rate = self.progress - currentIndex;
<<<<<<< HEAD
    int nextIndex = currentIndex+1 >= self.itemFrames.count ?: currentIndex+1;
=======
    int nextIndex = currentIndex + 1 >= self.itemFrames.count ?: currentIndex + 1;
>>>>>>> master

    // 当前item的各数值
    CGRect  currentFrame = [self.itemFrames[currentIndex] CGRectValue];
    CGFloat currentWidth = currentFrame.size.width;
    CGFloat currentX = currentFrame.origin.x;
    // 下一个item的各数值
    CGFloat nextWidth = [self.itemFrames[nextIndex] CGRectValue].size.width;
    CGFloat nextX = [self.itemFrames[nextIndex] CGRectValue].origin.x;
    // 计算点
    CGFloat startX = currentX + (nextX - currentX) * rate;
    CGFloat endX = startX + currentWidth + (nextWidth - currentWidth)*rate;
    // 绘制
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, 0.0f, WMFooldHeight);
    CGContextScaleCTM(ctx, 1.0f, -1.0f);
<<<<<<< HEAD
    CGContextAddArc(ctx, startX+WMFooldRadius, WMFooldHeight/2.0, WMFooldRadius, M_PI_2, M_PI_2*3, 0);
    CGContextAddLineToPoint(ctx, endX-WMFooldRadius, WMFooldMargin);
    CGContextAddArc(ctx, endX-WMFooldRadius, WMFooldHeight/2.0, WMFooldRadius, -M_PI_2, M_PI_2, 0);
    CGContextClosePath(ctx);

=======
    CGContextAddArc(ctx, startX+WMFooldRadius, WMFooldHeight / 2.0, WMFooldRadius, M_PI_2, M_PI_2 * 3, 0);
    CGContextAddLineToPoint(ctx, endX-WMFooldRadius, WMFooldMargin);
    CGContextAddArc(ctx, endX-WMFooldRadius, WMFooldHeight / 2.0, WMFooldRadius, -M_PI_2, M_PI_2, 0);
    CGContextClosePath(ctx);
    
>>>>>>> master
    if (self.hollow) {
        CGContextSetStrokeColorWithColor(ctx, self.color);
        CGContextStrokePath(ctx);
        return;
    }
    CGContextClosePath(ctx);
    CGContextSetFillColorWithColor(ctx, self.color);
    CGContextFillPath(ctx);
}

@end
