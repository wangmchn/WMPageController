//
//  WMCustomizedPageController.h
//  WMPageControllerExample
//
//  Created by Mark on 2017/6/21.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "WMPageController.h"

typedef NS_ENUM(NSUInteger, WMMenuViewPosition) {
    WMMenuViewPositionDefault,
    WMMenuViewPositionBottom,
};

@interface WMCustomizedPageController : WMPageController
@property (nonatomic, assign) WMMenuViewPosition menuViewPosition;
@end
