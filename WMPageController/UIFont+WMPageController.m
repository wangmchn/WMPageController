//
//  UIFont+WMPageController.m
//  WMPageController
//
//  Created by Neil on 2019/12/18.
//  Copyright © 2019 UBNT. All rights reserved.
//

#import "UIFont+WMPageController.h"

@implementation UIFont (WMPageController)

static NSDictionary *_nameWeightMap = nil;

+ (NSDictionary *)wm_UIFontNameWeightMap {
    if (!_nameWeightMap) {
        if (@available(iOS 13.0, *)) {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                _nameWeightMap = @{
                    @".SFUI-Ultralight": @(UIFontWeightUltraLight),
                    @".SFUI-Thin": @(UIFontWeightThin),
                    @".SFUI-Light": @(UIFontWeightLight),
                    @".SFUI-Regular": @(UIFontWeightRegular),
                    @".SFUI-Medium": @(UIFontWeightMedium),
                    @".SFUI-Semibold": @(UIFontWeightSemibold),
                    @".SFUI-Bold": @(UIFontWeightBold),
                    @".SFUI-Heavy": @(UIFontWeightHeavy),
                    @".SFUI-Black": @(UIFontWeightBlack),
                    
                    @".SFNS-Ultralight": @(UIFontWeightUltraLight),
                    @".SFNS-Thin": @(UIFontWeightThin),
                    @".SFNS-Light": @(UIFontWeightLight),
                    @".SFNS-Regular": @(UIFontWeightRegular),
                    @".SFNS-Medium": @(UIFontWeightMedium),
                    @".SFNS-Semibold": @(UIFontWeightSemibold),
                    @".SFNS-Bold": @(UIFontWeightBold),
                    @".SFNS-Heavy": @(UIFontWeightHeavy),
                    @".SFNS-Black": @(UIFontWeightBlack),
                };
            });
        }
    }
    return _nameWeightMap;
}

+ (nullable UIFont *)wm_fontWithName:(NSString *)fontName size:(CGFloat)fontSize {
    if (!fontName.length) {
        return nil;
    }
    
    if (@available(iOS 13.0, *)) {
        /// Mac Catalyst 是 ".SFNS-" 为前缀
        if ([fontName hasPrefix:@".SFUI-"] || [fontName hasPrefix:@".SFNS-"]) {
            NSDictionary *map = [self wm_UIFontNameWeightMap];
            UIFontWeight weight = [map[fontName] doubleValue];
            return [UIFont systemFontOfSize:fontSize weight:weight];
        }
    }
    return [UIFont fontWithName:fontName size:fontSize];
}

@end
