//
//  WMImageViewCell.m
//  WMPageController
//
//  Created by Mark on 15/6/14.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WMImageViewCell.h"

@interface WMImageViewCell ()

@end

@implementation WMImageViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        _imageView = imageView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

@end
