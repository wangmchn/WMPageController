//
//  WMFloodView.m
//  WMPageController
//
//  Created by Mark on 15/7/13.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WMFloodView.h"

@implementation WMFloodView {
    CGFloat WMFloodMargin;
    CGFloat WMFloodRadius;
    CGFloat WMFloodLength;
    CGFloat WMFloodHeight;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        WMFloodHeight = frame.size.height;
        WMFloodMargin = WMFloodHeight * 0.15;
        WMFloodRadius = (WMFloodHeight - WMFloodMargin * 2) / 2;
        WMFloodLength = frame.size.width  - WMFloodRadius * 2;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    int currentIndex = (int)self.progress;
    currentIndex = (currentIndex <= self.itemFrames.count - 1) ? currentIndex : (int)self.itemFrames.count - 1;
    CGFloat rate = self.progress - currentIndex;
    int nextIndex = currentIndex + 1 < self.itemFrames.count ? currentIndex + 1 : currentIndex;

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
    CGContextTranslateCTM(ctx, 0.0f, WMFloodHeight);
    CGContextScaleCTM(ctx, 1.0f, -1.0f);
    CGContextAddArc(ctx, startX+WMFloodRadius, WMFloodHeight / 2.0, WMFloodRadius, M_PI_2, M_PI_2 * 3, 0);
    CGContextAddLineToPoint(ctx, endX-WMFloodRadius, WMFloodMargin);
    CGContextAddArc(ctx, endX-WMFloodRadius, WMFloodHeight / 2.0, WMFloodRadius, -M_PI_2, M_PI_2, 0);
    CGContextClosePath(ctx);
    
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
