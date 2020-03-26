//
//  UIFont+WMPageController.h
//  WMPageController
//
//  Created by Neil on 2019/12/18.
//  Copyright © 2019 UBNT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (WMPageController)

/// iOS 13 开始 [UIFont fontWithName:@".SFUI-*" size:fontSize] 创建系统字体失败
/// 必须要用 [UIFont systemFontOfSize:@".SFUI-*" weight:weight] 来创建
///
/// @param fontName 字体名称
/// @param fontSize 字体大小
+ (nullable UIFont *)wm_fontWithName:(NSString *)fontName size:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
