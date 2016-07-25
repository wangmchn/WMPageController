//
//  WMProgressView.h
//  WMPageController
//
//  Created by Mark on 15/6/20.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMProgressView : UIView
@property (nonatomic, strong) NSArray *itemFrames;
@property (nonatomic, assign) CGColorRef color;
@property (nonatomic, assign) CGFloat progress;
/** 进度条的速度因数，默认为 15，越小越快， 大于 0 */
@property (nonatomic, assign) CGFloat speedFactor;

- (void)setProgressWithOutAnimate:(CGFloat)progress;
- (void)moveToPostion:(NSInteger)pos;
@end
